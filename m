From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5616: fix 0x91 default value
Date: Fri, 20 Oct 2017 15:46:55 +0800
Message-ID: <1508485615-28969-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E555267699
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 09:47:19 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The default value of register 0x91 is 0x0c00 instead of 0x0000.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5616.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index c94e94f..0e5f54a 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -98,7 +98,7 @@ static const struct reg_default rt5616_reg[] = {
 	{ 0x8e, 0x0004 },
 	{ 0x8f, 0x1100 },
 	{ 0x90, 0x0000 },
-	{ 0x91, 0x0000 },
+	{ 0x91, 0x0c00 },
 	{ 0x92, 0x0000 },
 	{ 0x93, 0x2000 },
 	{ 0x94, 0x0200 },
-- 
2.7.4
