From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2000: Expose ANC gain adjustment
Date: Wed, 30 Jan 2013 21:38:44 +0800
Message-ID: <1359553124-10605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23C0D264EFC
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 14:47:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <Liam.R.Girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

No TLV information since it's not actually a direct gain control.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 4d809ab..f2ac38b 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -666,6 +666,7 @@ static int wm2000_speaker_put(struct snd_kcontrol *kcontrol,
 }
 
 static const struct snd_kcontrol_new wm2000_controls[] = {
+	SOC_SINGLE("ANC Volume", WM2000_REG_ANC_GAIN_CTRL, 0, 255, 0),
 	SOC_SINGLE_BOOL_EXT("WM2000 ANC Switch", 0,
 			    wm2000_anc_mode_get,
 			    wm2000_anc_mode_put),
@@ -778,6 +779,8 @@ static int wm2000_probe(struct snd_soc_codec *codec)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 
+	snd_soc_codec_set_cache_io(codec, 16, 8, SND_SOC_REGMAP);
+
 	/* This will trigger a transition to standby mode by default */
 	wm2000_anc_set_mode(wm2000);
 
-- 
1.7.10.4
