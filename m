From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: cs35l32: Fix define for
	CS35L32_SDOUT_3ST
Date: Thu, 23 Jul 2015 08:28:50 +0800
Message-ID: <1437611330.6620.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id D826E26559B
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 02:28:55 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so146780040pac.3
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 17:28:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

According to the datasheet, the CS35L32_SDOUT_3ST is BIT(3).

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l32.h b/sound/soc/codecs/cs35l32.h
index 31ab804..1d6c250 100644
--- a/sound/soc/codecs/cs35l32.h
+++ b/sound/soc/codecs/cs35l32.h
@@ -80,7 +80,7 @@ struct cs35l32_platform_data {
 #define CS35L32_GAIN_MGR_MASK		0x08
 #define CS35L32_ADSP_SHARE_MASK		0x08
 #define CS35L32_ADSP_DATACFG_MASK	0x30
-#define CS35L32_SDOUT_3ST		0x80
+#define CS35L32_SDOUT_3ST		0x08
 #define CS35L32_BATT_REC_MASK		0x0E
 #define CS35L32_BATT_THRESH_MASK	0x30
 
-- 
2.1.0
