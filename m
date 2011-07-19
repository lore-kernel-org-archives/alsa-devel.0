From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3 00/10] ARM: mxs: add audio support
Date: Tue, 19 Jul 2011 09:49:47 +0800
Message-ID: <20110719014946.GD3838@S2100-06.ap.freescale.net>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
	<20110718203816.GA9457@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id 9CA172417E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 03:43:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110718203816.GA9457@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 18, 2011 at 10:38:16PM +0200, Wolfram Sang wrote:
> On Fri, Jul 15, 2011 at 08:09:30PM +0800, Dong Aisheng wrote:
> 
> > This patch series is to add audio support based on saif for mxs platform.
> > The driver only supports playback currently.
> > For capturing, due to hardware limitation that we have to use two saif
> > instances to implement full duplex (playback & recording), we need to
> > figure out a good design to fit in ASoC as the following work.
> 
> So, since the codec problems seem to be resolved now (and they were luckily
> really just codec-problems):
> 
> For the ASoC-patches (1-4):
> 
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> For the mach-mxs-Patches (5-9, 10 is already picked up), assuming patch 6 will
> lose the DIGCTRL-handling:
> 
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> I think this series is good for 3.1. Now we just need the mxs-dma bugfix on
> top, but that's a different patch...
> 
Just to be clear,  Aisheng, you will submit the mxs-dma fix, right?

-- 
Regards,
Shawn
