From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Unconditionally wait for the FLL
	to lock
Date: Wed, 12 Dec 2012 11:35:43 +0900
Message-ID: <1355279743-31487-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 876542617B0
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 03:35:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If the FLL is being shut down we will exit early so there is no need to
check here and in fact we're checking the wrong thing anyway.

Reported-by: Graeme Gregory <gg@slimlogic.co.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 09816e8..50b0983 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2875,22 +2875,20 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	ret = 0;
 
-	if (fll1 & WM8962_FLL_ENA) {
-		/* This should be a massive overestimate but go even
-		 * higher if we'll error out
-		 */
-		if (wm8962->irq)
-			timeout = msecs_to_jiffies(5);
-		else
-			timeout = msecs_to_jiffies(1);
+	/* This should be a massive overestimate but go even
+	 * higher if we'll error out
+	 */
+	if (wm8962->irq)
+		timeout = msecs_to_jiffies(5);
+	else
+		timeout = msecs_to_jiffies(1);
 
-		timeout = wait_for_completion_timeout(&wm8962->fll_lock,
-						      timeout);
+	timeout = wait_for_completion_timeout(&wm8962->fll_lock,
+					      timeout);
 
-		if (timeout == 0 && wm8962->irq) {
-			dev_err(codec->dev, "FLL lock timed out");
-			ret = -ETIMEDOUT;
-		}
+	if (timeout == 0 && wm8962->irq) {
+		dev_err(codec->dev, "FLL lock timed out");
+		ret = -ETIMEDOUT;
 	}
 
 	wm8962->fll_fref = Fref;
-- 
1.7.10.4
