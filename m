From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 6/6] ASoC: TWL4030: Add analog loopback
	support
Date: Tue, 27 Jan 2009 14:41:18 +0000
Message-ID: <20090127144117.GC11870@sirena.org.uk>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
	<200901271505.34354.peter.ujfalusi@nokia.com>
	<20090127140316.GB11870@sirena.org.uk>
	<200901271628.35272.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F5871037FD
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 15:41:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901271628.35272.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2009 at 04:28:35PM +0200, Peter Ujfalusi wrote:
> On Tuesday 27 January 2009 16:03:16 ext Mark Brown wrote:

> > This one should be dealable with in-kernel without any work by
> > applications - WM8350 does a similar dance (for different reasons),
> > providing a shadow volume control while some of the amplifiers are
> > powered off.

> I'm going to check the code. But I think the driver still needs to keep on 
> track of the bypass switch states in order to do the right thing.

I'd expet so - the main win would be to avoid having to have user space
manually twiddle additional controls.

> > I suspect the increased power consumption here is due to the PLL being
> > required to clock the DAC properly.  Or you've transposed the figures :)

> I have checked it several times, the numbers are correct. Probably the DAC 
> clocking, but how it is working without the PLL on - because the bypass was 
> working...

I'd imagine that it did actually have a clock (probably whatever clock
would be input to the PLL), just not at the optimal rate.
