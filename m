From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] mfd: wm5110: Add missing Mic Detect 3
	register into defaults
Date: Tue,  6 Aug 2013 16:42:29 +0100
Message-ID: <1375803750-22116-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1375803750-22116-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C893260315
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 17:51:56 +0200 (CEST)
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

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/wm5110-tables.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 172e9bf..4903265 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -507,6 +507,7 @@ static const struct reg_default wm5110_reg_default[] = {
 	{ 0x0000029C, 0x0000 },    /* R668   - Headphone Detect 2 */
 	{ 0x000002A3, 0x1102 },    /* R675   - Mic Detect 1 */
 	{ 0x000002A4, 0x009F },    /* R676   - Mic Detect 2 */
+	{ 0x000002A5, 0x0000 },    /* R677   - Mic Detect 3 */
 	{ 0x000002A6, 0x3737 },    /* R678   - Mic Detect Level 1 */
 	{ 0x000002A7, 0x372C },    /* R679   - Mic Detect Level 2 */
 	{ 0x000002A8, 0x1422 },    /* R680   - Mic Detect Level 3 */
-- 
1.7.2.5
