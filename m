From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: In arizona_calc_fratio make new codecs the default case
Date: Wed, 16 Dec 2015 17:06:24 +0000
Message-ID: <1450285584-14472-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch rearranges the switch statement in arizona_calc_fratio so
that older codecs are the special cases, with the default case
applying to newer codecs (WM8998 and later). This is preferable
because it avoids having to patch new cases in every time a new
codec is added.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index d90b3c5..38a73e3 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2020,18 +2020,18 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 	}
 
 	switch (fll->arizona->type) {
+	case WM5102:
+	case WM8997:
+		return init_ratio;
 	case WM5110:
 	case WM8280:
 		if (fll->arizona->rev < 3 || sync)
 			return init_ratio;
 		break;
-	case WM8998:
-	case WM1814:
+	default:
 		if (sync)
 			return init_ratio;
 		break;
-	default:
-		return init_ratio;
 	}
 
 	cfg->fratio = init_ratio - 1;
-- 
1.9.1
