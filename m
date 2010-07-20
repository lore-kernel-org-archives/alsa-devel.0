From: VDR User <user.vdr@gmail.com>
Subject: Audio dropouts with pcm_hw.c: snd_pcm_hw_delay()
	SNDRV_PCM_IOCTL_DELAY failed (-32).
Date: Tue, 20 Jul 2010 11:24:04 -0700
Message-ID: <AANLkTikALRDtTQNtTTIRX4h5NOkPrVEye3STRjLrlDzN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 22825103909
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 20:24:07 +0200 (CEST)
Received: by yxm8 with SMTP id 8so1540643yxm.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2010 11:24:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi.  I've been experiencing audio drops on dvb streams that use ac3
audio (h264+ac3 hdtv streams) and occasionally mp2 audio (sdtv
channels) .  When the ac3 audio drops out, it usually recovers after a
few seconds though sometimes it never does.  When mp2 drops out, it
almost never recovers.  Retuning the channel always fixes the drop
out.  When this happens there's usually no interruption in the video
so I question whether stream errors are causing the problem.

When a dropout occurs, I always see the following in my xine log:
pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed (-32).

I (and others apparently) have been experiencing this problem for
quite some time.  I have read about and tried adding notsc to no
kernel boot line, which has had no affect.  Here's a clip from the
most recent drop outs:

audio jump, diff=-90720
pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed (-32).
audio_out: inserting 21713 0-frames to fill a gap of 40723 pts
video_out: throwing away image with pts 176336725 because it's too old
(diff : 10842).
video_out: throwing away image with pts 176339939 because it's too old
(diff : 16618).
video jump
200 frames delivered, 0 frames skipped, 2 frames discarded
video jump
audio jump, diff=-103680
pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed (-32).
audio_out: inserting 21233 0-frames to fill a gap of 39823 pts
video_out: throwing away image with pts 183068800 because it's too old
(diff : 6699).
video jump
video_out: throwing away image with pts 183071835 because it's too old
(diff : 12728).
pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed (-32).
200 frames delivered, 0 frames skipped, 2 frames discarded

Some system specs are:
debian testing
kernel 2.6.34.1
alsa-base 1.0.23+dfsg-1
alsa-utils 1.0.23-2
alsa drivers compiled from today's snapshot (2010-07-20).

in /etc/modprobe.d/alsa-base.conf:
options snd-hda-intel enable_msi=1 probe_mask=0xffff,0xfff2

lsmod:
snd_hda_codec_nvhdmi     9750  1
snd_hda_intel          14764  0
snd_hda_codec          48881  2 snd_hda_codec_nvhdmi,snd_hda_intel
snd_hwdep               3566  1 snd_hda_codec
snd_pcm                44172  2 snd_hda_intel,snd_hda_codec
snd_timer              11991  1 snd_pcm
snd                    28664  6
snd_hda_codec_nvhdmi,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer
soundcore                548  1 snd
snd_page_alloc          4669  2 snd_hda_intel,snd_pcm

I'd greatly appreciate any help in getting this problem worked out and
hopefully solved once and for all.  Thanks in advance for _anything_.

Best regards,
Derek
