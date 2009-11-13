From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: need support for insatllation of pci sound card.
Date: Fri, 13 Nov 2009 19:30:21 +0800
Message-ID: <4f3252890911130330p102f16car76b82b7abff9ad95@mail.gmail.com>
References: <daf8bdba0911121306j3bb7b3ffo3efcf7c14793196f@mail.gmail.com>
	<daf8bdba0911121311j1f7be714w73b8aab1496c3788@mail.gmail.com>
	<604760770911121327w872f3dftfca7347322ed1743@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E619524371
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2009 12:30:22 +0100 (CET)
Received: by pzk9 with SMTP id 9so2010721pzk.16
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2009 03:30:21 -0800 (PST)
In-Reply-To: <604760770911121327w872f3dftfca7347322ed1743@mail.gmail.com>
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

This is known bug of EV1938 , it seem that EV1938 cannot read ac97 codec
after 2.6.10-1.770_FC3

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1389
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1023

!!PCI Soundcards installed in the system
!!--------------------------------------

04:01.0 Multimedia audio controller: Creative Labs Ectiva EV1938



2009/11/13 Daniel Chen <seven.steps@gmail.com>

> On Thu, Nov 12, 2009 at 4:11 PM, Kunal Narkhede
> <kunal.narkhede@gmail.com> wrote:
> > alsa drivers with the provided one.My card seems to getting recognize but
> no
> > sound is heard here is
>
> This appears to be a mixer setting problem. What's unmuted/zeroed?
>
> > I am usung* ubuntu 9.04 with 2.6.28-16-generic kerne*l installed through
> > updates using update manager.
>
> Please use your distribution's defect reporting mechanism. For Ubuntu
> 9.04, this would be opening Applications > Accessories > Terminal, and
> using:
>
> ubuntu-bug alsa-base
>
> HTH,
> Dan
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
