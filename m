From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Suppress noop SYSCLK updates in
	WM8915
Date: Fri,  3 Jun 2011 18:47:00 +0100
Message-ID: <1307123223-30847-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7DADA24371
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 19:47:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8915.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index 5a59ef7..c61bc32 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -55,6 +55,7 @@ struct wm8915_priv {
 	int ldo1ena;
 
 	int sysclk;
+	int sysclk_src;
 
 	int fll_src;
 	int fll_fref;
@@ -1834,6 +1835,9 @@ static int wm8915_set_sysclk(struct snd_soc_dai *dai,
 	int src;
 	int old;
 
+	if (freq == wm8915->sysclk && clk_id == wm8915->sysclk_src)
+		return 0;
+
 	/* Disable SYSCLK while we reconfigure */
 	old = snd_soc_read(codec, WM8915_AIF_CLOCKING_1);
 	snd_soc_update_bits(codec, WM8915_AIF_CLOCKING_1,
@@ -1885,6 +1889,8 @@ static int wm8915_set_sysclk(struct snd_soc_dai *dai,
 	snd_soc_update_bits(codec, WM8915_AIF_CLOCKING_1,
 			    WM8915_SYSCLK_ENA, old);
 
+	wm8915->sysclk_src = clk_id;
+
 	return 0;
 }
 
-- 
1.7.5.3
