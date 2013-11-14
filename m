From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 21/21] ASoC: davinci-mcasp: Correct am33xx
	snd_platform_data name
Date: Thu, 14 Nov 2013 11:35:37 +0200
Message-ID: <1384421737-4467-22-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id EDF3826518D
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:36:32 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

An earlier patch overlooked this when the compatible has been changed from
omap2 -> am33x.
Rename omap2_mcasp_pdata to am33xx_mcasp_pdata.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 36a4b9a..b7858bf 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -789,7 +789,7 @@ static struct snd_platform_data da830_mcasp_pdata = {
 	.version = MCASP_VERSION_2,
 };
 
-static struct snd_platform_data omap2_mcasp_pdata = {
+static struct snd_platform_data am33xx_mcasp_pdata = {
 	.tx_dma_offset = 0,
 	.rx_dma_offset = 0,
 	.asp_chan_q = EVENTQ_0,
@@ -814,7 +814,7 @@ static const struct of_device_id mcasp_dt_ids[] = {
 	},
 	{
 		.compatible = "ti,am33xx-mcasp-audio",
-		.data = &omap2_mcasp_pdata,
+		.data = &am33xx_mcasp_pdata,
 	},
 	{
 		.compatible = "ti,dra7-mcasp-audio",
-- 
1.8.4.2
