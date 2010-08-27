From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: explicit commandline control of speakers vs
 headphone output
Date: Sat, 28 Aug 2010 07:26:38 +0800
Message-ID: <AANLkTinOchsjwU5543eDh5vMHZkTaw_JMFs2orOL-gR0@mail.gmail.com>
References: <210284.64008.qm@web50707.mail.re2.yahoo.com>
	<4C78116D.9040704@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6989A1038BE
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 01:26:39 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2424239eyd.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 16:26:39 -0700 (PDT)
In-Reply-To: <4C78116D.9040704@canonical.com>
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

2010/8/28 David Henningsson <david.henningsson@canonical.com>

> 2010-08-27 20:46, Eric Holstege skrev:
> > Thanks, Clemens;
> >
> > How were you able to determine that from the "amixer scontents" output.
> >
> > Although I can't disable *automatic* speaker mute on headphone
> > insertion, can I explicitly unmute them again (e.g. with amixer sset or
> > cset)?
> >
> > If not....
> > "cat /proc/asound/card*/codec*" says it is the Realtek ALC888.
> > Does this mean I have to somehow patch the kernel sound module file
> > .../linux-source-2.6.*/sound/pci/hda/patch_realtek.c
> > to fix this somehow?
>
> So in the long run, I think it would be better to leave all auto-muting
> to userspace. Then stuff like pulseaudio could to advanced decision of
> how to handle input events. But that's the long way.
>
> There are certainly ways to disable auto-muting for Realtek ALC888, look
> along the lines of "speaker_automute" and "unsol_event". It is also
> possible that you could tweak your user_pin_config to trick your HP out
> into a Line Out. That way it won't automute, and you don't have to
> recompile your kernel.
>
> As a side note: The VIA HDA driver, I believe, have an option for
> turning automute off. But it also sets "mute" on a misnamed control at
> the same time, tricking PA into believing that you want to mute all
> output. So PA is "helpful" and mutes everything else as well. :-/
>
>
Some of the VIA codec allow independent headphone and the extra DAC and ADC
(i.e. subdevice 1)  can only be connected to headphone  and mic .at front
panel

the current implementation of the driver is buggy , since the sudevice 0
support multi channels but sudevice 1 only support 2 channels
