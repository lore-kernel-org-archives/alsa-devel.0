From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: ALSA alsaSink and NONINTERLEAVED vs INTERLEAVED
Date: Thu, 23 Dec 2010 15:14:14 -0800
Message-ID: <AANLkTimJqsByKjAZnu4FmQRpzV-aEhjnNKhsNBrCgLMh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 84B69245BF
	for <alsa-devel@alsa-project.org>; Fri, 24 Dec 2010 00:14:14 +0100 (CET)
Received: by wwe15 with SMTP id 15so6390024wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 15:14:14 -0800 (PST)
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
I have a simple sound card with a stereo output. The driver works just fine
when using aplay or gstreamer to play wave files. The problem occurs when I
am trying to play videos through gstreamer. I use following gstremaer
pipeline (just to test sound):
gst-launch-0.10 filesrc location=MPEG4_MOVIE_NAME ! qtdemux name=t !  queue
! faad ! alsasink

If I make my driver with following settings:
.info =            (SNDRV_PCM_INFO_INTERLEAVED |
                 SNDRV_PCM_INFO_BLOCK_TRANSFER |
                 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),

gstreamer comes back with a following message:
Pipeline is PREROLLING ...
ERROR: from element /GstPipeline:pipeline0/GstAlsaSink:alsasink0: Could not
get/set settings from/on resource.
Additional debug info:
gstalsasink.c(519): set_hwparams ():
/GstPipeline:pipeline0/GstAlsaSink:alsasink0:
Unable to set hw params for playback: Invalid argument
ERROR: pipeline doesn't want to preroll.
Setting pipeline to NULL ...

If I make my driver with following settings:
.info =            (SNDRV_PCM_INFO_NONINTERLEAVED |
                 SNDRV_PCM_INFO_BLOCK_TRANSFER |
                 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
gstreamer will play sound. Of course sound will not be correct since the
data is interleaved. Any idea why is this happening?

Here is the rest of the snd_pcm_hardware struct:

    .formats = SNDRV_PCM_FMTBIT_U16_LE |
           SNDRV_PCM_FMTBIT_U16_BE |
           SNDRV_PCM_FMTBIT_S16_LE |
           SNDRV_PCM_FMTBIT_S16_BE |
           SNDRV_PCM_FMTBIT_U8,
    .rates = SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_CONTINUOUS,
    .rate_min = 8000,
    .rate_max = 48000,
    .channels_min = 1,
    .channels_max = 2,
    .period_bytes_min = 16384,
    .period_bytes_max = 16384*4,
    .periods_min =      4,
    .periods_max =      256,
    .buffer_bytes_max= 131072,

Cheers
Ogi
