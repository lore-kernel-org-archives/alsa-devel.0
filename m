From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: my udev rules are breaking my dmixer setup why?
Date: Tue, 11 Nov 2008 12:01:22 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0811111151260.13649@tm8103.perex-int.cz>
References: <4916FAB7.7050206@powercraft.nl> <s5hhc6ezo3g.wl%tiwai@suse.de>
	<491953A4.8070509@powercraft.nl> <s5hljvqr1jr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A3D88103802
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 12:01:23 +0100 (CET)
In-Reply-To: <s5hljvqr1jr.wl%tiwai@suse.de>
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
Cc: Jelle de Jong <jelledejong@powercraft.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Nov 2008, Takashi Iwai wrote:

> > Almost all devices can be managed with udev rules, that is where the
> > system is designed for, there are also alsa rules in there, if they
> > don't work what is wrong then? is it an alsa issue, or udev, what are
> > the dependencies when alsa uses hardware. How are the /dev/snd/* devices
> > used and what is the /proc/asound/* for ?
> 
> The card index mechanism in ALSA was introduced much before udev
> was born.  It's just a legacy mechanism, but it's hard to kill without
> breaking the running system, unfortunately.

Note that you can identify your card via the text identification (check 
/proc/asound/cards to get it in []). You can set this identification in 
the module insert time and use for example 'hw:Intel' in your apps without 
bothering with indexes.

The missing part is the modification of this text identification using
sysfs at runtime for udev. Some time ago, I was trying to add this setup 
to /sys/class/sound, but the sysfs core code was not prepared for this 
change. I'll try to check the situation again.

					Jaroslav
-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
