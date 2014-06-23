From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4 v2] regulator: arizona-ldo1: Do not
	control	clocking from regulator
Date: Mon, 23 Jun 2014 16:53:37 +0100
Message-ID: <20140623155337.GD23517@opensource.wolfsonmicro.com>
References: <1403275273-22713-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140621205349.GD24291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B7752655A6
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 17:53:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140621205349.GD24291@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 21, 2014 at 09:53:49PM +0100, Mark Brown wrote:
> On Fri, Jun 20, 2014 at 03:41:13PM +0100, Charles Keepax wrote:
> > From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > 
> > Using the driver for the internal regulator to also control
> > the clock frequency of blocks inside the codec is an
> > unexpected side-effect for a regulator, and also means that
> > the core clocks won't be changed as expected if an external
> > regulator is used to power the codec.
> > 
> > The clocking control is now handled by the core arizona MFD
> > driver so can be removed from the LDO1 driver.
> 
> I would expect this to be squashed into the first patch since otherwise
> there's a bisection issue with both drivers trying to maintain the same
> thing at the same time.

Whilst there are two things controlling it for a couple of
patches they both set the same value one after another, so it
should be safe. If it goes into the first patch nothing is
controlling the DVFS for a few patches so that actually creates a
bisection issue. It could be squashed into the second last patch
but this way feels cleaner?

Thanks,
Charles
