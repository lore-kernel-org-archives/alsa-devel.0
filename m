From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] mfd: wm5110: Mark register containing FLL
	gains as readable
Date: Tue,  6 Aug 2013 16:42:27 +0100
Message-ID: <1375803750-22116-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 561A226087E
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 17:59:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The FLL gains are present on all devices and controlled from common code
shared between them. This patch adds these registers into defaults list
for wm5110 and marks them as readable.

Reported-by: D.J. Barrow <dbarrow@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm5110-tables.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 2a79723..c04324d 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -468,12 +468,14 @@ static const struct reg_default wm5110_reg_default[] = {
 	{ 0x00000176, 0x0000 },    /* R374   - FLL1 Control 6 */
 	{ 0x00000177, 0x0281 },    /* R375   - FLL1 Loop Filter Test 1 */
 	{ 0x00000178, 0x0000 },    /* R376   - FLL1 NCO Test 0 */
+	{ 0x00000179, 0x0000 },    /* R376   - FLL1 Control 7 */
 	{ 0x00000181, 0x0000 },    /* R385   - FLL1 Synchroniser 1 */
 	{ 0x00000182, 0x0000 },    /* R386   - FLL1 Synchroniser 2 */
 	{ 0x00000183, 0x0000 },    /* R387   - FLL1 Synchroniser 3 */
 	{ 0x00000184, 0x0000 },    /* R388   - FLL1 Synchroniser 4 */
 	{ 0x00000185, 0x0000 },    /* R389   - FLL1 Synchroniser 5 */
 	{ 0x00000186, 0x0000 },    /* R390   - FLL1 Synchroniser 6 */
+	{ 0x00000187, 0x0001 },    /* R390   - FLL1 Synchroniser 7 */
 	{ 0x00000189, 0x0000 },    /* R393   - FLL1 Spread Spectrum */
 	{ 0x0000018A, 0x0004 },    /* R394   - FLL1 GPIO Clock */
 	{ 0x00000191, 0x0000 },    /* R401   - FLL2 Control 1 */
@@ -484,12 +486,14 @@ static const struct reg_default wm5110_reg_default[] = {
 	{ 0x00000196, 0x0000 },    /* R406   - FLL2 Control 6 */
 	{ 0x00000197, 0x0000 },    /* R407   - FLL2 Loop Filter Test 1 */
 	{ 0x00000198, 0x0000 },    /* R408   - FLL2 NCO Test 0 */
+	{ 0x00000199, 0x0000 },    /* R408   - FLL2 Control 7 */
 	{ 0x000001A1, 0x0000 },    /* R417   - FLL2 Synchroniser 1 */
 	{ 0x000001A2, 0x0000 },    /* R418   - FLL2 Synchroniser 2 */
 	{ 0x000001A3, 0x0000 },    /* R419   - FLL2 Synchroniser 3 */
 	{ 0x000001A4, 0x0000 },    /* R420   - FLL2 Synchroniser 4 */
 	{ 0x000001A5, 0x0000 },    /* R421   - FLL2 Synchroniser 5 */
 	{ 0x000001A6, 0x0000 },    /* R422   - FLL2 Synchroniser 6 */
+	{ 0x000001A7, 0x0001 },    /* R422   - FLL2 Synchroniser 7 */
 	{ 0x000001A9, 0x0000 },    /* R425   - FLL2 Spread Spectrum */
 	{ 0x000001AA, 0x0004 },    /* R426   - FLL2 GPIO Clock */
 	{ 0x00000200, 0x0006 },    /* R512   - Mic Charge Pump 1 */
@@ -1392,6 +1396,7 @@ static bool wm5110_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_FLL1_CONTROL_4:
 	case ARIZONA_FLL1_CONTROL_5:
 	case ARIZONA_FLL1_CONTROL_6:
+	case ARIZONA_FLL1_CONTROL_7:
 	case ARIZONA_FLL1_LOOP_FILTER_TEST_1:
 	case ARIZONA_FLL1_NCO_TEST_0:
 	case ARIZONA_FLL1_SYNCHRONISER_1:
@@ -1400,6 +1405,7 @@ static bool wm5110_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_FLL1_SYNCHRONISER_4:
 	case ARIZONA_FLL1_SYNCHRONISER_5:
 	case ARIZONA_FLL1_SYNCHRONISER_6:
+	case ARIZONA_FLL1_SYNCHRONISER_7:
 	case ARIZONA_FLL1_SPREAD_SPECTRUM:
 	case ARIZONA_FLL1_GPIO_CLOCK:
 	case ARIZONA_FLL2_CONTROL_1:
@@ -1408,6 +1414,7 @@ static bool wm5110_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_FLL2_CONTROL_4:
 	case ARIZONA_FLL2_CONTROL_5:
 	case ARIZONA_FLL2_CONTROL_6:
+	case ARIZONA_FLL2_CONTROL_7:
 	case ARIZONA_FLL2_LOOP_FILTER_TEST_1:
 	case ARIZONA_FLL2_NCO_TEST_0:
 	case ARIZONA_FLL2_SYNCHRONISER_1:
@@ -1416,6 +1423,7 @@ static bool wm5110_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_FLL2_SYNCHRONISER_4:
 	case ARIZONA_FLL2_SYNCHRONISER_5:
 	case ARIZONA_FLL2_SYNCHRONISER_6:
+	case ARIZONA_FLL2_SYNCHRONISER_7:
 	case ARIZONA_FLL2_SPREAD_SPECTRUM:
 	case ARIZONA_FLL2_GPIO_CLOCK:
 	case ARIZONA_MIC_CHARGE_PUMP_1:
-- 
1.7.2.5
