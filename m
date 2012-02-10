From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8993: Correct typos in regmap
	conversion
Date: Fri, 10 Feb 2012 18:03:31 +0000
Message-ID: <1328897011-13665-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E7162414D
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 19:03:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index f65339f..acc39ea 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -61,8 +61,8 @@ static struct reg_default wm8993_reg_defaults[] = {
 	{ 18,  0x0000 },     /* R18  - GPIO CTRL 1 */
 	{ 19,  0x0010 },     /* R19  - GPIO1 */
 	{ 20,  0x0000 },     /* R20  - IRQ_DEBOUNCE */
-	{ 21,  0x8000 },     /* R22  - GPIOCTRL 2 */
-	{ 22,  0x0800 },     /* R23  - GPIO_POL */
+	{ 22,  0x8000 },     /* R22  - GPIOCTRL 2 */
+	{ 23,  0x0800 },     /* R23  - GPIO_POL */
 	{ 24,  0x008B },     /* R24  - Left Line Input 1&2 Volume */
 	{ 25,  0x008B },     /* R25  - Left Line Input 3&4 Volume */
 	{ 26,  0x008B },     /* R26  - Right Line Input 1&2 Volume */
-- 
1.7.9.rc1
