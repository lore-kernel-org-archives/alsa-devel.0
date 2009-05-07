From: Karl Beldan <karl.beldan@gmail.com>
Subject: [PATCH 1/4] pxa2xx-i2s: Proper initialization
Date: Fri, 08 May 2009 01:53:39 +0200
Message-ID: <4A037483.6030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id ABB371038A6
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 01:53:26 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1677294ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 07 May 2009 16:53:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.miao@marvell.com>, Russell King <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org


Reset FIFO logic and registers, and make sure REC and RPL functions and
FIFO service are disabled.

Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
---
 sound/soc/pxa/pxa2xx-i2s.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 2f4b6e4..52862dc 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -370,6 +370,18 @@ static struct platform_driver pxa2xx_i2s_driver = {
 static int __init pxa2xx_i2s_init(void)
 {
 	clk_i2s = ERR_PTR(-ENOENT);
+
+	/*
+	 * PXA Developer's Manual:
+	 * If SACR0[ENB] is toggled in the middle of a normal operation,
+	 * the SACR0[RST] bit must also be set and cleared to reset all
+	 * I2S controller registers.
+	 */
+	SACR0 = SACR0_RST;
+	SACR0 = 0;
+	SACR1 = SACR1_DRPL | SACR1_DREC;
+	SAIMR &= ~(SAIMR_RFS | SAIMR_TFS);
+
 	return platform_driver_register(&pxa2xx_i2s_driver);
 }
 
-- 
1.6.3.rc1.34.g0be9b

-- 
Karl
