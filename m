From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/3] ASoC: sglt5000: Fix the default value
	of CHIP_SSS_CTRL
Date: Thu,  4 Jul 2013 20:01:02 -0300
Message-ID: <1372978863-4872-2-git-send-email-festevam@gmail.com>
References: <1372978863-4872-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f181.google.com (mail-gh0-f181.google.com
 [209.85.160.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DF312657ED
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 01:01:51 +0200 (CEST)
Received: by mail-gh0-f181.google.com with SMTP id z12so556959ghb.40
 for <alsa-devel@alsa-project.org>; Thu, 04 Jul 2013 16:01:50 -0700 (PDT)
In-Reply-To: <1372978863-4872-1-git-send-email-festevam@gmail.com>
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

According to the sgtl5000 reference manual, the default value of CHIP_SSS_CTRL
is 0x10.

Reported-by: Oskar Schirmer <oskar@scara.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None
 sound/soc/codecs/sgtl5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 7c99f3c..5e9f80b 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -38,7 +38,7 @@
 static const struct reg_default sgtl5000_reg_defaults[] = {
 	{ SGTL5000_CHIP_CLK_CTRL,		0x0008 },
 	{ SGTL5000_CHIP_I2S_CTRL,		0x0010 },
-	{ SGTL5000_CHIP_SSS_CTRL,		0x0008 },
+	{ SGTL5000_CHIP_SSS_CTRL,		0x0010 },
 	{ SGTL5000_CHIP_DAC_VOL,		0x3c3c },
 	{ SGTL5000_CHIP_PAD_STRENGTH,		0x015f },
 	{ SGTL5000_CHIP_ANA_HP_CTRL,		0x1818 },
-- 
1.8.1.2
