From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix check for symmetric rate
	enforcement
Date: Wed, 17 Aug 2011 07:56:50 +0100
Message-ID: <20110817065649.GA3261@opensource.wolfsonmicro.com>
References: <20110817062753.GB31404@pengutronix.de>
	<20110817065014.GB12344@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAF2E1038BC
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 08:56:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110817065014.GB12344@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Lambrecht =?iso-8859-1?Q?J=FCrgen?= <J.Lambrecht@TELEVIC.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 17, 2011 at 03:50:14PM +0900, Mark Brown wrote:
> On Wed, Aug 17, 2011 at 08:27:53AM +0200, Sascha Hauer wrote:

> > The ASoC core tries to not enforce symmetric rates when
> > two streams open simultaneously. It does so by checking
> > rtd->rate being zero. This works exactly once after booting
> > because it is not set to zero again when the streams close.
> > Fix this by clearing rtd->rate when no active stream is left.

> Applied, thanks.  Though I suspect that in practice this may actually be

...or not since it doesn't actually apply to either 3.1 or 3.2.  Could
you regenerate against 3.1 please?
