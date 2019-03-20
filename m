From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 11/12] ASoC: tlv320aic32x4: Propery Set
	Processing Blocks
Date: Tue, 19 Mar 2019 21:51:28 -0700
Message-ID: <20190320045129.6859-12-nh6z@nh6z.net>
References: <20190320045129.6859-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp113.ord1c.emailsrvr.com (smtp113.ord1c.emailsrvr.com
 [108.166.43.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CDEAF89720
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 05:51:55 +0100 (CET)
In-Reply-To: <20190320045129.6859-1-nh6z@nh6z.net>
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

Different processing blocks are required for different sampling
rates and power parameters.  Set the processing blocks based
on this information.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e8a9fb9d5e25..a5457d3de1b1 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -645,6 +645,18 @@ static int aic32x4_set_dosr(struct snd_soc_component *component, u16 dosr)
 	return 0;
 }
 
+static int aic32x4_set_processing_blocks(struct snd_soc_component *component,
+						u8 r_block, u8 p_block)
+{
+	if (r_block > 18 || p_block > 25)
+		return -EINVAL;
+
+	snd_soc_component_write(component, AIC32X4_ADCSPB, r_block);
+	snd_soc_component_write(component, AIC32X4_DACSPB, p_block);
+
+	return 0;
+}
+
 static int aic32x4_setup_clocks(struct snd_soc_component *component,
 				unsigned int sample_rate)
 {
@@ -678,16 +690,19 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 		adc_resource_class = 6;
 		dac_resource_class = 8;
 		dosr_increment = 8;
+		aic32x4_set_processing_blocks(component, 1, 1);
 	} else if (sample_rate <= 96000) {
 		aosr = 64;
 		adc_resource_class = 6;
 		dac_resource_class = 8;
 		dosr_increment = 4;
+		aic32x4_set_processing_blocks(component, 1, 9);
 	} else if (sample_rate == 192000) {
 		aosr = 32;
 		adc_resource_class = 3;
 		dac_resource_class = 4;
 		dosr_increment = 2;
+		aic32x4_set_processing_blocks(component, 13, 19);
 	} else {
 		dev_err(component->dev, "Sampling rate not supported\n");
 		return -EINVAL;
-- 
2.19.1
