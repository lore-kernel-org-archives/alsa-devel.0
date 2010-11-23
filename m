From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: ALSA throwing buffers away?
Date: Tue, 23 Nov 2010 08:36:34 -0800
Message-ID: <AANLkTikppY6oP0Ha7_Hej9uNBubbOUs87cp85yq3SS-X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C66C103AA4
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 17:36:37 +0100 (CET)
Received: by bwz8 with SMTP id 8so7473315bwz.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 08:36:35 -0800 (PST)
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

Hello,
I am developing driver for a really simple hardware. Hardware has codec that
supports mono/stereo and the amplifier that supports only one speaker so the
driver has to be mono driver and the codec is setup to manage mono data. I
have setup ALSA with following parameters:

.info =            (SNDRV_PCM_INFO_NONINTERLEAVED |
                 SNDRV_PCM_INFO_BLOCK_TRANSFER |
                 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),

    .formats = SNDRV_PCM_FMTBIT_U16_LE |
           SNDRV_PCM_FMTBIT_U16_BE |
           SNDRV_PCM_FMTBIT_S16_LE |
           SNDRV_PCM_FMTBIT_S16_BE |
           SNDRV_PCM_FMTBIT_U8,
.channels_min = 1,
 .channels_max = 1,

Initially I was happy since sound started playing right away, but I noticed
that songs are skipping. I created buffers that collect statistics about
playback which is printed at the STOP trigger. The hardware is going through
ALSA circular buffer correctly, and ALSA is filling the buffer as the
hardware progresses, but after each buffer iteration ALSA skips the buffer
length of the data?! For example:
If buffer is .5 Mb ALSA will fill first .5Mb from the file into the buffer.
As the hardware is playing the sound ALSA fills the buffer starting 1.0 Mb
away from the begining of the file (the data from .5-1.0 Mb never makes it
to the buffer). This pattern repeats constantly to the end of the song. I
have tried SNDRV_PCM_INFO_INTERLEAVED with the same results (in this case
ALSA will not even try to play stereo files using my mono driver). The files
I tested are stereo and mono and they all behave the same. I am collecting
ALSA info in the snd_pcm_lib_write1 method in the pcm_lib.c file. I was
wondering if ALSA maybe deals with two circular buffers in the same time, or
if anybody has an idea what is going on here?

~cheers,
Ogi
