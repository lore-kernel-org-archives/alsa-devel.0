From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 3 Jan 2008 23:00:38 +0000
Message-ID: <20080103230004.GA18709@sirena.org.uk>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<477BA974.8010308@freescale.com>
	<20080102172340.GA2007@sirena.org.uk>
	<477D280C.4000800@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A9B6424529
	for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2008 00:00:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <477D280C.4000800@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 03, 2008 at 12:23:08PM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> > To cover everything you'd need to be able to specify all the clocking
> > parameters, especially a PLL configuration, and also specify more than
> > one of each item.  Even then you'd still have problems like...

> The ASoC V1 API for communicating clock data from the fabric driver to the 
> codec driver only allows for three parameters.

Each individual call to set_sysclk() only takes three parameters but it
can be called repeatedly and some configurations are going to require
this.  There's also the set_pll() call which will be required by some
things too (and again that can support multiple PLLs).  

For example, something like this isn't unknown:

 - Set PLL input to pin A.
 - Configure PLL input/output frequencies.
 - Set codec system clock source to be the PLL

and of course the ordering matters.  You can also have other dividers
and clock sources within the codec which need configuring and other
components outside the codec which need configuring to supply the clocks
to the codec.

> > According to the documentation in your patch the bus frequency should
> > already be optional 

> My code does not currently support that configuration, and I don't have any 
> hardware that works that way, so I don't know what it would look like.  I'm 
> just trying to make the driver as flexible as possible, given ASoC V1 constraints.

Indeed.  Providing the device tree stuff doesn't get set in stone I'm
not sure we need to nail this down perfectly for ASoC v1 when we're
running into trouble working around it.
