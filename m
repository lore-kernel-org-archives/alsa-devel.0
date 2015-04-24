From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5677: add register patch for PLL
Date: Fri, 24 Apr 2015 15:19:29 +0800
Message-ID: <1429859969-25258-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A86AE2604EB
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 09:19:52 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The PLL output will be unstable in some cases. We can fix it by
setting some registers.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5677.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index af18258..9c07a0c 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -62,6 +62,9 @@ static const struct reg_default init_list[] = {
 	{RT5677_PR_BASE + 0x1e,	0x0000},
 	{RT5677_PR_BASE + 0x12,	0x0eaa},
 	{RT5677_PR_BASE + 0x14,	0x018a},
+	{RT5677_PR_BASE + 0x15,	0x0490},
+	{RT5677_PR_BASE + 0x38,	0x0f71},
+	{RT5677_PR_BASE + 0x39,	0x0f71},
 };
 #define RT5677_INIT_REG_LEN ARRAY_SIZE(init_list)
 
-- 
1.8.1.1.439.g50a6b54
