From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: Re: Cannot record from front pluggable mic on 82801H
	(ICH8 Family) sound card
Date: Sat, 17 Jan 2009 19:06:27 +0100
Message-ID: <200901171906.27473.cave.dnb2m97pp@aliceadsl.fr>
References: <ef2423ab0901090857l1b592e34yd340f69c5c65fb92@mail.gmail.com>
	<s5htz84da4g.wl%tiwai@suse.de>
	<ef2423ab0901170849v7c768afy8c88b1e82fb80f11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DBA1243AF
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2009 19:06:34 +0100 (CET)
Received: from [192.168.0.230] (213.36.1.117) by mail.libertysurf.net
	(7.3.118.8) id 4965DFBF002570B7 for alsa-devel@alsa-project.org;
	Sat, 17 Jan 2009 20:15:06 +0100
In-Reply-To: <ef2423ab0901170849v7c768afy8c88b1e82fb80f11@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Saturday 17 January 2009 17:49, Vincent wrote:
> Hi,
>
> I tried to install alsa-driver snapshot but I think I'm not enough skilled
> : I first uninstall alsa-lib, then I install the alsa-driver snapshot. When
> I try to (re)start alsa, I get this error:
> "/usr/sbin/alsactl: error while loading shared libraries: libasound.so.2:
> cannot open shared object file: No such file or directory"
> and a "sudo find / -name 'libasound*'" didn't return any result.
>
> Did I do the right installation processus? What else can I try to help?
>
> Thanks

Hi Vincent.

You don't have to uninstall alsa lib to upgrade the alsa driver. First 
reinstall the alsa-lib package, reboot, or restart alsa, and see if it's 
working now.

Post the output of cat /proc/asound/version, which will verify if the alsa 
driver is now the latest version (1.0.18a)

I also have an Archlinux install (Don't Panic). My hda intel card works ok 
with the 1.0.17 alsa driver. (ALC662 codec).

All the best.

Nigel.
>
> On Mon, Jan 12, 2009 at 12:41 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > At Fri, 9 Jan 2009 17:57:45 +0100,
> >
> > Vincent wrote:
> > > Hi,
> > >
> > > I'm working on a Dell 1525 and I want to plug a mic into the front mic
> >
> > port
> >
> > > in order to have a "clean" record. But when it doesn't record anything,
> >
> > all
> >
> > > I can have is the noise from the external mic.
> > > Is there any specific actions I forgot to do?
> > >
> > > Here is my alsa-info output :
> >
> > http://www.alsa-project.org/db/?f=a9066fcfe52fa0dd7d9bcd65214855c84592bd2
> >5
> >
> > Could you first try the latest alsa-driver snapshot (or sound git tree)?
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-s
> >napshot.tar.gz
> >
> >
> > Takashi
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
