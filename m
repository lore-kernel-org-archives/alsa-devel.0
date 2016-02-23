From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Make logging of FLL
	calculations clearer
Date: Tue, 23 Feb 2016 14:16:32 +0000
Message-ID: <1456236992-32028-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E715260535
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 15:16:39 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The debug logging of FLL calculations was confusing. Values were
printed in hex without indicating this by a leading 0x, and
despite these normally being required in decimal. Also where the
register value isn't the actual value (it s a power-of-two or
0 means 1, 1 means 2, ...)  it was unclear whether the actual or
register value was shown.

This patch changes the log print so that all mathematical values
are shown in decimal, all register values are shown in hex with a
0x prefix, and where the register value isn't the actual integer
value the decimal integer value is shown in () after the hex
register value.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 913cfa8..92d22a0 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2149,11 +2149,12 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 		return -EINVAL;
 	}
 
-	arizona_fll_dbg(fll, "N=%x THETA=%x LAMBDA=%x\n",
+	arizona_fll_dbg(fll, "N=%d THETA=%d LAMBDA=%d\n",
 			cfg->n, cfg->theta, cfg->lambda);
-	arizona_fll_dbg(fll, "FRATIO=%x(%d) OUTDIV=%x REFCLK_DIV=%x\n",
-			cfg->fratio, cfg->fratio, cfg->outdiv, cfg->refdiv);
-	arizona_fll_dbg(fll, "GAIN=%d\n", cfg->gain);
+	arizona_fll_dbg(fll, "FRATIO=0x%x(%d) OUTDIV=%d REFCLK_DIV=0x%x(%d)\n",
+			cfg->fratio, ratio, cfg->outdiv,
+			cfg->refdiv, 1 << cfg->refdiv);
+	arizona_fll_dbg(fll, "GAIN=0x%x(%d)\n", cfg->gain, 1 << cfg->gain);
 
 	return 0;
 
-- 
1.9.1
