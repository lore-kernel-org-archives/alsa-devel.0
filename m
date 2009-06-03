From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH 4/4] [ARM] pxa/littleton: add support for audio
	(da9034)
Date: Wed, 3 Jun 2009 20:36:11 +0800
Message-ID: <f17812d70906030536j360520ebgfc5832e4ec818e60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id D530B2438A
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 14:36:12 +0200 (CEST)
Received: by qyk1 with SMTP id 1so12241485qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 05:36:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, alsa-devel@alsa-project.org
Cc: Paul Shen <bshen9@marvell.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Paul Shen <bshen9@marvell.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/littleton.c |   20 +++++++++++++++++++-
 include/linux/mfd/da903x.h    |    1 +
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index e13f6a8..b26b3cb 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -81,6 +81,21 @@ static mfp_cfg_t littleton_mfp_cfg[] __initdata = {
 	GPIO27_SSP2_TXD,
 	GPIO17_GPIO,	/* SFRM as chip-select */

+	/* SSP3 */
+	GPIO91_SSP3_SCLK,
+	GPIO92_SSP3_FRM,
+	GPIO93_SSP3_TXD,
+	GPIO94_SSP3_RXD,
+	/* SSP3 NETWORK CLK */
+	GPIO126_EXT_CLK,
+
+	/* SSP4 */
+	GPIO95_SSP4_SCLK,
+	GPIO96_SSP4_FRM,
+	GPIO97_SSP4_TXD,
+	GPIO98_SSP4_RXD,
+
+
 	/* Debug Ethernet */
 	GPIO90_GPIO,

@@ -350,7 +365,10 @@ static struct da903x_subdev_info
littleton_da9034_subdevs[] = {
 	}, {
 		.name		= "da903x-backlight",
 		.id		= DA9034_ID_WLED,
-	},
+	}, {
+		.name		= "da9034-audio",
+		.id		= DA9034_ID_AUDIO,
+	}
 };

 static struct da903x_platform_data littleton_da9034_info = {
diff --git a/include/linux/mfd/da903x.h b/include/linux/mfd/da903x.h
index 115dbe9..ba645ff 100644
--- a/include/linux/mfd/da903x.h
+++ b/include/linux/mfd/da903x.h
@@ -39,6 +39,7 @@ enum {
 	DA9034_ID_VIBRA,
 	DA9034_ID_WLED,
 	DA9034_ID_TOUCH,
+	DA9034_ID_AUDIO,

 	DA9034_ID_BUCK1,
 	DA9034_ID_BUCK2,
-- 
1.6.0.4
