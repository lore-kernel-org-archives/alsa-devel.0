From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] ASoC: sglt5000: Fix
	SGTL5000_PLL_FRAC_DIV_MASK
Date: Thu,  4 Jul 2013 18:08:50 -0300
Message-ID: <1372972130-32451-3-git-send-email-festevam@gmail.com>
References: <1372972130-32451-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f180.google.com (mail-gh0-f180.google.com
 [209.85.160.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 5442B2657EC
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 23:09:42 +0200 (CEST)
Received: by mail-gh0-f180.google.com with SMTP id f18so531029ghb.39
 for <alsa-devel@alsa-project.org>; Thu, 04 Jul 2013 14:09:41 -0700 (PDT)
In-Reply-To: <1372972130-32451-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, oskar@scara.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SGTL5000_PLL_FRAC_DIV_MASK is used to mask bits 0-10 (11 bits in total) of
register CHIP_PLL_CTRL, so fix the mask to accomodate all this bit range.

Reported-by: Oskar Schirmer <oskar@scara.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index 4b69229..2f8c889 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -347,7 +347,7 @@
 #define SGTL5000_PLL_INT_DIV_MASK		0xf800
 #define SGTL5000_PLL_INT_DIV_SHIFT		11
 #define SGTL5000_PLL_INT_DIV_WIDTH		5
-#define SGTL5000_PLL_FRAC_DIV_MASK		0x0700
+#define SGTL5000_PLL_FRAC_DIV_MASK		0x07ff
 #define SGTL5000_PLL_FRAC_DIV_SHIFT		0
 #define SGTL5000_PLL_FRAC_DIV_WIDTH		11
 
-- 
1.8.1.2
