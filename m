From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [PlanetCCRMA] Re: rme hdsp pcmcia
	(and	probably	pci) broken
Date: Wed, 28 Nov 2007 18:50:56 -0800
Message-ID: <1196304656.29234.12.camel@cmn3.stanford.edu>
References: <1196127903.15009.34.camel@cmn3.stanford.edu>
	<s5hejebkd2g.wl%tiwai@suse.de>
	<1196191110.22601.15.camel@cmn3.stanford.edu>
	<1196208700.22601.59.camel@cmn3.stanford.edu>
	<s5hhcj6iujn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.stanford.edu (smtp1.Stanford.EDU [171.67.22.28])
	by alsa0.perex.cz (Postfix) with ESMTP id EE90A24731
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 03:51:04 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, planetccrma@ccrma.Stanford.EDU, Remy Bruno <remy.bruno@trinnov.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-11-28 at 10:33 +0100, Takashi Iwai wrote:
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
> 
> What is your hardware actually?  Could you check hdsp->io_type and
> hdsp->firmware_rev?

Sorry, it was a loaner. I'll get hold of it next week again. It was the
hdsp pcmcia card and a digiface II. 

-- Fernando
