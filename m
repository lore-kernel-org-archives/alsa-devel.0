From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/6] ASoC: arizona: Correct handling of FLL theta in synchroniser mode
Date: Fri, 2 Sep 2016 16:52:43 +0100
Message-ID: <1472831568-466-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Theta/lambda is used to give the fractional portion of the FLL
frequency multiplication. When the synchroniser is active the
reference path lambda value is hard coded in the hardware to
65536. This patch corrects the handling of theta such that it
is scaled to match this denominator, when the synchroniser is
active.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ccb3ca2..ded235f 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1920,8 +1920,8 @@ static struct {
 
 struct arizona_fll_cfg {
 	int n;
-	int theta;
-	int lambda;
+	unsigned int theta;
+	unsigned int lambda;
 	int refdiv;
 	int outdiv;
 	int fratio;
@@ -2233,6 +2233,10 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 	    fll->ref_src != fll->sync_src) {
 		arizona_calc_fll(fll, &cfg, fll->ref_freq, false);
 
+		/* Ref path hardcodes lambda to 65536 when sync is on */
+		if (fll->sync_src >= 0 && cfg.lambda)
+			cfg.theta = (cfg.theta * (1 << 16)) / cfg.lambda;
+
 		arizona_apply_fll(arizona, fll->base, &cfg, fll->ref_src,
 				  false);
 		if (fll->sync_src >= 0) {
-- 
2.1.4
