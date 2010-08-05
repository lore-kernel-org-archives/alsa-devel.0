From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Thu, 5 Aug 2010 15:20:38 +0800
Message-ID: <AANLkTim=OvWfYgvRLvGgELg5AiJPYZk0snkEHSxxdcaC@mail.gmail.com>
References: <4C595A52.7030401@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BD0E52443A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 09:20:39 +0200 (CEST)
Received: by eye27 with SMTP id 27so2156431eye.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 00:20:39 -0700 (PDT)
In-Reply-To: <4C595A52.7030401@gmx.de>
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

2010/8/4 Sebastian H. <vand2@gmx.de>

> Hello everyone
>
> I've been working on Alsamixer-Qt4 lately and compiled
> the changes into a new release version 0.4.0.
> Most importantly the cards list can be refreshed now
> and the style got a little overhaul, too.
> A more detailed changelog can be found at the xwmw.org page.
>
> The new version 0.4.0 is available at the known places.
> http://xwmw.org/alsamixer-qt4/
> http://sourceforge.net/projects/alsamixer-qt4/files/
>
> Any comments are welcome.
>

1) au8830 Equalizer
you can find the screenshot of the equalizer ( gnome volume control) and the
correct implementation of the equalizer of the vortexcontrol and python
version of the equalizer

the asound.state of au8830

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3678



2) CMI8788 's 8 Channels Master Volume Control

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4204

Card hw:0 'CMI8788'/'C-Media Oxygen HD Audio (rev 2) at 0xec00, irq 17'

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


state.CMI8788 {
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
