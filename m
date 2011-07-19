From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v4 08/10] ARM: mxs: add mxs-sgtl5000 device
Date: Tue, 19 Jul 2011 12:36:20 +0800
Message-ID: <1311050180-22355-1-git-send-email-b29396@freescale.com>
References: <1310731780-1645-9-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 98CA62448B
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 06:13:08 +0200 (CEST)
In-Reply-To: <1310731780-1645-9-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
Just resend for rebase [PATCH v4 06/10] ARM: mxs: add saif device
---
 arch/arm/mach-mxs/mach-mx28evk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index fe5ea41..521c4d5 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -424,6 +424,9 @@ static void __init mx28evk_init(void)
 	i2c_register_board_info(0, mxs_i2c0_board_info,
 				ARRAY_SIZE(mxs_i2c0_board_info));
 
+	mxs_add_platform_device("mxs-sgtl5000", 0, NULL, 0,
+			NULL, 0);
+
 	/* power on mmc slot by writing 0 to the gpio */
 	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW,
 			       "mmc0-slot-power");
-- 
1.7.0.4
