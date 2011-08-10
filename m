From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Specify register defaults for WM8958
	MICBIAS1 and MICBIAS2
Date: Wed, 10 Aug 2011 14:20:09 +0900
Message-ID: <1312953609-26975-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5BFC7244D8
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 07:21:01 +0200 (CEST)
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
 sound/soc/codecs/wm8994-tables.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994-tables.c b/sound/soc/codecs/wm8994-tables.c
index a87adbd..13e5a01 100644
--- a/sound/soc/codecs/wm8994-tables.c
+++ b/sound/soc/codecs/wm8994-tables.c
@@ -1635,8 +1635,8 @@ const u16 wm8994_reg_defaults[WM8994_CACHE_SIZE] = {
 	0x0000,     /* R58    - MICBIAS */
 	0x000D,     /* R59    - LDO 1 */
 	0x0003,     /* R60    - LDO 2 */
-	0x0000,     /* R61 */
-	0x0000,     /* R62 */
+	0x0039,     /* R61    - MICBIAS1 */
+	0x0039,     /* R62    - MICBIAS2 */
 	0x0000,     /* R63 */
 	0x0000,     /* R64 */
 	0x0000,     /* R65 */
-- 
1.7.5.4
