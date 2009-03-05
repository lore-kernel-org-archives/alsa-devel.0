From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/4] soc-dai: add bitfields for
	hardware	I2S formats
Date: Thu, 5 Mar 2009 12:31:41 +0100
Message-ID: <20090305113141.GC28878@buzzloop.caiaq.de>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<20090304223057.GD10731@sirena.org.uk>
	<20090304231223.GB20915@buzzloop.caiaq.de>
	<20090305105357.GB2416@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 19B0B103888
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 12:31:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090305105357.GB2416@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 05, 2009 at 10:53:57AM +0000, Mark Brown wrote:
> > On Wed, Mar 04, 2009 at 10:30:58PM +0000, Mark Brown wrote:
> 
> > > devices on the link.  Have you considered handling this through that,
> > > perhaps through adding a virtual thing to configure (eg, a
> > > PXA_SSP_FRAME_CLOCKS)?
> 
> > I thought about that but then I condidered it's actually the wrong place
> > for such a setting. I see two statements the board file has to make:
> 
> The other option would be to use the TDM mode interface to set this up
> since that's roughly what it is; my main concern here is that we already
> have two ways of doing this and I'd like to try to keep the number down
> for consistency.

Probably a matter of taste, but IMO TDM mode is not the place either.
Userspace could decide sending out 24bit samples out of a sudden (which
the CPU DAI might accept) and in this case, you'd need some special
logic in the board file again to set up deviders, time slots etc, right?

> > > I guess cs4270.c ought to be enforcing this if it's added...
> 
> > cs4270.c would need that flag to be set or fail otherwise. Don't know if
> > that really makes life easier for board support files that are not
> > mainline. Want me to do that?
> 
> If this gets merged it's probably for the best (at least when it's in
> slave mode).  Or add a hint to that effect.

It a hard requirement for the master mode only. I'll add a warning for
this case.

> > For non-I2S devices, we could re-use the same bit space as they will
> > never appear in the same format word anyway, right?
> 
> Yes, I'm just thinking we should be able to use the same name for this
> with every format.

Ok, I now call them SND_SOC_DAIFMT_FF_{UNSPEC,16BIT,24BIT,32BIT}. Are
you fine with these names?

Daniel
