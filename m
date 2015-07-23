From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: tas2552: Fix off-by-one for max_register
	setting
Date: Thu, 23 Jul 2015 22:56:04 +0800
Message-ID: <1437663364.20606.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 19E9526070C
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 16:56:11 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so158759048pac.3
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 07:56:09 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Dan Muprhy <dmurphy@ti.com>
List-Id: alsa-devel@alsa-project.org

The latest valid register is TAS2552_VBAT_DATA.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/tas2552.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
index 5746f8f..e34752b 100644
--- a/sound/soc/codecs/tas2552.h
+++ b/sound/soc/codecs/tas2552.h
@@ -42,7 +42,7 @@
 #define TAS2552_BOOST_APT_CTRL		0x14
 #define TAS2552_VER_NUM			0x16
 #define TAS2552_VBAT_DATA		0x19
-#define TAS2552_MAX_REG			0x20
+#define TAS2552_MAX_REG			TAS2552_VBAT_DATA
 
 /* CFG1 Register Masks */
 #define TAS2552_DEV_RESET		(1 << 0)
-- 
2.1.0
