From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/6] ASoC: rt5640: Remove the pre-allocated
	size of reg_default
Date: Fri, 28 Mar 2014 20:28:25 +0800
Message-ID: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 453B62654B8
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 13:28:49 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

In order to prevent the redundant memory usage, the pre-allocated size of
reg_default should be remove.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index cf041e3..9427511 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -59,7 +59,7 @@ static struct reg_default init_list[] = {
 };
 #define RT5640_INIT_REG_LEN ARRAY_SIZE(init_list)
 
-static const struct reg_default rt5640_reg[RT5640_VENDOR_ID2 + 1] = {
+static const struct reg_default rt5640_reg[] = {
 	{ 0x00, 0x000e },
 	{ 0x01, 0xc8c8 },
 	{ 0x02, 0xc8c8 },
-- 
1.8.1.1.439.g50a6b54
