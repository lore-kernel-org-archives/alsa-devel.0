From: "Bankim Bhavsar" <bankim.bhavsar@gmail.com>
Subject: dmix in a forked process
Date: Sat, 2 Aug 2008 19:45:04 -0700
Message-ID: <4eccebac0808021945s66b362e3u51ecedea830a04e4@mail.gmail.com>
References: <4eccebac0808012003j49ea4351pc34f3f1ed7690f15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B7E3103802
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Aug 2008 04:45:05 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so2104989wfg.23
	for <alsa-devel@alsa-project.org>; Sat, 02 Aug 2008 19:45:04 -0700 (PDT)
In-Reply-To: <4eccebac0808012003j49ea4351pc34f3f1ed7690f15@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Don't know why the earlier message got truncated so here it is again...

Reading the source alsa-lib I see that dmix runs in a forked process
*without* exec.

file: src/pcm/pcm_direct.c
function: snd_pcm_direct_server_create

       ret = fork();
       if (ret < 0) {
               close(dmix->server_fd);
               return ret;
       } else if (ret == 0) {
               ret = fork();
               if (ret == 0)
                       server_job(dmix);
               _exit(EXIT_SUCCESS);
       } else {
               waitpid(ret, NULL, 0);
       }

>From what I understand, this is a concern since if our app is the
first to start dmix then a copy of the process (app) will remain till
the system is shutdown ?

Also I see that from alsa-lib 1.0.12 a check is performed before starting dmix.

file: src/pcm/pcm_dmix.c
function: snd_pcm_dmix_open

               if (dmix->shmptr->use_server) {
                       dmix->server_free = dmix_server_free;

                       ret = snd_pcm_direct_server_create(dmix);
                       if (ret < 0) {
                               SNDERR("unable to create server");
                               goto _err;
                       }
               }

When I checked how dmix->shmptr->use_server is set

file: src/pcm/pcm_dmix.c
function: snd_pcm_direct_initialize_slave

               int ver = 0;
               ioctl(spcm->poll_fd, SNDRV_PCM_IOCTL_PVERSION, &ver);
               if (ver < SNDRV_PROTOCOL_VERSION(2, 0, 8))
                       dmix->shmptr->use_server = 1;

So if sndrv version is older than 2.0.8, use_server is set!

So even using alsa-lib greater than 1.0.12 doesn't guarantee that the
forked process (without exec) code path will be avoided.

I'm currently porting the sound code of our app from OSS to ALSA but
this problem is preventing me from doing so.
Is there any way to get around this problem?

Help here will be greatly appreciated.

If this is an incorrect list then kindly fwd it to the appropriate one.

Thanks,
Bankim.

PS: I've tried using the ioctl mentioned above after copying the
necessary macros from kernel headers but ioctl returns error
"Inappropriate ioctl for this device" on my Ubuntu 7.04 host.
