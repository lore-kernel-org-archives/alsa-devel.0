From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Sun, 26 Sep 2010 07:56:29 +0800
Message-ID: <AANLkTi=4Uc_vy1xTZMzxy3Komt4up+OAAnioPZdAiO26@mail.gmail.com>
References: <4C595A52.7030401@gmx.de>
	<AANLkTimM9L=_Day945Y0XQZotLN7-HrXZbiWuO5dCO65@mail.gmail.com>
	<4C9DD21C.4000505@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 01C8E1037EE
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Sep 2010 01:56:31 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1011147ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2010 16:56:30 -0700 (PDT)
In-Reply-To: <4C9DD21C.4000505@gmx.de>
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

2010/9/25 Sebastian H. <vand2@gmx.de>

>
>
> snd_mixer_selem_is_active() has been ignored so far since I wasn't sure
> what it really meant.
>
> Seems the proper way to handle and *inactive* element is to hide the
> slider/switch/enum widgets completely.
> Alternatively they could be greyed out. But showing dead
> widgets would probably just distract users and waste screen space.
>
> Btw. I'm still working on a alsamixer-qt4. There've been just so many
> changes in the background that it takes some time to stabilize
> everything again. And there're still open issues (mostly QT stuff).
> So I would estimate two or three more weeks for a new release.
>

Seem I have quoted a wrong example

Refer to patch_via.c , when "Independent Headphone" switch is on/off,
In via_independent_hp_put() function call activate_ctl() which set the
"Headphone Playback volume" and "Headphone Playback switch" controls to
active/inactive

This mean that the controls are only temporary inactive and can become
active again
the driver also call snd_ctl_notify(codec->bus->card,
SNDRV_CTL_EVENT_MASK_VALUE, &ctl->id)

Does it mean that the mixer application receive an event about the change of
the active/inactive state of the control ?
