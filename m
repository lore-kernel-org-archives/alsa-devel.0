From: Alex Austin <circuitsoft.alex@gmail.com>
Subject: Re: need help with io plugin programming: how to add
	delay ?
Date: Tue, 22 Dec 2009 20:14:05 -0600
Message-ID: <53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>
References: <4B312435.800@gmail.com> <4B315163.5090404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 679312467B
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 03:14:06 +0100 (CET)
Received: by iwn2 with SMTP id 2so1885632iwn.16
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 18:14:05 -0800 (PST)
In-Reply-To: <4B315163.5090404@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Do you really need a socket, or are you just trying to move audio data from
one app to another? Check out jack and netjack. They may already provide the
functionality you need.

On Tue, Dec 22, 2009 at 5:08 PM, Stefan Schoenleitner <
dev.c0debabe@gmail.com> wrote:

> Hi,
>
> Stefan Schoenleitner wrote:
> > Another solution (my third one already) would be to introduce *no* delay
> > in the alsa plugin itself, but do everything in the application that is
> > listening on the socket.
> > For this reason the application would read one period, process the data
> > and then sleep for the rest of the time until the time for one period
> > (i.e. 20ms) is over.
> > After that the next period is read from the socket and so forth.
> > The alsa plugin would then "automatically" write new data to the socket
> > each time the application listening to that socket reads data and there
> > is free space in the socket send buffer.
>
> I now tested this idea by writing a simple socket reader and writer (see
> code below).
>
> The writer just sends data (160 bytes each) over the socket as soon as the
> socket is available for writing.
> (For this reason if no one is reading from the other end of the socket, it
> just fills up the socket buffer and then blocks).
>
> The counterpart of the writer is the reader application that should control
> the timing (as I mentioned in my previous post).
> For this reason it basically just reads a chunk of data (160 bytes each)
> from the socket and then sleeps until a certain amount of time (20ms, i.e.
> one period) is over.
>
> However, the result is not satisfying at all as the delay between the
> received chunks varies and sometimes even takes a whole 15ms (!) longer
> (i.e. 35ms delay instead of 20ms).
>
> Here is some example output of the reader:
>
> last recv 23.691140ms ago
> sleeping for 9ms
> last recv 20.127908ms ago
> sleeping for 9ms
> last recv 20.105699ms ago
> sleeping for 9ms
> last recv 20.052133ms ago
> sleeping for 9ms
> last recv 20.116666ms ago
> sleeping for 3ms
> last recv 25.770387ms ago
> sleeping for 6ms
> last recv 21.651706ms ago
> sleeping for 9ms
> last recv 36.320541ms ago
> sleeping for 5ms
> last recv 20.348258ms ago
>
>
> As the calculation of the sleep time uses an *absolute* point of time
> as reference (which is takes before starting to poll() and recv() from the
> socket), all delay after the time measurement and before the actual sleep
> does not influence the precision, right ?
> For this reason I have no idea where the high delay variations are coming
> from.
> I mean how should it work with an alsa plugin if not even this simple
> simulation code works
> in a timely and precise manner ?
>
> * What am I doing wrong ?
>
> I thought of adding buffering so that the socket read operations do not
> have a strict timing schedule.
> However, as I said earlier, if the time for socket polling or recv varies,
> it does not influence the precision as an absolute point of time is used as
> timeout and the (absolute) start time measurement is done *before* all the
> socket operations.
> Thus I think that for this reason adding buffering would not make much
> difference here, right ?
>
> Maybe you can have a quick look at the code snippets ?
> The reader is pretty much what I would be doing in my daemon that should
> receive the PCM samples from the alsa plugin.
>
> cheers,
> stefan
>
>
>
> ---------------------------- reader.c ----------------------------
> #define _POSIX_C_SOURCE 199309L
> #define _BSD_SOURCE
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <time.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <sys/un.h>
> #include <string.h>
> #include <errno.h>
> #include <pthread.h>
> #include <poll.h>
> #include <assert.h>
>
> #define SOCK_PATH       "/tmp/pcm.socket"
> #define PCM_BUFFERSIZE  160
>
> /* adapted from glibc sys/time.h timersub() macro */
> #define priv_timespecsub(a, b, result)                  \
>    do {                                \
>        (result)->tv_sec = (a)->tv_sec - (b)->tv_sec;       \
>        (result)->tv_nsec = (a)->tv_nsec - (b)->tv_nsec;    \
>        if ((result)->tv_nsec < 0) {                \
>            --(result)->tv_sec;             \
>            (result)->tv_nsec += 1000000000;        \
>        }                           \
>    } while (0)
>
> #define priv_timespecadd(a, b, result)                  \
>    do {                                \
>        (result)->tv_sec = (a)->tv_sec + (b)->tv_sec;       \
>        (result)->tv_nsec = (a)->tv_nsec + (b)->tv_nsec;    \
>        if ((result)->tv_nsec >=1000000000L) {                \
>            ++(result)->tv_sec;             \
>            (result)->tv_nsec -= 1000000000L;        \
>        }                           \
>    } while (0)
>
> pthread_mutex_t timer_mutex = PTHREAD_MUTEX_INITIALIZER;
> pthread_cond_t timer_condition = PTHREAD_COND_INITIALIZER;
>
> int main(void)
> {
>        int s, s2, t, len, ret;
>        struct sockaddr_un local, remote;
>        char buf[PCM_BUFFERSIZE];
>        struct timespec start, now, period_time, delta, timeout;
>        struct timespec prev, delta_prev;
>        struct pollfd fds;
>        unsigned int poll_timeout;
>
>        // one period is 20ms
>        period_time.tv_sec=0;
>        period_time.tv_nsec = 20 * 1000000L;
>        poll_timeout = period_time.tv_nsec / 1000000L;
>
>
>        if ((s = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
>                perror("socket");
>                exit(1);
>        }
>
>        local.sun_family = AF_UNIX;
>        strcpy(local.sun_path, SOCK_PATH);
>        unlink(local.sun_path);
>        len = strlen(local.sun_path) + sizeof(local.sun_family);
>        if (bind(s, (struct sockaddr *)&local, len) == -1) {
>                perror("bind");
>                exit(1);
>        }
>
>        if (listen(s, 0) == -1) {
>                perror("listen");
>                exit(1);
>        }
>
>        start.tv_sec=0;
>        start.tv_nsec=0;
>
>        for(;;) {
>                int done, n;
>                printf("Waiting for a connection...\n");
>                t = (int)sizeof(remote);
>                if ((s2 = accept(s, (struct sockaddr *)&remote, (unsigned
> int *)&t)) == -1) {
>                        perror("accept");
>                        exit(1);
>                }
>
>                printf("Connected.\n");
>
>                done = 0;
>
>                fds.fd = s2;
>                fds.events = POLLIN;
>
>                // sleep for some time so that socket buffer fills up
>                usleep(80000);
>
>                clock_gettime(CLOCK_REALTIME, &start);
>
>                do {
>                        memcpy(&prev, &start, sizeof(struct timespec));
>                        clock_gettime(CLOCK_REALTIME, &start);
>
>                        // use poll to check out when we can read
>                        if ((ret = poll(&fds, 1, poll_timeout))<0)
>                        {
>                                perror("poll");
>                                exit(1);
>                        }
>
>                        if (ret == 0)
>                        {
>                                printf("timeout --> underflow\n");
>                                continue;
>                        }
>
>                        assert (ret == 1 && (fds.revents & POLLIN));
>
>                        priv_timespecadd(&start, &period_time, &timeout);
>                        //printf("timeout at %li:%li\n", timeout.tv_sec,
> timeout.tv_nsec/1000000L);
>
>                        priv_timespecsub(&start, &prev, &delta_prev);
>                        printf("last recv %fms ago\n",
> delta_prev.tv_sec*1000.0 + delta_prev.tv_nsec/1000000.0);
>
>                        n = recv(s2, buf, PCM_BUFFERSIZE, MSG_DONTWAIT);
>                        if (n <= 0) {
>                                if (n < 0) perror("recv");
>                                done = 1;
>                                break;
>                        }
>
>                        // -------------------------- BEGIN PROCESSING BLOCK
> --------------------------
>                        assert (n==PCM_BUFFERSIZE);
>                        //printf("received %i bytes at %li:%li\n", n,
> start.tv_sec, start.tv_nsec/1000000L);
>
>                        // process data (requires some amount of time)
>                        usleep(10000);
>
>
>                        // --------------------------  END PROCESSING BLOCK
>  --------------------------
>
>                        // sleep for the rest of the time until the period
> is over
>                        clock_gettime(CLOCK_REALTIME, &now);
>                        //printf("now: %li:%li\n", now.tv_sec,
> now.tv_nsec/1000000L);
>                        priv_timespecsub(&timeout, &now, &delta);
>
>
>                        if ((now.tv_sec >= timeout.tv_sec) && (now.tv_nsec
> >= timeout.tv_nsec))
>                        {
>                                printf("we're late, don't sleep\n");
>                        }
>                        else
>                        {
>
>                                printf("sleeping for %lims\n",
> delta.tv_sec*1000 + delta.tv_nsec/1000000L);
>                                //nanosleep(&delta, NULL);
>
>
>                                // wait for absolute timeout using a fake
> pthread condition which is never signaled
>                                pthread_mutex_lock(&timer_mutex);
>                                pthread_cond_timedwait(&timer_condition,
> &timer_mutex, &timeout);
>                                pthread_mutex_unlock(&timer_mutex);
>                        }
>
>                } while (!done);
>
>                close(s2);
>        }
>
>        return 0;
> }
> ------------------------------------------------------------------
>
>
>
> ---------------------------- writer.c ----------------------------
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <errno.h>
> #include <string.h>
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <sys/un.h>
> #include <poll.h>
> #include <assert.h>
>
> #define SOCK_PATH "/tmp/pcm.socket"
> #define PCM_BUFSIZE 160
>
> int main(void)
> {
>        int s, len;
>        struct sockaddr_un remote;
>        char str[PCM_BUFSIZE];
>        struct pollfd fds;
>        int ret;
>        int value;
>        unsigned int optlen;
>
>        if ((s = socket(AF_UNIX, SOCK_STREAM, 0)) == -1) {
>                perror("socket");
>                exit(1);
>        }
>
>
>    // set send buffer size
>        // man 7 socket --> The minimum value for this option is 2048.
>    value=2048;
>    if (setsockopt(s, SOL_SOCKET, SO_SNDBUF, &value, sizeof(value))<0)
>    {
>        perror("setsockopt()");
>        return -1;
>    }
>
>    // check size
>        optlen=sizeof(value);
>    if (getsockopt(s, SOL_SOCKET, SO_SNDBUF, &value, &optlen)<0)
>    {
>        perror("getsockopt()");
>        return -1;
>    }
>
>        printf("optlen = %i, value: %i\n", optlen, value);
>        assert (optlen == sizeof(value));
>
>    printf("send buffer size is %i bytes\n", value);
>
>
>        printf("Trying to connect...\n");
>
>        remote.sun_family = AF_UNIX;
>        strcpy(remote.sun_path, SOCK_PATH);
>        len = strlen(remote.sun_path) + sizeof(remote.sun_family);
>        if (connect(s, (struct sockaddr *)&remote, len) == -1) {
>                perror("connect");
>                exit(1);
>        }
>
>        printf("Connected.\n");
>
>        // set up poll fds
>        fds.fd = s;
>        fds.events = POLLOUT;   // writing now will not block
>
>
>        while(1)
>        {
>                // poll socket to see if it's ready, timeout: 20 ms
>                ret = poll(&fds, 1, 20);
>
>                if (ret<0)
>                {
>                        perror("poll");
>                        exit(1);
>                }
>
>                if (ret==0)
>                {
>                        printf("timeout\n");
>                        continue;
>                }
>
>                if (fds.revents & (POLLERR | POLLHUP | POLLNVAL))
>                {
>                        printf("POLLERR | POLLHUP | POLLNVAL)\n");
>                        exit(1);
>                }
>
>                if (fds.revents == POLLOUT)
>                        printf("POLLOUT, we can write now ..\n");
>                else
>                        printf("revent is not POLLOUT !\n");
>
>
>                // send PCM_BUFSIZE bytes
>                if ((ret=send(s, str, PCM_BUFSIZE, MSG_DONTWAIT))<0) {
>                        perror("send");
>                        exit(1);
>                }
>
>                printf("sent %i bytes\n", ret);
>        }
>
>        // never reached
>        close(s);
>
>        return 0;
> }
> ------------------------------------------------------------------
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
