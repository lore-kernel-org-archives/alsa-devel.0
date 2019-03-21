From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v3 06/11] ASoC: tlv320aic32x4: Control clock
	gating with CCF
Date: Wed, 20 Mar 2019 19:38:49 -0700
Message-ID: <20190321023854.16947-7-nh6z@nh6z.net>
References: <20190321023854.16947-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp65.ord1c.emailsrvr.com (smtp65.ord1c.emailsrvr.com
 [108.166.43.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40861F8971B
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 03:39:15 +0100 (CET)
In-Reply-To: <20190321023854.16947-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

Control the clock gating to the various clock components to use
the CCF.  This allows us to prepare_enalbe only 3 clocks and the
relationships assigned to them will cause upstream clockss to
enable automatically.  Additionally we can do this in a single
call to the CCF.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 67 +++++++-------------------------
 1 file changed, 13 insertions(+), 54 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index bf9ccda6616d..c3e9f65b26a7 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -834,41 +834,25 @@ static int aic32x4_mute(struct snd_soc_dai *dai, int mute)
 static int aic32x4_set_bias_level(struct snd_soc_component *component,
 				  enum snd_soc_bias_level level)
 {
-	struct aic32x4_priv *aic32x4 = snd_soc_component_get_drvdata(component);
 	int ret;
 
+	struct clk_bulk_data clocks[] = {
+		{ .id = "madc" },
+		{ .id = "mdac" },
+		{ .id = "bdiv" },
+	};
+
+	ret = devm_clk_bulk_get(component->dev, ARRAY_SIZE(clocks), clocks);
+	if (ret)
+		return ret;
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		/* Switch on master clock */
-		ret = clk_prepare_enable(aic32x4->mclk);
+		ret = clk_bulk_prepare_enable(ARRAY_SIZE(clocks), clocks);
 		if (ret) {
-			dev_err(component->dev, "Failed to enable master clock\n");
+			dev_err(component->dev, "Failed to enable clocks\n");
 			return ret;
 		}
-
-		/* Switch on PLL */
-		snd_soc_component_update_bits(component, AIC32X4_PLLPR,
-					AIC32X4_PLLEN, AIC32X4_PLLEN);
-
-		/* Switch on NDAC Divider */
-		snd_soc_component_update_bits(component, AIC32X4_NDAC,
-					AIC32X4_NDACEN, AIC32X4_NDACEN);
-
-		/* Switch on MDAC Divider */
-		snd_soc_component_update_bits(component, AIC32X4_MDAC,
-					AIC32X4_MDACEN, AIC32X4_MDACEN);
-
-		/* Switch on NADC Divider */
-		snd_soc_component_update_bits(component, AIC32X4_NADC,
-					AIC32X4_NADCEN, AIC32X4_NADCEN);
-
-		/* Switch on MADC Divider */
-		snd_soc_component_update_bits(component, AIC32X4_MADC,
-					AIC32X4_MADCEN, AIC32X4_MADCEN);
-
-		/* Switch on BCLK_N Divider */
-		snd_soc_component_update_bits(component, AIC32X4_BCLKN,
-					AIC32X4_BCLKEN, AIC32X4_BCLKEN);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
@@ -877,32 +861,7 @@ static int aic32x4_set_bias_level(struct snd_soc_component *component,
 		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
 			break;
 
-		/* Switch off BCLK_N Divider */
-		snd_soc_component_update_bits(component, AIC32X4_BCLKN,
-					AIC32X4_BCLKEN, 0);
-
-		/* Switch off MADC Divider */
-		snd_soc_component_update_bits(component, AIC32X4_MADC,
-					AIC32X4_MADCEN, 0);
-
-		/* Switch off NADC Divider */
-		snd_soc_component_update_bits(component, AIC32X4_NADC,
-					AIC32X4_NADCEN, 0);
-
-		/* Switch off MDAC Divider */
-		snd_soc_component_update_bits(component, AIC32X4_MDAC,
-					AIC32X4_MDACEN, 0);
-
-		/* Switch off NDAC Divider */
-		snd_soc_component_update_bits(component, AIC32X4_NDAC,
-					AIC32X4_NDACEN, 0);
-
-		/* Switch off PLL */
-		snd_soc_component_update_bits(component, AIC32X4_PLLPR,
-					AIC32X4_PLLEN, 0);
-
-		/* Switch off master clock */
-		clk_disable_unprepare(aic32x4->mclk);
+		clk_bulk_disable_unprepare(ARRAY_SIZE(clocks), clocks);
 		break;
 	case SND_SOC_BIAS_OFF:
 		break;
-- 
2.19.1
