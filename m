From: Sergej Sawazki <ce3a@gmx.de>
Subject: [PATCH] ASoC: wm8741: Remove unused WM8741_NUM_RATES
	macro
Date: Fri, 27 Jan 2017 23:20:53 +0100
Message-ID: <1485555653-11326-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 243B9267B76
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2017 23:21:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com
Cc: Sergej Sawazki <ce3a@gmx.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This macro is unused since commit e369bd006fd6 ("ASoC: wm8741: Allow master
clock switching").

Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
---
 sound/soc/codecs/wm8741.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 565d477..b8c1940 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -37,8 +37,6 @@ static const char *wm8741_supply_names[WM8741_NUM_SUPPLIES] = {
 	"DVDD",
 };
 
-#define WM8741_NUM_RATES 6
-
 /* codec private data */
 struct wm8741_priv {
 	struct wm8741_platform_data pdata;
-- 
2.7.4
