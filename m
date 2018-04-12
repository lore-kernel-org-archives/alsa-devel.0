From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 2/5] ASoC: tfa9879: fix whitespace issues
	caused by mindless conversion
Date: Thu, 12 Apr 2018 23:14:34 +0200
Message-ID: <20180412211437.21599-3-peda@axentia.se>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30138.outbound.protection.outlook.com [40.107.3.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F6DF266F69
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 23:15:25 +0200 (CEST)
In-Reply-To: <20180412211437.21599-1-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

Long lines and bad alignment disturbs the reading pleasure.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/tfa9879.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index 6d213c6d3920..c30e0efdbe39 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -88,13 +88,14 @@ static int tfa9879_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (tfa9879->lsb_justified)
-		snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-				    TFA9879_I2S_SET_MASK,
-				    i2s_set << TFA9879_I2S_SET_SHIFT);
+		snd_soc_component_update_bits(component,
+					      TFA9879_SERIAL_INTERFACE_1,
+					      TFA9879_I2S_SET_MASK,
+					      i2s_set << TFA9879_I2S_SET_SHIFT);
 
 	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-			    TFA9879_I2S_FS_MASK,
-			    fs << TFA9879_I2S_FS_SHIFT);
+				      TFA9879_I2S_FS_MASK,
+				      fs << TFA9879_I2S_FS_SHIFT);
 	return 0;
 }
 
@@ -103,8 +104,8 @@ static int tfa9879_digital_mute(struct snd_soc_dai *dai, int mute)
 	struct snd_soc_component *component = dai->component;
 
 	snd_soc_component_update_bits(component, TFA9879_MISC_CONTROL,
-			    TFA9879_S_MUTE_MASK,
-			    !!mute << TFA9879_S_MUTE_SHIFT);
+				      TFA9879_S_MUTE_MASK,
+				      !!mute << TFA9879_S_MUTE_SHIFT);
 
 	return 0;
 }
@@ -152,11 +153,11 @@ static int tfa9879_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-			    TFA9879_SCK_POL_MASK,
-			    sck_pol << TFA9879_SCK_POL_SHIFT);
+				      TFA9879_SCK_POL_MASK,
+				      sck_pol << TFA9879_SCK_POL_SHIFT);
 	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-			    TFA9879_I2S_SET_MASK,
-			    i2s_set << TFA9879_I2S_SET_SHIFT);
+				      TFA9879_I2S_SET_MASK,
+				      i2s_set << TFA9879_I2S_SET_SHIFT);
 	return 0;
 }
 
@@ -298,7 +299,7 @@ static int tfa9879_i2c_probe(struct i2c_client *i2c,
 			     tfa9879_regs[i].reg, tfa9879_regs[i].def);
 
 	return devm_snd_soc_register_component(&i2c->dev, &tfa9879_component,
-				      &tfa9879_dai, 1);
+					       &tfa9879_dai, 1);
 }
 
 static const struct i2c_device_id tfa9879_i2c_id[] = {
-- 
2.11.0
