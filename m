From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: mxs-saif: remove function in
	platform_data
Date: Mon, 14 Nov 2011 21:20:19 +0000
Message-ID: <20111114212018.GA6528@opensource.wolfsonmicro.com>
References: <1321003740-10992-1-git-send-email-b29396@freescale.com>
	<20111111150422.GX16886@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6AC4D243BD
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 22:20:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111111150422.GX16886@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, w.sang@pengutronix.de, shawn.guo@freescale.com, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 11, 2011 at 04:04:22PM +0100, Sascha Hauer wrote:
> On Fri, Nov 11, 2011 at 05:29:00PM +0800, Dong Aisheng wrote:
> > Add master_mode and master_id in platfrom_data since it's board
> > specific and board knows it.
> > Then we can remove the function pointer in platfrom_data to make
> > the driver more devicetree friendly.

> Looks ok. Marc, is it ok when I take this patch? The SoC specific stuff
> for this patch depends on it.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
