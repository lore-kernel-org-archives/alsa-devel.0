From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/6] ASoC: da7219: Fix Sidetone to work regardless of DAI
 capture
Date: Tue, 22 Dec 2015 18:27:52 +0000
Message-ID: <2ed293aa5fa88ff652f1c6628a09dc6fe36ea112.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Previously Sidetone would operate only when capture to DAI was in
progress, due to DAPM path configuration. There is no reason why
this should not operate without DAI capture, so this patch updates
the DAPM path accordingly.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 0ba714c..253d8e7 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -968,10 +968,11 @@ static const struct snd_soc_dapm_route da7219_audio_map[] = {
 	{"Mixin PGA", NULL, "Mic PGA"},
 	{"ADC", NULL, "Mixin PGA"},
 
-	{"Sidetone Filter", NULL, "ADC"},
 	{"Mixer In", NULL, "Mixer In Supply"},
 	{"Mixer In", "Mic Switch", "ADC"},
 
+	{"Sidetone Filter", NULL, "Mixer In"},
+
 	{"Tone Generator", NULL, "TONE"},
 
 	DA7219_OUT_DAI_MUX_ROUTES("Out DAIL Mux"),
-- 
1.9.3
