From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: enable mic and short detect
	debounce.
Date: Tue, 31 Jul 2012 16:20:04 +0100
Message-ID: <1343748004-11496-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20CDE265D24
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 17:20:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Chris Rattray <crattray@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Chris Rattray <crattray@opensource.wolfsonmicro.com>

Signed-off-by: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 5fc3179..02080da 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3262,6 +3262,12 @@ int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 
 	snd_soc_update_bits(codec, WM8994_MICBIAS, WM8994_MICD_ENA, reg);
 
+	/* enable MICDET and MICSHRT deboune */
+	snd_soc_update_bits(codec, WM8994_IRQ_DEBOUNCE,
+			    WM8994_MIC1_DET_DB_MASK | WM8994_MIC1_SHRT_DB_MASK |
+			    WM8994_MIC2_DET_DB_MASK | WM8994_MIC2_SHRT_DB_MASK,
+			    WM8994_MIC1_DET_DB | WM8994_MIC1_SHRT_DB);
+
 	snd_soc_dapm_sync(&codec->dapm);
 
 	return 0;
-- 
1.7.10.4
