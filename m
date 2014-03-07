From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/9] ASoC: arizona: Add defines for FLL
	configuration constants
Date: Fri,  7 Mar 2014 16:34:18 +0000
Message-ID: <1394210065-23941-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E17D3265A19
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 17:42:49 +0100 (CET)
In-Reply-To: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Improve readability by adding defines for some of the constants
associated with FLL configuration.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e4c1c9e..e6f8290 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -53,6 +53,12 @@
 #define ARIZONA_AIF_RX_ENABLES                  0x1A
 #define ARIZONA_AIF_FORCE_WRITE                 0x1B
 
+#define ARIZONA_FLL_MAX_FREF   13500000
+#define ARIZONA_FLL_MIN_FVCO   90000000
+#define ARIZONA_FLL_MAX_REFDIV 8
+#define ARIZONA_FLL_MIN_OUTDIV 2
+#define ARIZONA_FLL_MAX_OUTDIV 7
+
 #define arizona_fll_err(_fll, fmt, ...) \
 	dev_err(_fll->arizona->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
 #define arizona_fll_warn(_fll, fmt, ...) \
@@ -1399,11 +1405,11 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 	/* Fref must be <=13.5MHz */
 	div = 1;
 	cfg->refdiv = 0;
-	while ((Fref / div) > 13500000) {
+	while ((Fref / div) > ARIZONA_FLL_MAX_FREF) {
 		div *= 2;
 		cfg->refdiv++;
 
-		if (div > 8) {
+		if (div > ARIZONA_FLL_MAX_REFDIV) {
 			arizona_fll_err(fll,
 					"Can't scale %dMHz in to <=13.5MHz\n",
 					Fref);
@@ -1415,10 +1421,10 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 	Fref /= div;
 
 	/* Fvco should be over the targt; don't check the upper bound */
-	div = 2;
-	while (Fout * div < 90000000 * fll->vco_mult) {
+	div = ARIZONA_FLL_MIN_OUTDIV;
+	while (Fout * div < ARIZONA_FLL_MIN_FVCO * fll->vco_mult) {
 		div++;
-		if (div > 7) {
+		if (div > ARIZONA_FLL_MAX_OUTDIV) {
 			arizona_fll_err(fll, "No FLL_OUTDIV for Fout=%uHz\n",
 					Fout);
 			return -EINVAL;
-- 
1.7.2.5
