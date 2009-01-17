From: Vincent <zakora@gmail.com>
Subject: Re: Cannot record from front pluggable mic on 82801H
	(ICH8 Family) sound card
Date: Sun, 18 Jan 2009 00:37:37 +0100
Message-ID: <ef2423ab0901171537s40d6d25ie2b44f875b62fab9@mail.gmail.com>
References: <ef2423ab0901090857l1b592e34yd340f69c5c65fb92@mail.gmail.com>
	<s5htz84da4g.wl%tiwai@suse.de>
	<ef2423ab0901170849v7c768afy8c88b1e82fb80f11@mail.gmail.com>
	<200901171906.27473.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 39A911037F4
	for <alsa-devel@alsa-project.org>; Sun, 18 Jan 2009 00:37:38 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so2276762wfg.23
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2009 15:37:37 -0800 (PST)
In-Reply-To: <200901171906.27473.cave.dnb2m97pp@aliceadsl.fr>
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
To: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi again,

I have now installed the alsa-driver snapshot in a right way.
Here is my /proc/asound/version:
"Advanced Linux Sound Architecture Driver Version 1.0.18a.
Compiled on Jan 17 2009 for kernel 2.6.27-ARCH (SMP)."
But I still can't record directly from the front plug. How do you configure
alsa to do that? (I use alsamixer or the gnome volume controler)

Thanks

On Sat, Jan 17, 2009 at 7:06 PM, Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>wrote:

> On Saturday 17 January 2009 17:49, Vincent wrote:
> > Hi,
> >
> > I tried to install alsa-driver snapshot but I think I'm not enough
> skilled
> > : I first uninstall alsa-lib, then I install the alsa-driver snapshot.
> When
> > I try to (re)start alsa, I get this error:
> > "/usr/sbin/alsactl: error while loading shared libraries: libasound.so.2:
> > cannot open shared object file: No such file or directory"
> > and a "sudo find / -name 'libasound*'" didn't return any result.
> >
> > Did I do the right installation processus? What else can I try to help?
> >
> > Thanks
>
> Hi Vincent.
>
> You don't have to uninstall alsa lib to upgrade the alsa driver. First
> reinstall the alsa-lib package, reboot, or restart alsa, and see if it's
> working now.
>
> Post the output of cat /proc/asound/version, which will verify if the alsa
> driver is now the latest version (1.0.18a)
>
> I also have an Archlinux install (Don't Panic). My hda intel card works ok
> with the 1.0.17 alsa driver. (ALC662 codec).
>
> All the best.
>
> Nigel.
> >
> > On Mon, Jan 12, 2009 at 12:41 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Fri, 9 Jan 2009 17:57:45 +0100,
> > >
> > > Vincent wrote:
> > > > Hi,
> > > >
> > > > I'm working on a Dell 1525 and I want to plug a mic into the front
> mic
> > >
> > > port
> > >
> > > > in order to have a "clean" record. But when it doesn't record
> anything,
> > >
> > > all
> > >
> > > > I can have is the noise from the external mic.
> > > > Is there any specific actions I forgot to do?
> > > >
> > > > Here is my alsa-info output :
> > >
> > >
> http://www.alsa-project.org/db/?f=a9066fcfe52fa0dd7d9bcd65214855c84592bd2
> > >5
> > >
> > > Could you first try the latest alsa-driver snapshot (or sound git
> tree)?
> > >
> > >
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-s
> > >napshot.tar.gz
> > >
> > >
> > > Takashi
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
