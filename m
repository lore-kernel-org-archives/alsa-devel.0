From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: Enabling in-kernel synch for M-Audio boards
Date: Tue, 18 Sep 2007 11:40:33 +0100
Message-ID: <20070918104033.GA2491@localhost>
References: <46EE555B.9000700@alice.it> <20070917194403.GA3655@localhost>
	<20070918065723.GA2512@localhost> <46EF8729.3080901@alice.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 6186C2449E
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 12:35:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46EF8729.3080901@alice.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ludovico Verducci <ludwigvan@alice.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 18, 2007 at 10:07:05AM +0200, Ludovico Verducci wrote:
> John Rigg ha scritto:
> > On Mon, Sep 17, 2007 at 08:44:03PM +0100, John Rigg wrote:
> >   
> >> On Mon, Sep 17, 2007 at 12:22:19PM +0200, Ludovico Verducci wrote:
> >>> I'm developing a complex multichannel audio distribution system where 
> >>> multiple linux boxes will stream audio data over ethernet and then 
> >>> should play audio at sample level resolution synchronization. The boxes 
> >>> clocks are synchronized over ethernet using PTP. 
> >>> I need to keep in synch the audio board's clocks and I can't use an 
> >>> external wordclock nor s/pdif. 
> >>>       
> >> Won't this cause serious clock jitter problems? I don't see how the
> >> PCI bus can deliver precise enough timing, considering how much other
> >> data it has to handle.
> >>     
> I didn't mean to directly drive the audio board's clock over the PCI
> bus. I think this is simply not feasible. But I think that using control
> signals periodically exchanged over PCI between the audio board and the
> kernel could be possible (if the hardware could support a similar
> feature, of course) to skew the board's clock to keep it in synch with a
> software reference.

Ah, I misunderstood what you meant.

> As far as I know the delta family boards drivers support the
> synchronization of up to 4 audio boards over PCI: at the moment I'm
> reverse engineering the hardware trying to understand how this can be
> accomplished.

I'm aware that some Windows users are using several Delta 1010s
without external sync, but I'm not sure how it is done (or how
good it sounds). AFAIK it would require a VCXO so that the frequency 
of the card's clock could be varied by enough to keep it in sync 
(ie. making the clock oscillator part of a phase locked loop). Looking
at the PCI card on the 1010, I can only see standard fixed-frequency 
crystals. The only PLLs appear to be the internal PLL in the S/PDIF
receiver and the 4046 PLL chip for the word clock input signal.

John
