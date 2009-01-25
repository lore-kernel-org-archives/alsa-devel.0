From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: Re: Cannot record from front pluggable mic on 82801H
	(ICH8 Family) sound card
Date: Sun, 25 Jan 2009 17:37:10 +0100
Message-ID: <200901251737.10497.cave.dnb2m97pp@aliceadsl.fr>
References: <ef2423ab0901090857l1b592e34yd340f69c5c65fb92@mail.gmail.com>
	<200901181756.52285.cave.dnb2m97pp@aliceadsl.fr>
	<ef2423ab0901250609m62020357u57a2636f102ae1f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id E2FDE243F1
	for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2009 17:39:58 +0100 (CET)
In-Reply-To: <ef2423ab0901250609m62020357u57a2636f102ae1f0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vincent <zakora@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 25 January 2009 15:09, Vincent wrote:
> I tried everything you said, but the problem remains. I tried to put a
> reference board in modprobe.conf but I get no output sound, sounds weird
> because on the archwiki page of the Dell
> 1525<http://wiki.archlinux.org/index.php/Dell_Inspiron_1525>there is
> the 3stack option...
> I attached the alsa-info.txt (with the 3stack option enabled). The
> alsa-info.sh generated an alsainfo folder, should I attached it?
>
> Thanks,
> Vincent

Hi Vincent.

It looks like your updates have updated the kernel to 2.6.28 since you 
installed the snapshot of the alsa driver, as your alsa-info.sh output shows 
alsa driver 1.0.18rc3. You will have to upgrade the alsa driver again for the 
new kernel. Alsa driver 1.0.19 is now available from the link below, so try 
that.
http://alsa-project.org/main/index.php/Main_Page

You'll also need to run the alsa-info.sh script again, so that it shows the 
info retrieved when using alsa driver 1.0.19. You only need attach the 
alsa-info.txt file, not the alsainfo folder.

I must admit to being out of my depth with your problem with the front mic. 
It's no doubt worth trying the various model options again, once you've 
installed the 1.0.19 alsa driver against the 2.6.28 kernel.

Perhaps Takashi may have a suggestion to resolve your problem.

All the best.

