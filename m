From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH 2/2] ASoC: tfa9879: Add bass and treble
	gain/freq controls.
Date: Thu,  6 Nov 2014 13:54:01 +0100
Message-ID: <1415278441-27866-3-git-send-email-peda@lysator.liu.se>
References: <1415278441-27866-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 770C326520A
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 13:54:28 +0100 (CET)
In-Reply-To: <1415278441-27866-1-git-send-email-peda@lysator.liu.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/tfa9879.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index 90cc28f7e6ed..0d62962542e2 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -213,10 +213,26 @@ static bool tfa9879_volatile_register(struct device *dev, unsigned int reg)
 }
 
 static const DECLARE_TLV_DB_SCALE(volume_tlv, -7050, 50, 1);
+static const DECLARE_TLV_DB_SCALE(tb_gain_tlv, -1800, 200, 0);
+static const char * const tb_freq_text[] = {
+	"Low", "Mid", "High"
+};
+static const struct soc_enum treble_freq_enum =
+	SOC_ENUM_SINGLE(TFA9879_BASS_TREBLE, TFA9879_F_TRBLE_SHIFT,
+			ARRAY_SIZE(tb_freq_text), tb_freq_text);
+static const struct soc_enum bass_freq_enum =
+	SOC_ENUM_SINGLE(TFA9879_BASS_TREBLE, TFA9879_F_BASS_SHIFT,
+			ARRAY_SIZE(tb_freq_text), tb_freq_text);
 
 static const struct snd_kcontrol_new tfa9879_controls[] = {
 	SOC_SINGLE_TLV("PCM Playback Volume", TFA9879_VOLUME_CONTROL,
 		       TFA9879_VOL_SHIFT, 0xbd, 1, volume_tlv),
+	SOC_SINGLE_TLV("Treble Gain Volume", TFA9879_BASS_TREBLE,
+		       TFA9879_G_TRBLE_SHIFT, 18, 0, tb_gain_tlv),
+	SOC_SINGLE_TLV("Bass Gain Volume", TFA9879_BASS_TREBLE,
+		       TFA9879_G_BASS_SHIFT, 18, 0, tb_gain_tlv),
+	SOC_ENUM("Treble Corner Freq", treble_freq_enum),
+	SOC_ENUM("Bass Corner Freq", bass_freq_enum),
 };
 
 static const struct snd_soc_dapm_widget tfa9879_dapm_widgets[] = {
-- 
1.7.10.4
