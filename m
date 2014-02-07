From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: pcm512x: Implement analogue volume
	control
Date: Fri,  7 Feb 2014 19:50:52 +0000
Message-ID: <1391802652-11218-2-git-send-email-broonie@kernel.org>
References: <1391802652-11218-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7392C265454
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 21:06:37 +0100 (CET)
In-Reply-To: <1391802652-11218-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Meier <florian.meier@koalo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

There are some analogue volume controls in page 1 of the register map so
implement support for them now that we can access the registers.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm512x.c | 6 ++++++
 sound/soc/codecs/pcm512x.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index cdcb51e4c86f..3a0bbb6ab242 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -184,6 +184,8 @@ static bool pcm512x_volatile(struct device *dev, unsigned int reg)
 }
 
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -10350, 50, 1);
+static const DECLARE_TLV_DB_SCALE(analog_tlv, -600, 600, 0);
+static const DECLARE_TLV_DB_SCALE(boost_tlv, 0, 80, 0);
 
 static const char * const pcm512x_dsp_program_texts[] = {
 	"FIR interpolation with de-emphasis",
@@ -261,6 +263,10 @@ static const struct soc_enum pcm512x_veds =
 static const struct snd_kcontrol_new pcm512x_controls[] = {
 SOC_DOUBLE_R_TLV("Playback Digital Volume", PCM512x_DIGITAL_VOLUME_2,
 		 PCM512x_DIGITAL_VOLUME_3, 0, 255, 1, digital_tlv),
+SOC_DOUBLE_TLV("Playback Volume", PCM512x_ANALOG_GAIN_CTRL,
+	       PCM512x_LAGN_SHIFT, PCM512x_RAGN_SHIFT, 1, 1, analog_tlv),
+SOC_DOUBLE_TLV("Playback Boost Volume", PCM512x_ANALOG_GAIN_BOOST,
+	       PCM512x_AGBL_SHIFT, PCM512x_AGBR_SHIFT, 1, 0, boost_tlv),
 SOC_DOUBLE("Playback Digital Switch", PCM512x_MUTE, PCM512x_RQML_SHIFT,
 	   PCM512x_RQMR_SHIFT, 1, 1),
 
diff --git a/sound/soc/codecs/pcm512x.h b/sound/soc/codecs/pcm512x.h
index e58743c965d6..ac4a52c9ccf4 100644
--- a/sound/soc/codecs/pcm512x.h
+++ b/sound/soc/codecs/pcm512x.h
@@ -151,4 +151,12 @@
 #define PCM512x_AMLE_SHIFT 1
 #define PCM512x_AMLR_SHIFT 0
 
+/* Page 1, Register 2 - analog volume control */
+#define PCM512x_RAGN_SHIFT 0
+#define PCM512x_LAGN_SHIFT 4
+
+/* Page 1, Register 7 - analog boost control */
+#define PCM512x_AGBR_SHIFT 0
+#define PCM512x_AGBL_SHIFT 4
+
 #endif
-- 
1.9.rc1
