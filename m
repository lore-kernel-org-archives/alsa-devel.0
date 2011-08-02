From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
Date: Wed, 3 Aug 2011 00:29:19 +0900
Message-ID: <20110802152918.GD25884@opensource.wolfsonmicro.com>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<20110802095141.GA2095@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A42E110386D
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 17:29:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110802095141.GA2095@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dong Aisheng-B29396 <B29396@freescale.com>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 02, 2011 at 11:51:41AM +0200, Wolfram Sang wrote:

> So, do I get it right, that my initial patch (attached below again)
> might be interesting after all, because it makes the register layout
> truly flat (also makes the driver usable for me). Then, based on that, a
> new cache type which takes step size into account could be added to the
> soc-core and the codec driver can be later switched to the new cache
> type?

Yes, this is entirely sensible.  Even if there are issues with this
approach they're kept local to the CODEC driver.  Please send normally
for review.
