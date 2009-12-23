From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: need help with io plugin programming: how to add
 delay ?
Date: Wed, 23 Dec 2009 09:55:29 +0100
Message-ID: <4B31DB01.4050308@gmail.com>
References: <4B312435.800@gmail.com> <4B315163.5090404@gmail.com>
	<53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 96D66103827
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 09:55:36 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 919C94BEE9
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 09:55:34 +0100 (CET)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39jdnLHAwJBS for <alsa-devel@alsa-project.org>;
	Wed, 23 Dec 2009 09:55:34 +0100 (CET)
Received: from [192.168.1.132] (85-127-149-164.dynamic.xdsl-line.inode.at
	[85.127.149.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id E9E9E4BE05
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 09:55:33 +0100 (CET)
In-Reply-To: <53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I tracked down the timing problem even more and write another piece of testing code (see below).
The code should just do something each 20ms.
I discovered that using printf() in critical section is not a good idea as it introduces
unwanted delay that is not calculated in the timeout.
You can test it by setting DO_PRINTF to 1.

However, if no printf()'s are performed I still do not get a precise delay of 20ms +/- 1ms (even with realtime priority).
See example output here:

----------------------------------------------------------------------
$ sudo nice -n-19 ./test-timer

delay[ 0]: 0.007194ms
delay[ 1]: 21.125031ms	--> thats too long :(
delay[ 2]: 20.112892ms
delay[ 3]: 20.113100ms
delay[ 4]: 20.121551ms
delay[ 5]: 22.959203ms	--> thats too long :(
delay[ 6]: 20.131611ms
delay[ 7]: 20.145507ms
delay[ 8]: 20.131889ms
delay[ 9]: 20.145649ms
delay[10]: 20.142365ms
----------------------------------------------------------------------

* How can I deal with the problem ?
* Where does the unwanted delay come from ?

cheers,
stefan



---------------------------- timer-test.c ----------------------------
#define _POSIX_C_SOURCE 199309L
#define _BSD_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>
#include <poll.h>
#include <assert.h>

#define DELAYSTAMPS	30
#define DO_PRINTF	0

/* adapted from glibc sys/time.h timersub() macro */
#define priv_timespecsub(a, b, result)                  \
    do {                                \
        (result)->tv_sec = (a)->tv_sec - (b)->tv_sec;       \
        (result)->tv_nsec = (a)->tv_nsec - (b)->tv_nsec;    \
        if ((result)->tv_nsec < 0) {                \
            --(result)->tv_sec;             \
            (result)->tv_nsec += 1000000000;        \
        }                           \
    } while (0)

#define priv_timespecadd(a, b, result)                  \
    do {                                \
        (result)->tv_sec = (a)->tv_sec + (b)->tv_sec;       \
        (result)->tv_nsec = (a)->tv_nsec + (b)->tv_nsec;    \
        if ((result)->tv_nsec >=1000000000L) {                \
            ++(result)->tv_sec;             \
            (result)->tv_nsec -= 1000000000L;        \
        }                           \
    } while (0)

pthread_mutex_t timer_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t timer_condition = PTHREAD_COND_INITIALIZER;

int main(void)
{
	int t, len, ret;
	struct timespec start, now, period_time, delta, timeout;
	struct timespec prev, delta_prev;
	double delaystamps[DELAYSTAMPS];
	int i;

	// one period is 20ms
	period_time.tv_sec=0;
	period_time.tv_nsec = 20 * 1000000L;

	start.tv_sec=0;
	start.tv_nsec=0;

	clock_gettime(CLOCK_REALTIME, &start);

	for (i=0; i<DELAYSTAMPS; i++)
	{
		memcpy(&prev, &start, sizeof(struct timespec));
		clock_gettime(CLOCK_REALTIME, &start);

		priv_timespecadd(&start, &period_time, &timeout);
		//printf("timeout at %li:%li\n", timeout.tv_sec, timeout.tv_nsec/1000000L);

		priv_timespecsub(&start, &prev, &delta_prev);

#if (DO_PRINTF==1)
		printf("last action %fms ago\n", delta_prev.tv_sec*1000.0 + delta_prev.tv_nsec/1000000.0);
#endif

		delaystamps[i]=delta_prev.tv_sec*1000.0 + delta_prev.tv_nsec/1000000.0;

		// -------------------------- BEGIN PROCESSING BLOCK --------------------------

		// process data (requires some amount of time)
		usleep(10000);

		
		// --------------------------  END PROCESSING BLOCK  --------------------------
		
		// sleep for the rest of the time until the period is over
		clock_gettime(CLOCK_REALTIME, &now);
		priv_timespecsub(&timeout, &now, &delta);
		

		if ((now.tv_sec >= timeout.tv_sec) && (now.tv_nsec >= timeout.tv_nsec))
		{
			//printf("we're late, don't sleep\n");
		}
		else
		{
#if (DO_PRINTF==1)
			printf("sleeping for %lims\n", delta.tv_sec*1000 + delta.tv_nsec/1000000L);
#endif
			//nanosleep(&delta, NULL);


			// wait for timeout using a fake pthread condition which is never signaled
			pthread_mutex_lock(&timer_mutex);
			pthread_cond_timedwait(&timer_condition, &timer_mutex, &timeout);
			pthread_mutex_unlock(&timer_mutex);
		}

	}

	// print delay timestamps
	for (i=0; i<DELAYSTAMPS; i++)
	{
		printf("delay[%2i]: %fms", i, delaystamps[i]);
		if (delaystamps[i] > 21)
			printf("\t--> thats too long :(");
		printf("\n");
	}

	return 0;
}

----------------------------------------------------------------------
