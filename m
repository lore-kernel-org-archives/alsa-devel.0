From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] mfd: wm5102: Mark additional registers as
	volatile
Date: Fri,  6 Jun 2014 13:33:19 +0100
Message-ID: <1402058000-5357-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1402058000-5357-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2EE1F2651EE
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 14:40:51 +0200 (CEST)
In-Reply-To: <1402058000-5357-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: lee.jones@linaro.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.org, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Mark some additional registers as volatile. The write sequencer control
registers should not be cached, as we don't ever want their value
synchronised as this might cause a write sequence to be accidentally
initiated.

Additionally, the DAC_COMP registers require special preconditions to
write so there values wouldn't be updated accurately during a register
sync.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm5102-tables.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/wm5102-tables.c b/drivers/mfd/wm5102-tables.c
index 070f8cf..6bef4c9 100644
--- a/drivers/mfd/wm5102-tables.c
+++ b/drivers/mfd/wm5102-tables.c
@@ -245,9 +245,6 @@ const struct regmap_irq_chip wm5102_irq = {
 static const struct reg_default wm5102_reg_default[] = {
 	{ 0x00000008, 0x0019 },   /* R8     - Ctrl IF SPI CFG 1 */ 
 	{ 0x00000009, 0x0001 },   /* R9     - Ctrl IF I2C1 CFG 1 */ 
-	{ 0x00000016, 0x0000 },   /* R22    - Write Sequencer Ctrl 0 */ 
-	{ 0x00000017, 0x0000 },   /* R23    - Write Sequencer Ctrl 1 */ 
-	{ 0x00000018, 0x0000 },   /* R24    - Write Sequencer Ctrl 2 */ 
 	{ 0x00000020, 0x0000 },   /* R32    - Tone Generator 1 */ 
 	{ 0x00000021, 0x1000 },   /* R33    - Tone Generator 2 */ 
 	{ 0x00000022, 0x0000 },   /* R34    - Tone Generator 3 */ 
@@ -1878,6 +1875,9 @@ static bool wm5102_volatile_register(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case ARIZONA_SOFTWARE_RESET:
 	case ARIZONA_DEVICE_REVISION:
+	case ARIZONA_WRITE_SEQUENCER_CTRL_0:
+	case ARIZONA_WRITE_SEQUENCER_CTRL_1:
+	case ARIZONA_WRITE_SEQUENCER_CTRL_2:
 	case ARIZONA_OUTPUT_STATUS_1:
 	case ARIZONA_RAW_OUTPUT_STATUS_1:
 	case ARIZONA_SLIMBUS_RX_PORT_STATUS:
@@ -1889,6 +1889,10 @@ static bool wm5102_volatile_register(struct device *dev, unsigned int reg)
 	case ARIZONA_ASYNC_SAMPLE_RATE_1_STATUS:
 	case ARIZONA_FLL1_NCO_TEST_0:
 	case ARIZONA_FLL2_NCO_TEST_0:
+	case ARIZONA_DAC_COMP_1:
+	case ARIZONA_DAC_COMP_2:
+	case ARIZONA_DAC_COMP_3:
+	case ARIZONA_DAC_COMP_4:
 	case ARIZONA_FX_CTRL2:
 	case ARIZONA_INTERRUPT_STATUS_1:
 	case ARIZONA_INTERRUPT_STATUS_2:
-- 
1.7.2.5
