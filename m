From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] ASoC: wm9713: Remove unused DAI ID defines
Date: Sat, 15 Oct 2016 19:32:53 +0200
Message-ID: <1476552777-1849-3-git-send-email-lars@metafoo.de>
References: <1476552777-1849-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A75A6266638
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 19:33:08 +0200 (CEST)
In-Reply-To: <1476552777-1849-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DAI ID defines are back from the time when DAIs were referenced by a
numerical ID. These days a string is used for matching instead and the
defines are unused. The last user of these defines was removed in commit
f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support"). So
remove the defines as well.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9713.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/wm9713.h b/sound/soc/codecs/wm9713.h
index 53df11b..7ecffc5 100644
--- a/sound/soc/codecs/wm9713.h
+++ b/sound/soc/codecs/wm9713.h
@@ -41,8 +41,4 @@
 #define WM9713_PCMBCLK_DIV_8	(3 << 9)
 #define WM9713_PCMBCLK_DIV_16	(4 << 9)
 
-#define WM9713_DAI_AC97_HIFI	0
-#define WM9713_DAI_AC97_AUX		1
-#define WM9713_DAI_PCM_VOICE	2
-
 #endif
-- 
2.1.4
