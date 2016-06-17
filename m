From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: patch reg-0x8a
Date: Fri, 17 Jun 2016 12:08:02 +0800
Message-ID: <1466136482-21944-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D64F22604EB
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 06:08:17 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

reg-8a assign the tracking source for each ASRC tracker. The default
value is 0x0000 which means all ASRC trackers will track LRCK1. But
in most case, we wish each ASRC tracker track the corresponding LRCK.
i.e. ASRC1 tracks LRCK1, ASRC2 tracks LRCK2 and so on. So, we rewrite
reg-8a as 0x0123.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 0af5ddb..8ef467f 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -55,6 +55,7 @@ static const struct reg_sequence init_list[] = {
 	{ RT5670_PR_BASE + 0x14, 0x9a8a },
 	{ RT5670_PR_BASE + 0x38, 0x3ba1 },
 	{ RT5670_PR_BASE + 0x3d, 0x3640 },
+	{ 0x8a, 0x0123 },
 };
 
 static const struct reg_default rt5670_reg[] = {
@@ -131,7 +132,7 @@ static const struct reg_default rt5670_reg[] = {
 	{ 0x87, 0x0000 },
 	{ 0x88, 0x0000 },
 	{ 0x89, 0x0000 },
-	{ 0x8a, 0x0000 },
+	{ 0x8a, 0x0123 },
 	{ 0x8b, 0x0000 },
 	{ 0x8c, 0x0003 },
 	{ 0x8d, 0x0000 },
-- 
1.8.1.1.439.g50a6b54
