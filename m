From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 01/17] ASoC: imx: move eukrea audmux
 call into ASoC machine driver
Date: Mon, 5 Mar 2012 20:27:59 +0100
Message-ID: <20120305192759.GB3852@pengutronix.de>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
	<20120305174612.GY3224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 6EF9A104039
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 20:28:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120305174612.GY3224@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 05, 2012 at 05:46:13PM +0000, Mark Brown wrote:
> On Mon, Mar 05, 2012 at 10:30:49PM +0800, Shawn Guo wrote:
> > It moves eukrea audmux configuration call from board file into ASoC
> > machine driver eukrea-tlv320, so that it gets aligned wm1133-ev1 and
> > mx27vis-aic32x4, and more importantly it will ease the moving of audmux
> > into sound/soc/imx as a platform driver later.
> 
> Sascha, this and the second patch look totally uncontroversial - can we
> just apply them now so we don't need to keep reviewing them?

For patches 01-08 I can give my:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

The rest I would like to test. Shawn, on what is this series based? It
neither applies on v3.3-rc6 nor on arm-soc/for-next.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
