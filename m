From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: sgtl5000: defer the probe if clock
	is not found
Date: Tue, 16 Jul 2013 00:19:43 +0800
Message-ID: <20130715161941.GD23589@S2101-09.ap.freescale.net>
References: <1373900110-19929-1-git-send-email-shawn.guo@linaro.org>
 <20130715161250.GR11538@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 009992619D1
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 18:19:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130715161250.GR11538@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 15, 2013 at 05:12:50PM +0100, Mark Brown wrote:
> On Mon, Jul 15, 2013 at 10:55:10PM +0800, Shawn Guo wrote:
> > It's not always the case that clock is already available when sgtl5000
> > get probed at the first time, e.g. the clock is provided by CPU DAI
> > which may be probed after sgtl5000.  So let's defer the probe when
> > devm_clk_get() call fails and give it chance to try later.
> 
> My previous comments about this being better handled in the clock core
> appear to have been ignored and...

I'm not really fond of fixing a regression for -rc with involving clock
core change.  I think we can do that when that becomes a really common
pattern.

> 
> > +		/* Defer the probe to see if the clk will be provided later */
> > +		return ret == -ENOENT ? -EPROBE_DEFER : ret;
> 
> ...please try to avoid the ternery operator, it's not helpful for
> legibility.

Okay, will change that to respect your taste.

Shawn
