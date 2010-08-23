From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: ASoC i.MX ssi: use SSI_STCCR in synchronous mode
Date: Mon, 23 Aug 2010 08:52:11 +0200
Message-ID: <20100823065211.GQ27749@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5B83F243EE
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 08:52:11 +0200 (CEST)
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <sha@pengutronix.de>) id 1OnQt9-0003jj-4x
	for alsa-devel@alsa-project.org; Mon, 23 Aug 2010 08:52:11 +0200
Received: from sha by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <sha@pengutronix.de>) id 1OnQt9-000466-2t
	for alsa-devel@alsa-project.org; Mon, 23 Aug 2010 08:52:11 +0200
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

Please consider applying this for -rc.

Sascha


In synchronous mode the SSI_SRCCR values are ignored. Instead
SSI_STCCR must be used for both receiving and transmitting.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/imx-ssi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index a11daa1..c81da05 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -254,6 +254,9 @@ static int imx_ssi_hw_params(struct snd_pcm_substream *substream,
 		dma_data = &ssi->dma_params_rx;
 	}
 
+	if (ssi->flags & IMX_SSI_SYN)
+		reg = SSI_STCCR;
+
 	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
 
 	sccr = readl(ssi->base + reg) & ~SSI_STCCR_WL_MASK;
-- 
1.7.1

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
