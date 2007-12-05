From: Christian Schumann <schumann@physik.uni-kl.de>
Subject: Re: [PlanetCCRMA] Re: rme hdsp pcmcia (and
	probably	pci) broken
Date: Wed, 5 Dec 2007 09:22:48 +0100
Message-ID: <20071205082248.GA24590@diller-5.physik.uni-kl.de>
References: <1196127903.15009.34.camel@cmn3.stanford.edu>
	<s5hejebkd2g.wl%tiwai@suse.de>
	<1196191110.22601.15.camel@cmn3.stanford.edu>
	<1196208700.22601.59.camel@cmn3.stanford.edu>
	<s5hhcj6iujn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [131.246.120.220])
	by alsa0.perex.cz (Postfix) with ESMTP id DFAF8244EB
	for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2007 09:22:51 +0100 (CET)
Received: from cartman.physik.uni-kl.de (cartman.physik.uni-kl.de
	[131.246.236.200])
	by mailgw1.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	lB58MfxL006983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 5 Dec 2007 09:22:42 +0100
Received: from diller-5.physik.uni-kl.de (diller-5.physik.uni-kl.de
	[131.246.236.224])
	by cartman.physik.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	lB58FbKO031926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 5 Dec 2007 09:15:38 +0100
Received: from diller-5.physik.uni-kl.de (localhost.localdomain [127.0.0.1])
	by diller-5.physik.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id
	lB58MmPC024735
	for <alsa-devel@alsa-project.org>; Wed, 5 Dec 2007 09:22:48 +0100
Received: (from schumann@localhost)
	by diller-5.physik.uni-kl.de (8.13.8/8.13.8/Submit) id lB58Mmii024734
	for alsa-devel@alsa-project.org; Wed, 5 Dec 2007 09:22:48 +0100
Content-Disposition: inline
In-Reply-To: <s5hhcj6iujn.wl%tiwai@suse.de>
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

This topic seems to have been abandoned in the last few days, but I'll
report on it anyway.

On Wed, Nov 28, 2007 at 10:33:16AM +0100, Takashi Iwai wrote:
> At Tue, 27 Nov 2007 16:11:40 -0800,
> Fernando Lopez-Lezcano wrote:
> > 
> > On Tue, 2007-11-27 at 11:18 -0800, Fernando Lopez-Lezcano wrote:
> > > On Tue, 2007-11-27 at 14:55 +0100, Takashi Iwai wrote:
> > > > At Mon, 26 Nov 2007 17:45:03 -0800,
> > > > Fernando Lopez-Lezcano wrote:
> > > > > 
> > > > > Hi, anyone has a pcmcia rme card running? And working? With a reasonably
> > > > > recent alsa? (this probably applies also for the regular pci rme cards,
> > > > > I've had reports on the Planet CCRMA list about problems that sound
> > > > > similar to this one). 
> > > > > 
> > > > > My test setup is on fc7 running:
> > > > > 
> > > > >   alsa-lib 1.0.15
> > > > >   alsa-tools 1.0.15
> > > > >   alsa-firmware 1.0.15
> > > > > [MUNCH]
> > > > > 2.6.22.10-1.rt9.1 + alsa driver modules from
> > > > > hg20071012
> > > > > --> BROKEN
> > > > 
> > > > The only significant change in hdsp.c during this is the patch below.
> > > > Could you try to revert?
> > > 
> > > Reverting the patch makes the card play sound as before, so the patch is
> > > definitely broken. Regretfully hdspmixer seems to no longer display the
> > > vu meters and changing the presets does not seem to have an effect, it
> > > probably needs something to be reverted as well to match?
> > 
> > Hmmm, I don't know why it was not working. I'm also building a new
> > kernel, so, with 2.6.23.9 + rt11 + alsa kernel drivers hg20071124 it
> > seems to work (hdspmixer displays the vu meters correctly). 
> 
> Possibly the hdsp-mixer setup got screwed up once due to the wrong
> number of channels.
> 
> If I understand correctly, the latest driver works as is?

I compiled a 2.6.23.9-rt12 yesterday, and with 1.0.14 from the kernel
source tree it works, with a hg checkout from yesterday it doesn't. So
from my point of view the latest driver is broken.

> What is your hardware actually?  Could you check hdsp->io_type and
> hdsp->firmware_rev?
> 
Digiface I + PCMCIA, will check on firmwire version tonight.

Regards
Christian

-- 
------------------------------------------------------------------------
Dipl.-Phys. Christian Schumann   |Technische Universitaet Kaiserslautern
Mail: schumann@physik.uni-kl.de  |           Fachbereich Physik
Tel.: 0631/205-4842 (Office)     |     http://www.physik.uni-kl.de 
Tel.: 0631/205-4843 (Lab)        |
Fax.: 0631/205-3902              |    
Post: Erwin-Schroedinger-Strasse, D-67663 Kaiserslautern
-------------------------------------------------------------------------
