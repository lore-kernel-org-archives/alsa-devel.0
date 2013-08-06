From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] mfd: wm5110: Add mic detect level registers
Date: Tue,  6 Aug 2013 16:42:28 +0100
Message-ID: <1375803750-22116-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1375803750-22116-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A7DB260308
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 17:51:55 +0200 (CEST)
In-Reply-To: <1375803750-22116-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

The mic detect level registers are used from common code to configure
the button detection code. Add these registers to the defaults list and
mark them as readable for wm5110.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm5110-tables.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index c04324d..172e9bf 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -507,6 +507,10 @@ static const struct reg_default wm5110_reg_default[] = {
 	{ 0x0000029C, 0x0000 },    /* R668   - Headphone Detect 2 */
 	{ 0x000002A3, 0x1102 },    /* R675   - Mic Detect 1 */
 	{ 0x000002A4, 0x009F },    /* R676   - Mic Detect 2 */
+	{ 0x000002A6, 0x3737 },    /* R678   - Mic Detect Level 1 */
+	{ 0x000002A7, 0x372C },    /* R679   - Mic Detect Level 2 */
+	{ 0x000002A8, 0x1422 },    /* R680   - Mic Detect Level 3 */
+	{ 0x000002A9, 0x300A },    /* R681   - Mic Detect Level 4 */
 	{ 0x000002C3, 0x0000 },    /* R707   - Mic noise mix control 1 */
 	{ 0x000002D3, 0x0000 },    /* R723   - Jack detect analogue */
 	{ 0x00000300, 0x0000 },    /* R768   - Input Enables */
@@ -1438,6 +1442,10 @@ static bool wm5110_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_MIC_DETECT_1:
 	case ARIZONA_MIC_DETECT_2:
 	case ARIZONA_MIC_DETECT_3:
+	case ARIZONA_MIC_DETECT_LEVEL_1:
+	case ARIZONA_MIC_DETECT_LEVEL_2:
+	case ARIZONA_MIC_DETECT_LEVEL_3:
+	case ARIZONA_MIC_DETECT_LEVEL_4:
 	case ARIZONA_MIC_NOISE_MIX_CONTROL_1:
 	case ARIZONA_JACK_DETECT_ANALOGUE:
 	case ARIZONA_INPUT_ENABLES:
-- 
1.7.2.5
