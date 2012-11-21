From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Suppress noop FLL updates
Date: Wed, 21 Nov 2012 14:20:14 +0900
Message-ID: <1353475214-6455-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E68F265153
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 06:27:21 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    6 ++++++
 sound/soc/codecs/arizona.h |    2 ++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 24ad57b..3883aef 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -944,6 +944,9 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 	bool ena;
 	int ret;
 
+	if (fll->fref == Fref && fll->fout == Fout)
+		return 0;
+
 	ret = regmap_read(arizona->regmap, fll->base + 1, &reg);
 	if (ret != 0) {
 		arizona_fll_err(fll, "Failed to read current state: %d\n",
@@ -1021,6 +1024,9 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 	if (ret == 0)
 		arizona_fll_warn(fll, "Timed out waiting for lock\n");
 
+	fll->fref = Fref;
+	fll->fout = Fout;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(arizona_set_fll);
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 744786b..5e9ade7 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -192,6 +192,8 @@ struct arizona_fll {
 	unsigned int vco_mult;
 	struct completion lock;
 	struct completion ok;
+	unsigned int fref;
+	unsigned int fout;
 
 	char lock_name[ARIZONA_FLL_NAME_LEN];
 	char clock_ok_name[ARIZONA_FLL_NAME_LEN];
-- 
1.7.10.4
