From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] make the sgtl5000-codec work
Date: Tue, 19 Jul 2011 17:59:49 +0100
Message-ID: <20110719165707.GL9652@opensource.wolfsonmicro.com>
References: <20110719090404.GD1951@pengutronix.de>
	<20110719151337.GG9652@opensource.wolfsonmicro.com>
	<20110719164639.GA22987@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF3262437D
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 18:59:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110719164639.GA22987@pengutronix.de>
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
Cc: Zeng Zhaoming <zhaoming.zeng@freescale.com>, alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 19, 2011 at 06:46:39PM +0200, Wolfram Sang wrote:
> On Tue, Jul 19, 2011 at 04:13:37PM +0100, Mark Brown wrote:

> > The only reason steps are ever used is for AC'97 devices which don't use
> > the generic cache code as they're pretty much obsolete so the framework
> > support is mostly just carried around as legacy.  The step size is used
> > in the cache display code which does use it.  If someone was interested
> > enough to convert AC'97 over that'd be nice.

> I am a bit confused now: Do you want to retire the step size in the long run?
> Then my sgtl-patch might be the right approach after all.

Err, no.  I'm saying there's no current use of step size in the
soc-cache code because no modern hardware has any need for it.
