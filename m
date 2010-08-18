From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem with MX27 ASoC audio
Date: Wed, 18 Aug 2010 10:02:23 +0100
Message-ID: <20100818090223.GD26804@opensource.wolfsonmicro.com>
References: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
	<20100812125625.GA27749@pengutronix.de>
	<AANLkTinCWxRNBeXxTHRFBDgmgM6vZTqTKgoCubNYSV5u@mail.gmail.com>
	<20100812150145.GC11362@sirena.org.uk>
	<AANLkTiks+PBmKf6UrxwfLR2jGHO47-p4=o10Y-EE0kJw@mail.gmail.com>
	<4C690693.80706@eukrea.com>
	<AANLkTi=Jst17bqqH6H=jdPYZSGdz5G7yiOJQ=aRLm-3x@mail.gmail.com>
	<AANLkTimSMLLcOVzxocQV_nQ57wwxKLUGQUt7wn2wPa2p@mail.gmail.com>
	<20100818084137.GA26804@opensource.wolfsonmicro.com>
	<AANLkTinm96norAT4YQhTqg+eP80gwoeZf13V2QQa0_QV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B51324463
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 11:02:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinm96norAT4YQhTqg+eP80gwoeZf13V2QQa0_QV@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 18, 2010 at 04:58:12PM +0800, Randolph Chung wrote:

> The codec (at least the variant of tlv320aic3x that I am using) can
> have two pins in the hardware, but it's up to the board whether it's
> hooked up that way. The codec driver as currently implemented assumes
> the rates are symmetric, but it need not be.

In that case the driver should be setting the symmetric_rates flag
anyway since it does have this constraint - if it implements support for
asymmetric rates then the flag can be removed then.

> I see that there is a symmetric_rates flag for the dai_link too.

This is still a good idea if your board has a single LRCLK anyway in
case someone does do asymmetric rates.
