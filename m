From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Fix debug logging level for
	FLLs and AIFs
Date: Wed,  6 Feb 2013 17:59:48 +0000
Message-ID: <1360173588-28094-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 544652602AC
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 18:59:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Use _dbg for debug messages.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ba3bd03..5e77a60 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -57,14 +57,14 @@
 #define arizona_fll_warn(_fll, fmt, ...) \
 	dev_warn(_fll->arizona->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
 #define arizona_fll_dbg(_fll, fmt, ...) \
-	dev_err(_fll->arizona->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
+	dev_dbg(_fll->arizona->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
 
 #define arizona_aif_err(_dai, fmt, ...) \
 	dev_err(_dai->dev, "AIF%d: " fmt, _dai->id, ##__VA_ARGS__)
 #define arizona_aif_warn(_dai, fmt, ...) \
 	dev_warn(_dai->dev, "AIF%d: " fmt, _dai->id, ##__VA_ARGS__)
 #define arizona_aif_dbg(_dai, fmt, ...) \
-	dev_err(_dai->dev, "AIF%d: " fmt, _dai->id, ##__VA_ARGS__)
+	dev_dbg(_dai->dev, "AIF%d: " fmt, _dai->id, ##__VA_ARGS__)
 
 static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol,
-- 
1.7.10.4
