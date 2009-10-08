From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 6/8] RX-51: Audio: Add usage of regulator
	framework to control VMMC2
Date: Thu,  8 Oct 2009 14:58:55 +0300
Message-ID: <1255003137-1034-7-git-send-email-eduardo.valentin__23589.7503015169$1255003396$gmane$org@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
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
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch adds two supplies for VMMC2 on rx51 boards.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 92f7dfa..9177b1c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -129,8 +129,9 @@ static struct regulator_consumer_supply rx51_vaux3_supply = {
 	.supply			= "vmmc",
 };
 
-static struct regulator_consumer_supply rx51_vmmc2_supply = {
-	.supply			= "vmmc",
+static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
+	REGULATOR_SUPPLY("avdd_dac", "2-0018"), /* tlv320aic3x */
+	REGULATOR_SUPPLY("vdd", "2-0060"), /* tpa6130a2*/
 };
 
 static struct regulator_consumer_supply rx51_vsim_supply = {
@@ -230,8 +231,8 @@ static struct regulator_init_data rx51_vmmc2 = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= 1,
-	.consumer_supplies	= &rx51_vmmc2_supply,
+	.num_consumer_supplies	= ARRAY_SIZE(rx51_vmmc2_supplies),
+	.consumer_supplies	= rx51_vmmc2_supplies,
 };
 
 static struct regulator_init_data rx51_vsim = {
@@ -442,10 +443,9 @@ static int __init rx51_i2c_init(void)
 	if ((system_rev >= SYSTEM_REV_S_USES_VAUX3 && system_rev < 0x100) ||
 	    system_rev >= SYSTEM_REV_B_USES_VAUX3)
 		rx51_twldata.vaux3 = &rx51_vaux3_mmc;
-	else {
+	else
 		rx51_twldata.vaux3 = &rx51_vaux3_cam;
-		rx51_twldata.vmmc2 = &rx51_vmmc2;
-	}
+	rx51_twldata.vmmc2 = &rx51_vmmc2;
 	omap_register_i2c_bus(1, 2600, rx51_peripherals_i2c_board_info_1,
 			ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
 	omap_register_i2c_bus(2, 100, NULL, 0);
-- 
1.6.4.183.g04423

