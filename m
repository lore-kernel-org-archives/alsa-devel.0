From: Tim Barnette <tim.barnette@gmail.com>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Mon, 2 Feb 2009 12:01:08 -0500
Message-ID: <b71cdde20902020901p2d68e3abs926d89458f74f735@mail.gmail.com>
References: <4983FE7A.1040201@wanadoo.fr> <49840333.2080303@wanadoo.fr>
	<b71cdde20902011434x690860d7jf9e1fc762ff2d3a9@mail.gmail.com>
	<s5h1vuh9w16.wl%tiwai@suse.de>
	<b71cdde20902020717qf508d38n742ef396171abce4@mail.gmail.com>
	<s5hzlh4dfnk.wl%tiwai@suse.de>
	<b71cdde20902020826g45f8d088n123332e98edfefcb@mail.gmail.com>
	<s5hiqnsdcqr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BC15243C6
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 18:01:09 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id v27so779774wah.16
	for <alsa-devel@alsa-project.org>; Mon, 02 Feb 2009 09:01:09 -0800 (PST)
In-Reply-To: <s5hiqnsdcqr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Jean=2DPierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

Thanks, a few more questions.. sorry I don't understand most of this..
1) hda-verb - I can't find this.. what is it? Where do I run it?
2) Inside of the snapshot, there are three steps (6, 7,8 below) that I need
help with..

6 - i already have /dev/snd with some stuff in it... so, I won't run this
step..
7 - edit it to do what?
8 - I dont know the name of my card..



6) Run the './snddevices' script to create new sound devices in /dev
directory.
   Skip this step, if you have already /dev/snd/* files, or if you're
   using a DEVFS or udev.

7) Edit your kernel module config (either /etc/modprobe.conf or
   /etc/modules.conf, depending on the kernel version). If you are not
   sure, what to do, you may try the alsaconf script available in
   the alsa-utils package.

8) Run 'modprobe snd-xxxx' where xxxx is the name of your card.
   Note: All ALSA ISA drivers support ISA PnP natively, so you don't need
         isapnptools any more.  Don't use both together.  It will
         conflict.  For disabling the ALSA ISA PnP support, specify
         --with-isapnp=no configure switch.

On Mon, Feb 2, 2009 at 11:28 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 2 Feb 2009 11:26:25 -0500,
> Tim Barnette wrote:
> >
> > Thanks, Takashi.  I tried installing the latest snapshot but wound up
> > recompiling a bunch of stuff (which my box is not configured for)... Is
> there
> > an easy way to download and install the latest snapshot?
>
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>
> > Is there a way to fix the 0x0d widget?  BIOS flash?  laptop seems kind of
> new
> > for that...
>
> Try the hda-verb command first to check whether it's really an issue
> of 0x0d.
>
>
> Takashi
>
> >
> > On Mon, Feb 2, 2009 at 10:25 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> >     At Mon, 2 Feb 2009 10:17:03 -0500,
> >     Tim Barnette wrote:
> >     >
> >     > Thanks, Takashi. I made this change and rebooted.
> >     >
> >     > I noticed right away the mute light is no longer on... but still no
> >     sound
> >     > through speakers, only headphones..
> >     >
> >     > /sys/module/snd_hda_intel/parameters/model
> >     > contains
> >     > hp-dv5,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
> >     >
> >     > attached is the alsa-info.txt you requested..
> >
> >     Did you try the latest alsa-driver snapshot?
> >
> >     If it still doesn't work, I guess this is a BIOS problem.
> >     The other HP dv laptops show the widget 0x0d as the speaker while
> >     yours is unused.
> >
> >     Try to run:
> >            hda-verb /dev/snd/hwC0D0 0x0d SET_PIN_WID 0x40
> >
> >     Takashi
> >
> >
>
