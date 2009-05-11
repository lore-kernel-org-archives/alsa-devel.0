From: Karl Beldan <karl.beldan@gmail.com>
Subject: [RESEND][PATCH 1/4] pxa2xx-i2s: Proper initialization
Date: Mon, 11 May 2009 23:49:41 +0200
Message-ID: <4A089D75.3070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id B443224477
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 23:49:51 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so954368fgg.21
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 14:49:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Eric Miao <eric.miao@marvell.com>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Reset FIFO logic and registers, and make sure REC and RPL functions along
with FIFO service are disabled at probe.

Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
---
 sound/soc/pxa/pxa2xx-i2s.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 2f4b6e4..450fca6 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -346,6 +346,19 @@ static int pxa2xx_i2s_probe(struct platform_device *dev)
 	if (ret != 0)
 		clk_put(clk_i2s);
 
+	/*
+	 * PXA Developer's Manual:
+	 * If SACR0[ENB] is toggled in the middle of a normal operation,
+	 * the SACR0[RST] bit must also be set and cleared to reset all
+	 * I2S controller registers.
+	 */
+	SACR0 = SACR0_RST;
+	SACR0 = 0;
+	/* Make sure RPL and REC are disabled */
+	SACR1 = SACR1_DRPL | SACR1_DREC;
+	/* Along with FIFO servicing */
+	SAIMR &= ~(SAIMR_RFS | SAIMR_TFS);
+
 	return ret;
 }
 
-- 
1.6.3.rc1.34.g0be9b

-- 
Karl Beldan
