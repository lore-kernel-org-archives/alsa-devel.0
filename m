From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Mark WM8958 microphone bias registers as
	readable
Date: Sat, 19 Feb 2011 00:58:17 +0000
Message-ID: <1298077097-27221-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A392B1037F8
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 01:58:19 +0100 (CET)
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994-tables.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994-tables.c b/sound/soc/codecs/wm8994-tables.c
index 42b3248..61dfd91 100644
--- a/sound/soc/codecs/wm8994-tables.c
+++ b/sound/soc/codecs/wm8994-tables.c
@@ -62,8 +62,8 @@ const struct wm8994_access_mask wm8994_access_masks[WM8994_CACHE_SIZE] = {
 	{ 0x00FF, 0x00FF }, /* R58    - MICBIAS */
 	{ 0x000F, 0x000F }, /* R59    - LDO 1 */
 	{ 0x0007, 0x0007 }, /* R60    - LDO 2 */
-	{ 0x0000, 0x0000 }, /* R61 */
-	{ 0x0000, 0x0000 }, /* R62 */
+	{ 0xFFFF, 0xFFFF }, /* R61 */
+	{ 0xFFFF, 0xFFFF }, /* R62 */
 	{ 0x0000, 0x0000 }, /* R63 */
 	{ 0x0000, 0x0000 }, /* R64 */
 	{ 0x0000, 0x0000 }, /* R65 */
-- 
1.7.2.3
