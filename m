From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] mfd: wm5102: Map in additional FLL control
	registers
Date: Wed,  6 Mar 2013 14:28:14 +0800
Message-ID: <1362551296-14920-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1362551296-14920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 488D1265327
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 07:29:23 +0100 (CET)
In-Reply-To: <1362551296-14920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm5102-tables.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mfd/wm5102-tables.c b/drivers/mfd/wm5102-tables.c
index f3c2e9a..768fd42 100644
--- a/drivers/mfd/wm5102-tables.c
+++ b/drivers/mfd/wm5102-tables.c
@@ -291,12 +291,14 @@ static const struct reg_default wm5102_reg_default[] = {
 	{ 0x00000176, 0x0000 },   /* R374   - FLL1 Control 6 */ 
 	{ 0x00000177, 0x0181 },   /* R375   - FLL1 Loop Filter Test 1 */ 
 	{ 0x00000178, 0x0000 },   /* R376   - FLL1 NCO Test 0 */
+	{ 0x00000179, 0x0000 },   /* R377   - FLL1 Control 7 */
 	{ 0x00000181, 0x0000 },   /* R385   - FLL1 Synchroniser 1 */ 
 	{ 0x00000182, 0x0000 },   /* R386   - FLL1 Synchroniser 2 */ 
 	{ 0x00000183, 0x0000 },   /* R387   - FLL1 Synchroniser 3 */ 
 	{ 0x00000184, 0x0000 },   /* R388   - FLL1 Synchroniser 4 */ 
 	{ 0x00000185, 0x0000 },   /* R389   - FLL1 Synchroniser 5 */ 
 	{ 0x00000186, 0x0000 },   /* R390   - FLL1 Synchroniser 6 */ 
+	{ 0x00000187, 0x0001 },   /* R391   - FLL1 Synchroniser 7 */
 	{ 0x00000189, 0x0000 },   /* R393   - FLL1 Spread Spectrum */ 
 	{ 0x0000018A, 0x0004 },   /* R394   - FLL1 GPIO Clock */ 
 	{ 0x00000191, 0x0000 },   /* R401   - FLL2 Control 1 */ 
@@ -307,12 +309,14 @@ static const struct reg_default wm5102_reg_default[] = {
 	{ 0x00000196, 0x0000 },   /* R406   - FLL2 Control 6 */ 
 	{ 0x00000197, 0x0000 },   /* R407   - FLL2 Loop Filter Test 1 */ 
 	{ 0x00000198, 0x0000 },   /* R408   - FLL2 NCO Test 0 */
+	{ 0x00000199, 0x0000 },   /* R409   - FLL2 Control 7 */
 	{ 0x000001A1, 0x0000 },   /* R417   - FLL2 Synchroniser 1 */ 
 	{ 0x000001A2, 0x0000 },   /* R418   - FLL2 Synchroniser 2 */ 
 	{ 0x000001A3, 0x0000 },   /* R419   - FLL2 Synchroniser 3 */ 
 	{ 0x000001A4, 0x0000 },   /* R420   - FLL2 Synchroniser 4 */ 
 	{ 0x000001A5, 0x0000 },   /* R421   - FLL2 Synchroniser 5 */ 
 	{ 0x000001A6, 0x0000 },   /* R422   - FLL2 Synchroniser 6 */ 
+	{ 0x000001A7, 0x0001 },   /* R423   - FLL2 Synchroniser 7 */
 	{ 0x000001A9, 0x0000 },   /* R425   - FLL2 Spread Spectrum */ 
 	{ 0x000001AA, 0x0004 },   /* R426   - FLL2 GPIO Clock */ 
 	{ 0x00000200, 0x0006 },   /* R512   - Mic Charge Pump 1 */ 
@@ -1056,12 +1060,14 @@ static bool wm5102_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_FLL1_CONTROL_6:
 	case ARIZONA_FLL1_LOOP_FILTER_TEST_1:
 	case ARIZONA_FLL1_NCO_TEST_0:
+	case ARIZONA_FLL1_CONTROL_7:
 	case ARIZONA_FLL1_SYNCHRONISER_1:
 	case ARIZONA_FLL1_SYNCHRONISER_2:
 	case ARIZONA_FLL1_SYNCHRONISER_3:
 	case ARIZONA_FLL1_SYNCHRONISER_4:
 	case ARIZONA_FLL1_SYNCHRONISER_5:
 	case ARIZONA_FLL1_SYNCHRONISER_6:
+	case ARIZONA_FLL1_SYNCHRONISER_7:
 	case ARIZONA_FLL1_SPREAD_SPECTRUM:
 	case ARIZONA_FLL1_GPIO_CLOCK:
 	case ARIZONA_FLL2_CONTROL_1:
@@ -1072,12 +1078,14 @@ static bool wm5102_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_FLL2_CONTROL_6:
 	case ARIZONA_FLL2_LOOP_FILTER_TEST_1:
 	case ARIZONA_FLL2_NCO_TEST_0:
+	case ARIZONA_FLL2_CONTROL_7:
 	case ARIZONA_FLL2_SYNCHRONISER_1:
 	case ARIZONA_FLL2_SYNCHRONISER_2:
 	case ARIZONA_FLL2_SYNCHRONISER_3:
 	case ARIZONA_FLL2_SYNCHRONISER_4:
 	case ARIZONA_FLL2_SYNCHRONISER_5:
 	case ARIZONA_FLL2_SYNCHRONISER_6:
+	case ARIZONA_FLL2_SYNCHRONISER_7:
 	case ARIZONA_FLL2_SPREAD_SPECTRUM:
 	case ARIZONA_FLL2_GPIO_CLOCK:
 	case ARIZONA_MIC_CHARGE_PUMP_1:
-- 
1.7.10.4