Nigel.
>
> On Sun, Jan 18, 2009 at 5:56 PM, Nigel Henry 
<cave.dnb2m97pp@aliceadsl.fr>wrote:
> > On Sunday 18 January 2009 00:37, Vincent wrote:
> > > Hi again,
> > >
> > > I have now installed the alsa-driver snapshot in a right way.
> > > Here is my /proc/asound/version:
> > > "Advanced Linux Sound Architecture Driver Version 1.0.18a.
> > > Compiled on Jan 17 2009 for kernel 2.6.27-ARCH (SMP)."
> > > But I still can't record directly from the front plug. How do you
> >
> > configure
> >
> > > alsa to do that? (I use alsamixer or the gnome volume controler)
> > >
> > > Thanks
> >
> > Hi Vincent.
> >
> > Nice to see you now have the latest alsa driver installed. I'm not too
> > clued
> > up on mic problems, and my hda intel codec is different to yours
> > (ALC662), so
> > my alsamixer is going to show different controls to yours.
> >
> > Anyway, be that as it may, my alsamixer shows 2 controls for the mic.
> > Front Mic, and Mic, and both have switches to mute/unmute (M key toggles
> > the mute/unmute). Logically for getting sounds out of the Front Mic, it
> > needs to
> > be unmuted, and the slider pushed up. Now you should get sounds from your
> > speakers, when speaking into the mic (watchout for feedback, if the
> > levels are too high).
> >
> > Now press F4, and you should see alsamixers capture controls. Mine shows
> > 3 controls. IEC958 (ignore that one), Capture, which has a slider, and
> > beneath
> > it a few dashes. To activate the control press the spacebar. The other
> > control is for Input Source, and when on that control the up/down arrows
> > will
> > scroll through the source options. Mine shows, Mic, Front Mic, Line, and
> > CD.
> > If yours shows the same, I'd go for Front Mic. Push the activated capture
> > slider up, and see if you can record anything from your Front Mic.
> >
> > The model options for the STAC9228 codec,  alsa driver snapshot, dated
> > 20090118, are below. It may be worth trying them. You may find that some
> > provide more controls on your alsamixer. Just add a line
> > to /etc/modprobe.conf. Example below.
> >
> > options snd-hda-intel model=ref      (that I believe is the default line)
> >
> > Model options for snapshot 20090118 below.
> >
> >
> > STAC9227/9228/9229/927x
> > =======================
> >  ref  Reference board
> >  ref-no-jd Reference board without HP/Mic jack detection
> >  3stack D965 3stack
> >  5stack D965 5stack + SPDIF
> >  dell-3stack Dell Dimension E520
> >  dell-bios Fixes with Dell BIOS setup
> >
> > Rerun the alsa-info.sh script again, and run it as below, and attach the
> > file
> > saved in /tmp to your reply, as it may be usefull to Takashi. I'm not an
> > alsa
> > developer, but he is, and may have a suggestion which will resolve your
> > problem.
> >
> > ./alsa-info.sh --no-upload
> >
> > All the best, and hope you resolve your problem.
> >
> > Nigel.
> >
> > > On Sat, Jan 17, 2009 at 7:06 PM, Nigel Henry
> >
> > <cave.dnb2m97pp@aliceadsl.fr>wrote:
> > > > On Saturday 17 January 2009 17:49, Vincent wrote:
> > > > > Hi,
> > > > >
> > > > > I tried to install alsa-driver snapshot but I think I'm not enough
> > > >
> > > > skilled
> > > >
> > > > > : I first uninstall alsa-lib, then I install the alsa-driver
> >
> > snapshot.
> >
> > > > When
> > > >
> > > > > I try to (re)start alsa, I get this error:
> > > > > "/usr/sbin/alsactl: error while loading shared libraries:
> > > > > libasound.so.2: cannot open shared object file: No such file or
> > > > > directory"
> > > > > and a "sudo find / -name 'libasound*'" didn't return any result.
> > > > >
> > > > > Did I do the right installation processus? What else can I try to
> >
> > help?
> >
> > > > > Thanks
> > > >
> > > > Hi Vincent.
> > > >
> > > > You don't have to uninstall alsa lib to upgrade the alsa driver.
> > > > First reinstall the alsa-lib package, reboot, or restart alsa, and
> > > > see if
> >
> > it's
> >
> > > > working now.
> > > >
> > > > Post the output of cat /proc/asound/version, which will verify if the
> > > > alsa driver is now the latest version (1.0.18a)
> > > >
> > > > I also have an Archlinux install (Don't Panic). My hda intel card
> > > > works ok with the 1.0.17 alsa driver. (ALC662 codec).
> > > >
> > > > All the best.
> > > >
> > > > Nigel.
> > > >
> > > > > On Mon, Jan 12, 2009 at 12:41 PM, Takashi Iwai <tiwai@suse.de>
> >
> > wrote:
> > > > > > At Fri, 9 Jan 2009 17:57:45 +0100,
> > > > > >
> > > > > > Vincent wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > I'm working on a Dell 1525 and I want to plug a mic into the
> >
> > front
> >
> > > > mic
> > > >
> > > > > > port
> > > > > >
> > > > > > > in order to have a "clean" record. But when it doesn't record
> > > >
> > > > anything,
> > > >
> > > > > > all
> > > > > >
> > > > > > > I can have is the noise from the external mic.
> > > > > > > Is there any specific actions I forgot to do?
> > > > > > >
> > > > > > > Here is my alsa-info output :
> >
> > http://www.alsa-project.org/db/?f=a9066fcfe52fa0dd7d9bcd65214855c84592bd2
> >
> > > > > >5
> > > > > >
> > > > > > Could you first try the latest alsa-driver snapshot (or sound git
> > > >
> > > > tree)?
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-s
> >
> > > > > >napshot.tar.gz
> > > > > >
> > > > > >
> > > > > > Takashi
> > > > >
> > > > > _______________________________________________
> > > > > Alsa-devel mailing list
> > > > > Alsa-devel@alsa-project.org
> > > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > >
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > >
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
