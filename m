From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Modify the default value for
	ASRC function
Date: Fri, 14 Jul 2017 16:11:13 +0800
Message-ID: <1500019873-30391-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 701B5266C3C
 for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2017 10:11:25 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch modifies the default value for ASRC function. It could prevent
the pop noise and recording no sound with ASRC function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index ac6dd25..c46d47f 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -60,6 +60,7 @@ struct rt5663_priv {
 
 static const struct reg_sequence rt5663_patch_list[] = {
 	{ 0x002a, 0x8080 },
+	{ 0x0086, 0x0028 },
 };
 
 static const struct reg_default rt5663_v2_reg[] = {
@@ -509,7 +510,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0082, 0x0000 },
 	{ 0x0083, 0x0000 },
 	{ 0x0084, 0x0000 },
-	{ 0x0086, 0x0008 },
+	{ 0x0086, 0x0028 },
 	{ 0x0087, 0x0000 },
 	{ 0x008a, 0x0000 },
 	{ 0x008b, 0x0000 },
-- 
2.7.4
