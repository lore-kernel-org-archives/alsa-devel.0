From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: disable soft volume control
Date: Tue, 5 Jul 2016 13:23:55 +0800
Message-ID: <1467696235-31566-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C7A4265558
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 07:24:11 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koro.chen@mediatek.com, PC.Liao@mediatek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

With soft volume control function, rt5645/rt5650 will start with 0dB
volume and take a little time to adjust volume to given value. And it
will cause a bad user experience. This patch disable it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 97bf96e..c969f48 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -63,6 +63,7 @@ static const struct reg_sequence init_list[] = {
 	{RT5645_PR_BASE + 0x20,	0x611f},
 	{RT5645_PR_BASE + 0x21,	0x4040},
 	{RT5645_PR_BASE + 0x23,	0x0004},
+	{RT5645_PR_BASE + 0x00,	0x0a2a},
 	{RT5645_ASRC_4, 0x0120},
 };
 
-- 
1.8.1.1.439.g50a6b54
