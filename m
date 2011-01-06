From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use reg_def_copy
 instead of reg_cache_default
Date: Thu, 6 Jan 2011 21:20:48 +0000
Message-ID: <20110106212047.GF8018@opensource.wolfsonmicro.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
	<AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
	<20110105230339.GB5476@opensource.wolfsonmicro.com>
	<4D24F9E4.1080704@freescale.com>
	<20110105232947.GA8514@sirena.org.uk>
	<20110105235115.GB5714@opensource.wolfsonmicro.com>
	<4D250995.4020409@freescale.com>
	<20110106003455.GA12153@opensource.wolfsonmicro.com>
	<4D25ED43.9010701@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0AC2F2455F
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 22:20:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D25ED43.9010701@freescale.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2011 at 10:26:43AM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> > In cases like this (although not I suspect this particular one) the
> > answer is often that there was't any particular consideration for
> > whatever unusual case you're looking at.

> Ah, but I don't think my case is "unusual".  Frankly, I think it's unusual to
> hard-code default register values into a driver.  I just don't see how you can

*sigh*  If you look at other ASoC drivers you'll see that providing
register defaults is very much idiomatic.

> guarantee that the values will be correct for all supported revisions of the chip.

We've been doing this for rather a long time; many devices don't support
readback at all so there's not even any option for them.  There's some
fairly simple things you can do if there are issues, like write out the
new default values explicitly (which will be a noop on new silicon).

There's fairly strong pressures on chip vendors to avoid anything that
causes issues here.  Consider what a chip vendor has to do to introduce
an incompatible register change in production hardware: they need to
notify all their customers and they need to make sure that their
customers are happy and don't get upset about having to update their
software (perhaps they don't like the new default).  If the customers
aren't happy then worst case you end up having to keep both old and new
silicon in production.

> On the CS4270, for instance, one register contains the chip revision number.
> There's no way I can know which revision will be used on any given board.

So that register should be marked as volatile, the register default
value will be ignored and the cache will never be used for that register.
