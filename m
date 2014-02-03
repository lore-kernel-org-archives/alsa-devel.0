From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] ASoC: davinci-mcasp: Rename platform data
	struct
Date: Mon, 3 Feb 2014 14:51:51 +0200
Message-ID: <1391431912-31653-3-git-send-email-peter.ujfalusi@ti.com>
References: <1391431912-31653-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 028EE260845
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 13:52:01 +0100 (CET)
In-Reply-To: <1391431912-31653-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Rename the struct for the platform data:
snd_platform_data -> davinci_mcasp_pdata

Since we have users under arch/arm/mach-davinci/ for this struct add
temporary define to avoid breakage. The arch code can be updated later to
use the new struct name.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/platform_data/davinci_asp.h |  4 +++-
 sound/soc/davinci/davinci-mcasp.c         | 16 ++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
index 5245992b0367..85ad68f9206a 100644
--- a/include/linux/platform_data/davinci_asp.h
+++ b/include/linux/platform_data/davinci_asp.h
@@ -18,7 +18,7 @@
 
 #include <linux/genalloc.h>
 
-struct snd_platform_data {
+struct davinci_mcasp_pdata {
 	u32 tx_dma_offset;
 	u32 rx_dma_offset;
 	int asp_chan_q;	/* event queue number for ASP channel */
@@ -87,6 +87,8 @@ struct snd_platform_data {
 	int tx_dma_channel;
 	int rx_dma_channel;
 };
+/* TODO: Fix arch/arm/mach-davinci/ users and remove this define */
+#define snd_platform_data davinci_mcasp_pdata
 
 enum {
 	MCASP_VERSION_1 = 0,	/* DM646x */
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 63b1ecc97cb1..e5fce2ed4dc6 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -823,28 +823,28 @@ static const struct snd_soc_component_driver davinci_mcasp_component = {
 };
 
 /* Some HW specific values and defaults. The rest is filled in from DT. */
-static struct snd_platform_data dm646x_mcasp_pdata = {
+static struct davinci_mcasp_pdata dm646x_mcasp_pdata = {
 	.tx_dma_offset = 0x400,
 	.rx_dma_offset = 0x400,
 	.asp_chan_q = EVENTQ_0,
 	.version = MCASP_VERSION_1,
 };
 
-static struct snd_platform_data da830_mcasp_pdata = {
+static struct davinci_mcasp_pdata da830_mcasp_pdata = {
 	.tx_dma_offset = 0x2000,
 	.rx_dma_offset = 0x2000,
 	.asp_chan_q = EVENTQ_0,
 	.version = MCASP_VERSION_2,
 };
 
-static struct snd_platform_data am33xx_mcasp_pdata = {
+static struct davinci_mcasp_pdata am33xx_mcasp_pdata = {
 	.tx_dma_offset = 0,
 	.rx_dma_offset = 0,
 	.asp_chan_q = EVENTQ_0,
 	.version = MCASP_VERSION_3,
 };
 
-static struct snd_platform_data dra7_mcasp_pdata = {
+static struct davinci_mcasp_pdata dra7_mcasp_pdata = {
 	.tx_dma_offset = 0x200,
 	.rx_dma_offset = 0x284,
 	.asp_chan_q = EVENTQ_0,
@@ -912,11 +912,11 @@ err1:
 	return ret;
 }
 
-static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
+static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 						struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct snd_platform_data *pdata = NULL;
+	struct davinci_mcasp_pdata *pdata = NULL;
 	const struct of_device_id *match =
 			of_match_device(mcasp_dt_ids, &pdev->dev);
 	struct of_phandle_args dma_spec;
@@ -929,7 +929,7 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
 		pdata = pdev->dev.platform_data;
 		return pdata;
 	} else if (match) {
-		pdata = (struct snd_platform_data *) match->data;
+		pdata = (struct davinci_mcasp_pdata*) match->data;
 	} else {
 		/* control shouldn't reach here. something is wrong */
 		ret = -EINVAL;
@@ -1023,7 +1023,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct davinci_pcm_dma_params *dma_data;
 	struct resource *mem, *ioarea, *res, *dat;
-	struct snd_platform_data *pdata;
+	struct davinci_mcasp_pdata *pdata;
 	struct davinci_mcasp *mcasp;
 	int ret;
 
-- 
1.8.5.3
