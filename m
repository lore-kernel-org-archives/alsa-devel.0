From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] i.MX ssi: Add missing Kconfig entry
	for Phytec	boards
Date: Mon, 31 May 2010 14:19:50 +0200
Message-ID: <20100531121950.GG26820@pengutronix.de>
References: <20100531101200.GA3489@rakim.wolfsonmicro.main>
	<1275301701-17599-1-git-send-email-s.hauer@pengutronix.de>
	<20100531103045.GB3489@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id E72E11038AC
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 14:19:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100531103045.GB3489@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, May 31, 2010 at 11:30:46AM +0100, Mark Brown wrote:
> On Mon, May 31, 2010 at 12:28:21PM +0200, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Is this different to your previous submission which I already have
> queued for application?
> 

Sorry, wrong patch. I wanted to update the other patch according to your
comment. Here's the right one.

Sascha


[PATCH 1/2] i.MX ssi: MX31ads sound support should depend on MACH_MX31ADS_WM1133_EV1

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index eba9b9d..10acbe9 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -13,7 +13,7 @@ config SND_MXC_SOC_SSI
 
 config SND_MXC_SOC_WM1133_EV1
 	tristate "Audio on the the i.MX31ADS with WM1133-EV1 fitted"
-	depends on SND_IMX_SOC && EXPERIMENTAL
+	depends on SND_IMX_SOC && MACH_MX31ADS_WM1133_EV1 && EXPERIMENTAL
 	select SND_SOC_WM8350
 	select SND_MXC_SOC_SSI
 	help
-- 
1.7.1

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
