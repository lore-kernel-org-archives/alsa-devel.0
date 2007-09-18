From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Enabling in-kernel synch for M-Audio boards
Date: Tue, 18 Sep 2007 15:50:04 +0200
Message-ID: <1190123404.16980.1211261887@webmail.messagingengine.com>
References: <46EE555B.9000700@alice.it> <20070917194403.GA3655@localhost>
	<20070918065723.GA2512@localhost> <46EF8729.3080901@alice.it>
	<20070918104033.GA2491@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 5F04B244CA
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 15:50:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070918104033.GA2491@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Rigg <aldev@sound-man.co.uk>, Ludovico Verducci <ludwigvan@alice.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Rigg wrote:
> On Tue, Sep 18, 2007 at 10:07:05AM +0200, Ludovico Verducci wrote:
> > As far as I know the delta family boards drivers support the
> > synchronization of up to 4 audio boards over PCI: at the moment I'm
> > reverse engineering the hardware trying to understand how this can be
> > accomplished.
> 
> I'm aware that some Windows users are using several Delta 1010s
> without external sync, but I'm not sure how it is done (or how
> good it sounds). AFAIK it would require a VCXO so that the frequency 
> of the card's clock could be varied by enough to keep it in sync 
> (ie. making the clock oscillator part of a phase locked loop). Looking
> at the PCI card on the 1010, I can only see standard fixed-frequency 
> crystals. The only PLLs appear to be the internal PLL in the S/PDIF
> receiver and the 4046 PLL chip for the word clock input signal.

In theory, it should be possible to use the PCI clock (between 25 and
33 MHz) as input for one of the PLLs, probably after dividing it down.


Regards,
Clemens
