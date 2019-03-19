From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH 07/13] ASoC: tlv320aic32x4: Move aosr and dosr
	setting to separate functions
Date: Mon, 18 Mar 2019 20:37:50 -0700
Message-ID: <20190319033756.20616-8-nh6z@nh6z.net>
References: <20190319033756.20616-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp89.iad3a.emailsrvr.com (smtp89.iad3a.emailsrvr.com
 [173.203.187.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 845F2F89713
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 04:38:16 +0100 (CET)
In-Reply-To: <20190319033756.20616-1-nh6z@nh6z.net>
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
 sound/soc/codecs/tlv320aic32x4.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index ecf692e346b6..1d347adbcc30 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -716,6 +716,20 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
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
 static int aic32x4_setup_clocks(struct snd_soc_component *component,
 				unsigned int sample_rate,
 				unsigned int parent_rate)
@@ -748,13 +762,8 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	clk_set_rate(clocks[3].clk, aic32x4_divs[i].ndac_rate);
 	clk_set_rate(clocks[4].clk, aic32x4_divs[i].mdac_rate);
 	clk_set_rate(clocks[5].clk, aic32x4_divs[i].bdiv_rate);
-
-	/* DOSR MSB & LSB values */
-	snd_soc_component_write(component, AIC32X4_DOSRMSB, aic32x4_divs[i].dosr >> 8);
-	snd_soc_component_write(component, AIC32X4_DOSRLSB, (aic32x4_divs[i].dosr & 0xff));
-
-	/* AOSR value */
-	snd_soc_component_write(component, AIC32X4_AOSR, aic32x4_divs[i].aosr);
+	aic32x4_set_aosr(component, aic32x4_divs[i].aosr);
+	aic32x4_set_dosr(component, aic32x4_divs[i].dosr);
 
 	return 0;
 }
-- 
2.19.1
