From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH] ALSA: control: ensure returning from
	blocked system-call after closing
Date: Sat, 25 Jul 2015 20:53:59 +0900
Message-ID: <1437825240-11222-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D5292606C9
 for <alsa-devel@alsa-project.org>; Sat, 25 Jul 2015 13:54:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some operations with blocking flag for ALSA control character devices don't
return to userspace when closing a file descriptor corresponding to the
character device. I think this is a bug of ALSA core.

While, I find no resources to assist this aspect. In a manual of
close(2)/read(2), there'no description about it. On SUSv2, there's
descriptions for pipe or FIFO for this behaviour, while nothing for
character devices. On Linux kernel documentation, I cannot find this kind of
explaination. Thus, I just stand on my experiences to use these operations
for files on filesystems, sockets and virtual character devices. It may
merely be due to my misunderstanding.

Well, additionally, in unsubscribed state, read operation for the character
device returns with EBADFD. On the other hand, in subscribed state and once
the operations are going to be blocked, they don't return to userspace even
if any unsubscribe ioctl(2) operations are executed. This losts a consistency
about the actual effects of unsubscribe operation.

It's my pleasure to discuss about these bugs (and my patch candidate to fix
them). You can see these bugs with this sample program. 

= Sample program =
#include <stdio.h>
#include <stdlib.h>

#include <errno.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <unistd.h>

#include <sys/ioctl.h>
#include <sound/asound.h>

#include <pthread.h>

static void *thread_run(void *arg)
{
    int fd = *(int *)arg;
    char buf[512] = {};

    while (read(fd, buf, sizeof(buf)) >= 0)
        ;

    return (void *)NULL;
}

int main(int argc, char *argv[])
{
    pthread_t thread = pthread_self();
    int fd;
    int subscribe;

    fd = open("/dev/snd/controlC0", O_RDONLY);
    if (fd < 0) {
        printf("%s\n", strerror(errno));
        return EXIT_FAILURE;
    }

    subscribe = 1;
    if (ioctl(fd, SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS, &subscribe) < 0) {
        printf("%s\n", strerror(errno));
        close(fd);
        return EXIT_FAILURE;
    }

    if (pthread_create(&thread, NULL, thread_run, (void *)&fd) < 0) {
        printf("%s\n", strerror(errno));
        close(fd);
        return EXIT_FAILURE;
    }

    sleep(1);

    if (argc == 1) {
        close(fd);
    } else {
        subscribe = 0;
        if (ioctl(fd, SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS, &subscribe) < 0) {
            printf("%s\n", strerror(errno));
            close(fd);
            return EXIT_FAILURE;
        }
    }

    /* Here, I expect blocking state of read(2) should be released. But... */
    pthread_join(thread, NULL);

    return EXIT_SUCCESS;
}

Takashi Sakamoto (1):
  ALSA: control: add .flush operation to release blocking operation

 sound/core/control.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

-- 
2.1.4
