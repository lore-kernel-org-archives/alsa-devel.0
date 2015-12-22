From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 5/6] ASoC: da7219: Add support for 1.6V micbias level
Date: Tue, 22 Dec 2015 18:27:55 +0000
Message-ID: <7413a3e6c9996d2ae4c17ea60b220ad1d4012a9f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

HW can provide 1.6V micbias level as well the existing levels
already provided in the driver. This patch adds support for 1.6V
to the DT binding.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/devicetree/bindings/sound/da7219.txt | 2 +-
 include/sound/da7219.h                             | 3 ++-
 sound/soc/codecs/da7219.c                          | 3 +++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index 062a2a0..cf61681 100644
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -29,7 +29,7 @@ Optional properties:
 - clock-names : Clock name string for 'clocks' attribute, should be "mclk".
 
 - dlg,micbias-lvl : Voltage (mV) for Mic Bias
-	[<1800>, <2000>, <2200>, <2400>, <2600>]
+	[<1600>, <1800>, <2000>, <2200>, <2400>, <2600>]
 - dlg,mic-amp-in-sel : Mic input source type
 	["diff", "se_p", "se_n"]
 
diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 307198b..02876ac 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -16,7 +16,8 @@
 
 /* Mic Bias */
 enum da7219_micbias_voltage {
-	DA7219_MICBIAS_1_8V = 1,
+	DA7219_MICBIAS_1_6V = 0,
+	DA7219_MICBIAS_1_8V,
 	DA7219_MICBIAS_2_0V,
 	DA7219_MICBIAS_2_2V,
 	DA7219_MICBIAS_2_4V,
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 5daeec8..c019fef 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1410,6 +1410,8 @@ static enum da7219_micbias_voltage
 	da7219_of_micbias_lvl(struct snd_soc_codec *codec, u32 val)
 {
 	switch (val) {
+	case 1600:
+		return DA7219_MICBIAS_1_6V;
 	case 1800:
 		return DA7219_MICBIAS_1_8V;
 	case 2000:
@@ -1571,6 +1573,7 @@ static void da7219_handle_pdata(struct snd_soc_codec *codec)
 
 		/* Mic Bias voltages */
 		switch (pdata->micbias_lvl) {
+		case DA7219_MICBIAS_1_6V:
 		case DA7219_MICBIAS_1_8V:
 		case DA7219_MICBIAS_2_0V:
 		case DA7219_MICBIAS_2_2V:
-- 
1.9.3
