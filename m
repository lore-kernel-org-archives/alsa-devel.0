From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5645: fix reg-2f default value.
Date: Thu, 30 Jun 2016 20:29:24 +0800
Message-ID: <1467289764-2659-2-git-send-email-bardliao@realtek.com>
References: <1467289764-2659-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D1B9265191
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 14:29:36 +0200 (CEST)
In-Reply-To: <1467289764-2659-1-git-send-email-bardliao@realtek.com>
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

The default value of reg-2f in codec rt5650 is 0x5002, not 0x1002.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index c21e41c..c40b6d1 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -256,7 +256,7 @@ static const struct reg_default rt5650_reg[] = {
 	{ 0x2b, 0x5454 },
 	{ 0x2c, 0xaaa0 },
 	{ 0x2d, 0x0000 },
-	{ 0x2f, 0x1002 },
+	{ 0x2f, 0x5002 },
 	{ 0x31, 0x5000 },
 	{ 0x32, 0x0000 },
 	{ 0x33, 0x0000 },
-- 
1.8.1.1.439.g50a6b54
