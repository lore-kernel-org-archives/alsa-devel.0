From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixer-Qt 0.4.1 available
Date: Thu, 12 Aug 2010 08:10:44 +0800
Message-ID: <AANLkTin_exCQw8RG2Mhc-NBff+kTmRCeejtLZyTcVDZ7@mail.gmail.com>
References: <4C62C6DE.9020403@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8A9332437D
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 02:10:45 +0200 (CEST)
Received: by ewy21 with SMTP id 21so393130ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 17:10:45 -0700 (PDT)
In-Reply-To: <4C62C6DE.9020403@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/8/11 Sebastian H. <vand2@gmx.de>

> Hello again
>
> This is a bugfix release. Not all issues have been addressed, but
> hopefully the most annoying ones.
>
> 1.)
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3678
>
> The "EQ Peaks" mixer element gets skipped since there's not way to
> display it correctly at the moment.
> Also the mixer now looks for all element channels from 0 up to
> SND_MIXER_SCHN_LAST (= 31). Formerly it was only for the first 9 channels.
>
>

  control.12 {
         comment.access read
         comment.type INTEGER
         comment.count 20

The main problem  is this EQ peak control is read only and your
alsamixer-qt4-0.4.0 generate a lot of error messages when the user try to
move the slider , so the only way is to skip the volume control or implement
the equalizer peak using 10 qt4 vumeter widgets

[EE] EQ Peaks: snd_mixer_selem_set_playback_
volume_all: Operation not permitted





For CMI8788 , there is only one Master volume control controls with 8
channels volume control but it seem only has one mute switch

card hw:0 'CMI8788'/'C-Media Oxygen HD Audio (rev 2) at 0xec00, irq 17'
  Mixer name	: 'CMI8788'
  Components	: 'AK4396 AK5385 CMI8788'
  Controls      : 23
  Simple ctrls  : 12
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right - Rear Left - Rear Right
- Front Center - Woofer - Side Left - Side Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 112 [44%] [-7.14dB] [on]
  Front Right: Playback 112 [44%] [-7.14dB] [on]
  Rear Left: Playback 178 [70%] [-3.12dB] [on]
  Rear Right: Playback 178 [70%] [-3.12dB] [on]
  Front Center: Playback 178 [70%] [-3.12dB] [on]
  Woofer: Playback 178 [70%] [-3.12dB] [on]
  Side Left: Playback 178 [70%] [-3.12dB] [on]
  Side Right: Playback 178 [70%] [-3.12dB] [on]


	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 8
		comment.range '0 - 255'
		comment.dbmin -9999999
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 112
		value.1 112
		value.2 178
		value.3 178
		value.4 178
		value.5 178
		value.6 178
		value.7 178
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
