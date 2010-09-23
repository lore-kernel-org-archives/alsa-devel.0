From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: Problems with ALSA driver
Date: Thu, 23 Sep 2010 14:53:13 -0700
Message-ID: <AANLkTikAzuKY4zXabqyVzc1JiW7b0yQA2NjFWkOVhkHN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AEFAD103962
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 23:53:13 +0200 (CEST)
Received: by wyb32 with SMTP id 32so37203wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2010 14:53:13 -0700 (PDT)
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

Hi All,
I am trying to write ALSA driver for my audio card. I have initial driver
version in place.
aplay -l gives:
**** List of PLAYBACK Hardware Devices ****
card 0: default [], device 0: myMonoCard []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

and aplay -L gives:

default:CARD=default
    Default Audio Device
null
    Discard all samples (playback) or generate zero samples (capture)

It seems to me that all looks good here but when I try:
aplay 101a.4.wav

Calling open method in the mono driver! (Output from my driver open method)
Calling hw_free method (Output from my driver hw_free method)
Calling close method in the mono driver! (Output from my driver close
method)
aplay: main:608: audio open error: Invalid argument

All my open method does is this:
int ret;
struct snd_pcm_runtime *runtime = substream->runtime;
printk ("Calling open method in the mono driver!\n");
 /*Associate the hardware capabilities of this PCM component */
 runtime->hw = monocard_playback_mono;
return 0;

and my struct snd_pcm_hardware monocard_playback_mono = {
    .info = (SNDRV_PCM_INFO_BLOCK_TRANSFER |
         SNDRV_PCM_INFO_RESUME |
         SNDRV_PCM_INFO_PAUSE),
    .formats = SNDRV_PCM_FMTBIT_S16_LE |
           SNDRV_PCM_FMTBIT_S16_BE |
           SNDRV_PCM_FMTBIT_S8 |
           SNDRV_PCM_FMTBIT_U8,
    .rates = SNDRV_PCM_RATE_CONTINUOUS,
    .rate_min = 8000,
    .rate_min = 48000,
    .channels_min = 1,
    .channels_max = 1,
    .buffer_bytes_max=32768,

I am not sure if alsa-lib is saying that one of these arguments is invalid
or what?
Thank you
Ogi
