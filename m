From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v4 06/10] ASoC: tlv320aic32x4: Move aosr and
	dosr setting to separate functions
Date: Thu, 21 Mar 2019 17:58:50 -0700
Message-ID: <20190322005854.23360-7-nh6z@nh6z.net>
References: <20190322005854.23360-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp73.ord1d.emailsrvr.com (smtp73.ord1d.emailsrvr.com
 [184.106.54.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A83EAF89714
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 01:59:10 +0100 (CET)
In-Reply-To: <20190322005854.23360-1-nh6z@nh6z.net>
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

Move these to separate helper functions.  This looks cleaner and fits
better with the new clock setting in CCF.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index c3e9f65b26a7..bf3a80237b03 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -718,6 +718,20 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
+static int aic32x4_set_aosr(struct snd_soc_component *component, u8 aosr)
+{
+	return snd_soc_component_write(component, AIC32X4_AOSR, aosr);
+}
+
+static int aic32x4_set_dosr(struct snd_soc_component *component, u16 dosr)
+{
+	snd_soc_component_write(component, AIC32X4_DOSRMSB, dosr >> 8);
+	snd_soc_component_write(component, AIC32X4_DOSRLSB,
+		      (dosr & 0xff));
+
+	return 0;
+}
+
 static int aic32x4_set_processing_blocks(struct snd_soc_component *component,
 						u8 r_block, u8 p_block)
 {
@@ -763,14 +777,10 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	clk_set_rate(clocks[4].clk, aic32x4_divs[i].mdac_rate);
 	clk_set_rate(clocks[5].clk, aic32x4_divs[i].bdiv_rate);
 
-	aic32x4_set_processing_blocks(component, aic32x4_divs[i].r_block, aic32x4_divs[i].p_block);
+	aic32x4_set_aosr(component, aic32x4_divs[i].aosr);
+	aic32x4_set_dosr(component, aic32x4_divs[i].dosr);
 
-	/* DOSR MSB & LSB values */
-	snd_soc_component_write(component, AIC32X4_DOSRMSB, aic32x4_divs[i].dosr >> 8);
-	snd_soc_component_write(component, AIC32X4_DOSRLSB, (aic32x4_divs[i].dosr & 0xff));
-
-	/* AOSR value */
-	snd_soc_component_write(component, AIC32X4_AOSR, aic32x4_divs[i].aosr);
+	aic32x4_set_processing_blocks(component, aic32x4_divs[i].r_block, aic32x4_divs[i].p_block);
 
 	return 0;
 }
-- 
2.19.1
