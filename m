From: Jan Homann <jh@janhomann.de>
Subject: Too many snd_pcm_mmap_readi calls
Date: Wed, 07 May 2014 09:18:48 +0200
Message-ID: <5369DE58.30208@janhomann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kunden1.comsitec.de (kunden1.comsitec.de [93.190.93.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 25E5E2652B7
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 09:18:51 +0200 (CEST)
Received: from [10.1.10.10] (p5DD876B6.dip0.t-ipconnect.de [93.216.118.182])
 by kunden1.comsitec.de (Postfix) with ESMTPSA id 67F65206074C
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 09:18:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi ALSA-Dev-List

I am very new to all this ALSA-Dev-stuff. For a few decades I have been
just an alsa user but now i try to develop a tiny sound recorder like
millions or thousands did before.
On the recorder there is a small while-loop for capturing the pcm data,
encode them and send them to a server every 10ms. On my desktop-pc and
on a Freescale i.mx 233 (ARMv5) the recorder is working quite well.
Now i run into a problem where the recorder is using all the cpu-time on
the arm-device for a few minutes. I tried to debug this behaviour
without any luck. Next i tried to trace the problem and removed as many
calls as possible and put a "gettimeofday" between every remaining call.
Here is the remaining code:
while(1) {

    sleep(1);
    gettimeofday(&time1,NULL);

    snd_pcm_wait( pcm_handle, REC_BUFFER_ELEMENT_SIZE_MS + 10);
    gettimeofday(&time2,NULL);

    snd_pcm_mmap_begin(pcm_handle, &my_areas, &offset, &frames);
    gettimeofday(&time2,NULL);

    snd_pcm_avail_update ( pcm_handle );
    gettimeofday(&time2,NULL);

    snd_pcm_mmap_readi( pcm_handle, network_data.data_UC, ALSA_READ_FRAMES);
    gettimeofday(&time3,NULL);

    snd_pcm_mmap_commit(pcm_handle, offset, frames);
    gettimeofday(&time4,NULL);
}

This is the output from strace:

0.001062 [401b418c] nanosleep({1, 0}, 0xbebd017c) = 0
1.001190 [401a4dac] gettimeofday({1399380864, 459211}, NULL) = 0
0.001032 [401de46c] ioctl(3, SNDRV_PCM_IOCTL_SYNC_PTR, 0x4e1b0) = 0
0.002780 [401a4dac] gettimeofday({1399380864, 463023}, NULL) = 0
0.001063 [401a4dac] gettimeofday({1399380864, 464086}, NULL) = 0
0.001031 [401de46c] ioctl(3, SNDRV_PCM_IOCTL_SYNC_PTR, 0x4e1b0) = 0
0.000968 [401a4dac] gettimeofday({1399380864, 466085}, NULL) = 0
0.001032 [401de46c] ioctl(3, SNDRV_PCM_IOCTL_SYNC_PTR, 0x4e1b0) = 0
0.000968 [401de46c] ioctl(3, SNDRV_PCM_IOCTL_SYNC_PTR, 0x4e1b0) = 0
0.000969 [401de46c] ioctl(3, SNDRV_PCM_IOCTL_SYNC_PTR, 0x4e1b0) = 0
0.001000 [401de46c] ioctl(3, SNDRV_PCM_IOCTL_SYNC_PTR, 0x4e1b0) = 0
0.002249 [401a4dac] gettimeofday({1399380864, 472678}, NULL) = 0
0.001438 [401a4dac] gettimeofday({1399380864, 473740}, NULL) = 0
0.001031 [40149518] rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
0.001218 [40149400] rt_sigaction(SIGCHLD, NULL, {SIG_DFL, [], 0}, 8) = 0
0.001562 [40149518] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
0.001032 [401b418c] nanosleep({1, 0}, ^CProcess 14219 detached

As you can see, the output starts with the sleep. I just added the sleep
to find my loop-start in the trace-outpus.
Before every gettimeofday there is one call to a snd_pcm-function (ok,
besides the sleep).
There is a block of four ioctl calls between the fourth and the fifth
gettimeofday. This sould be the sound_pcm_mmap_readi.
In the while loop there is only one call to sound_pcm_mmap_read and on
my desktop-pc trace even shows only one call to sound_pcm_mmap_readi.

Maybe anyone can explain to me why the function is called that often on
the arm-device?
Maybe you can give some hints on what to check for the high cpu utilization?

Any hints would be kindly appreciated.

Thanks in advance,
Jan Homann
