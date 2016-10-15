From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] ASoC: wm8753: Remove unused DAI ID defines
Date: Sat, 15 Oct 2016 19:32:54 +0200
Message-ID: <1476552777-1849-4-git-send-email-lars@metafoo.de>
References: <1476552777-1849-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 16C99266649
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
defines are unused. These particular IDs were never used and presumably
never will be, so remove them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8753.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wm8753.h b/sound/soc/codecs/wm8753.h
index 94edac1..8b39e36 100644
--- a/sound/soc/codecs/wm8753.h
+++ b/sound/soc/codecs/wm8753.h
@@ -112,7 +112,4 @@
 #define WM8753_VXCLK_DIV_8	(3 << 6)
 #define WM8753_VXCLK_DIV_16	(4 << 6)
 
-#define WM8753_DAI_HIFI		0
-#define WM8753_DAI_VOICE		1
-
 #endif
-- 
2.1.4
