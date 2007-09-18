From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: Enabling in-kernel synch for M-Audio boards
Date: Tue, 18 Sep 2007 23:16:39 +0100
Message-ID: <20070918221639.GA3365@localhost>
References: <46EE555B.9000700@alice.it> <20070917194403.GA3655@localhost>
	<20070918065723.GA2512@localhost> <46EF8729.3080901@alice.it>
	<20070918104033.GA2491@localhost>
	<1190123404.16980.1211261887@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BB2724552
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 00:12:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1190123404.16980.1211261887@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Ludovico Verducci <ludwigvan@alice.it>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 18, 2007 at 03:50:04PM +0200, Clemens Ladisch wrote:
> John Rigg wrote:
> > On Tue, Sep 18, 2007 at 10:07:05AM +0200, Ludovico Verducci wrote:
> > > As far as I know the delta family boards drivers support the
> > > synchronization of up to 4 audio boards over PCI: at the moment I'm
> > > reverse engineering the hardware trying to understand how this can be
> > > accomplished.
> > 
> > I'm aware that some Windows users are using several Delta 1010s
> > without external sync, but I'm not sure how it is done (or how
> > good it sounds). AFAIK it would require a VCXO so that the frequency 
> > of the card's clock could be varied by enough to keep it in sync 
> > (ie. making the clock oscillator part of a phase locked loop). Looking
> > at the PCI card on the 1010, I can only see standard fixed-frequency 
> > crystals. The only PLLs appear to be the internal PLL in the S/PDIF
> > receiver and the 4046 PLL chip for the word clock input signal.
> 
> In theory, it should be possible to use the PCI clock (between 25 and
> 33 MHz) as input for one of the PLLs, probably after dividing it down.

AFAICT neither of these PLLs can receive an input from the PCI clock.
The S/PDIF receiver only receives a signal from the S/PDIF input, and
the word clock PLL only receives a signal from the WC input in the 
breakout box (via a pulse shaping circuit to clean up the waveform).

Apart from that, neither of these PLLs is particularly good at removing
jitter (and I'd expect the PCI clock to have a high level of jitter),
so quality would be reduced.

John
