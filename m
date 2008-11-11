From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: my udev rules are breaking my dmixer setup why?
Date: Tue, 11 Nov 2008 18:55:26 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0811111845330.13649@tm8103.perex-int.cz>
References: <4916FAB7.7050206@powercraft.nl> <s5hhc6ezo3g.wl%tiwai@suse.de>
	<491953A4.8070509@powercraft.nl> <s5hljvqr1jr.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0811111151260.13649@tm8103.perex-int.cz>
	<4919C148.3060706@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D28422442C
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 18:55:26 +0100 (CET)
In-Reply-To: <4919C148.3060706@powercraft.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jelle de Jong <jelledejong@powercraft.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Nov 2008, Jelle de Jong wrote:

> Jaroslav Kysela wrote:
> > On Tue, 11 Nov 2008, Takashi Iwai wrote:
> > 
> >>> Almost all devices can be managed with udev rules, that is where the
> >>> system is designed for, there are also alsa rules in there, if they
> >>> don't work what is wrong then? is it an alsa issue, or udev, what are
> >>> the dependencies when alsa uses hardware. How are the /dev/snd/* devices
> >>> used and what is the /proc/asound/* for ?
> >> The card index mechanism in ALSA was introduced much before udev
> >> was born.  It's just a legacy mechanism, but it's hard to kill without
> >> breaking the running system, unfortunately.
> > 
> > Note that you can identify your card via the text identification (check 
> > /proc/asound/cards to get it in []). You can set this identification in 
> > the module insert time and use for example 'hw:Intel' in your apps without 
> > bothering with indexes.
> > 
> > The missing part is the modification of this text identification using
> > sysfs at runtime for udev. Some time ago, I was trying to add this setup 
> > to /sys/class/sound, but the sysfs core code was not prepared for this 
> > change. I'll try to check the situation again.
> > 
> 
> As response to:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-November/012366.html
> 
> I am not sure if it is good practice to repose to an RFC if so please
> tell me then we will continue the discussion in the RFC thread.
> 
> Thank you Jaroslav for creating the patch this is really appreciated, if
> all things work I will send you some dutch stroopwafels :-D
> 
> I am just curious how you patch can be used with udev? What did you have
> in mind?
> 
> Would something like this be possible:
> 
> SUBSYSTEM=="sound", ACTION="add" KERNELS=="3-1",
> NAME="snd/by-id/audiodevice0"
> SUBSYSTEM=="sound", ACTION="add" KERNELS=="3-2",
> NAME="snd/by-id/audiodevice1"

No, something like this:

SUBSYSTEM=="sound", ACTION=="add", KERNEL=="controlC*", KERNELS=="3-2", \
  ATTR{device/id}="audiodevice1"

> pcm.!default {
>    type plug
>    slave.pcm dmixer
> }
> pcm.dmixer {
>    type dmix
>    ipc_key 1024
>    slave.pcm hw:audiodevice0
> }

This looks OK.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
