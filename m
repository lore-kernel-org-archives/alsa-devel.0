From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/3] ASoC: rt5677: Remove the redundant
	definition in head file
Date: Mon, 7 Jul 2014 15:36:59 +0800
Message-ID: <1404718621-15516-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F307265468
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 09:37:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch removes the redundant definition in head file

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 08252e7..863393e 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1393,13 +1393,6 @@
 #define RT5677_DSP_IB_9_L			(0x1 << 1)
 #define RT5677_DSP_IB_9_L_SFT			1
 
-/* Debug String Length */
-#define RT5677_REG_DISP_LEN 23
-
-#define RT5677_NO_JACK		BIT(0)
-#define RT5677_HEADSET_DET	BIT(1)
-#define RT5677_HEADPHO_DET	BIT(2)
-
 /* System Clock Source */
 enum {
 	RT5677_SCLK_S_MCLK,
-- 
1.8.1.1.439.g50a6b54
