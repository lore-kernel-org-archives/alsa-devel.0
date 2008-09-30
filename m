From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 3/5 v1] Adds I2C board info for tlvaic23
Date: Tue, 30 Sep 2008 15:33:32 +0530
Message-ID: <dfeb90390809300303x6db4c860l1d5d3a4d0c032953@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id CFD632444B
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 12:03:35 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so2440366rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2008 03:03:34 -0700 (PDT)
Content-Disposition: inline
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
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Adding I2C board info required for tlvaic23 i2c chip driver

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap1/board-osk.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 3e766e4..e506aef 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -258,8 +258,10 @@ static struct i2c_board_info __initdata
osk_i2c_board_info[] = {
 		.platform_data	= &tps_board,

 	},
+	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1B),
+	},
 	/* TODO when driver support is ready:
-	 *  - aic23 audio chip at 0x1a
 	 *  - on Mistral, 24c04 eeprom at 0x50
 	 *  - optionally on Mistral, ov9640 camera sensor at 0x30
 	 */
-- 
1.5.3.4
