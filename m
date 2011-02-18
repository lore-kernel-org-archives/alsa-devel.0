From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Mark WM8958 microphone detection
	registers readable
Date: Fri, 18 Feb 2011 14:51:53 -0800
Message-ID: <1298069513-11003-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 050B92449B
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 23:56:12 +0100 (CET)
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

So they show up in codec_reg.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994-tables.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8994-tables.c b/sound/soc/codecs/wm8994-tables.c
index 68e9b02..42b3248 100644
--- a/sound/soc/codecs/wm8994-tables.c
+++ b/sound/soc/codecs/wm8994-tables.c
@@ -209,9 +209,9 @@ const struct wm8994_access_mask wm8994_access_masks[WM8994_CACHE_SIZE] = {
 	{ 0x0000, 0x0000 }, /* R205 */
 	{ 0x0000, 0x0000 }, /* R206 */
 	{ 0x0000, 0x0000 }, /* R207 */
-	{ 0x0000, 0x0000 }, /* R208 */
-	{ 0x0000, 0x0000 }, /* R209 */
-	{ 0x0000, 0x0000 }, /* R210 */
+	{ 0xFFFF, 0xFFFF }, /* R208 */
+	{ 0xFFFF, 0xFFFF }, /* R209 */
+	{ 0xFFFF, 0xFFFF }, /* R210 */
 	{ 0x0000, 0x0000 }, /* R211 */
 	{ 0x0000, 0x0000 }, /* R212 */
 	{ 0x0000, 0x0000 }, /* R213 */
-- 
1.7.2.3
