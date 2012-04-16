From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 7
Date: Mon, 16 Apr 2012 22:00:27 +1000
Message-ID: <CACckToX_cuWoZ_7qZ=fq9myakuLQ4NMvJLUH2ku1AZ7MaKmHYQ@mail.gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
	<CACckToUX5iLjbdtjsEFOPk1uBw63EBROe=bj9qokaczB6P5LrQ@mail.gmail.com>
	<CACckToU+zq2jrPFRJmYGA05REtfPkRjf05JqiGY+bSyDkk=p+w@mail.gmail.com>
	<4F87C587.9000101@gmail.com> <s5hiph4qhep.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id B4DC42436C
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 14:00:27 +0200 (CEST)
Received: by werg1 with SMTP id g1so3398159wer.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2012 05:00:27 -0700 (PDT)
In-Reply-To: <s5hiph4qhep.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

> > What about alsactl? Set the mixers once, then call "alsactl store". Does
> > that help?
>
>
Yes it does. however.. nothing in userspace calls alsactl restore on device
hotplug.

is this a udev/distribution problem or alsa's problem?



> Basically "alsactl init" then "alsactl restore" should initialize to
> a sane state.  But in the case of usb-audio, many things are still
> missing.
>
> The usb-audio driver doesn't initialize the mixer states unlike other
> drivers, and alsactl init seems assuming that the mixers are all muted
> / cleared when it's called.  So, partly a problem of alsactl init.
>
>
>
So alsactl store Ultra after setting all the controls and then running
alsactl restore works..

BUT.. I'm still stuck with a very similar problem in that nothing seems to
call alsaclt restore when the device is hotplugged.

Grant.
