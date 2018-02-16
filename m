From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3] ASoC: sgtl5000: Fix suspend/resume
Date: Fri, 16 Feb 2018 11:58:54 -0200
Message-ID: <1518789534-11828-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 503A3267E3C
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 14:58:55 +0100 (CET)
Received: by mail-qk0-f195.google.com with SMTP id o7so3866451qkc.1
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 05:58:55 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, eric@nelint.com, alsa-devel@alsa-project.org, stable@vger.kernel.org, max.krummenacher@toradex.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit 8419caa72702 ("ASoC: sgtl5000: Do not disable regulators in
SND_SOC_BIAS_OFF") causes the sgtl5000 to fail after a suspend/resume
sequence:

# aplay /media/a2002011001-e02.wav
Playing WAVE '/media/a2002011001-e02.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Stereo
aplay: pcm_write:2051: write error: Input/output error

The problem is caused by the fact that the aforementioned commit
dropped the cache handling, so re-introduce the register map
resync to fix the problem.

Cc: <stable@vger.kernel.org>
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v2:
- Rebased against Linus' tree

 sound/soc/codecs/sgtl5000.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index e1ab553..7ff5cb7 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -871,15 +871,26 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
+	struct sgtl5000_priv *sgtl = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 	case SND_SOC_BIAS_STANDBY:
+		regcache_cache_only(sgtl->regmap, false);
+		ret = regcache_sync(sgtl->regmap);
+		if (ret) {
+			regcache_cache_only(sgtl->regmap, true);
+			return ret;
+		}
+
 		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 				    SGTL5000_REFTOP_POWERUP,
 				    SGTL5000_REFTOP_POWERUP);
 		break;
 	case SND_SOC_BIAS_OFF:
+		regcache_cache_only(sgtl->regmap, true);
 		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 				    SGTL5000_REFTOP_POWERUP, 0);
 		break;
-- 
2.7.4
