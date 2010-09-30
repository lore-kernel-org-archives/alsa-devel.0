From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Mark WM8962 Additional Control 4
	register as volatile
Date: Wed, 29 Sep 2010 17:28:40 -0700
Message-ID: <1285806521-23090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D0701037FC
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 02:28:29 +0200 (CEST)
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

There are some status bits for microphone detection in here.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962-tables.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8962-tables.c b/sound/soc/codecs/wm8962-tables.c
index f21a8c1..6fa98ea 100644
--- a/sound/soc/codecs/wm8962-tables.c
+++ b/sound/soc/codecs/wm8962-tables.c
@@ -21204,7 +21204,7 @@ const struct wm8962_reg_access wm8962_reg_access[WM8962_MAX_REGISTER + 1] = {
 	{ 0x0000, 0x0000, 0x0000 }, /* R45 */
 	{ 0x0000, 0x0000, 0x0000 }, /* R46 */
 	{ 0x000F, 0x0000, 0x0000 }, /* R47    - Thermal Shutdown Status */
-	{ 0x7EC7, 0x7E07, 0x0000 }, /* R48    - Additional Control (4) */
+	{ 0x7EC7, 0x7E07, 0xFFFF }, /* R48    - Additional Control (4) */
 	{ 0x00D3, 0x00D7, 0xFFFF }, /* R49    - Class D Control 1 */
 	{ 0x0000, 0x0000, 0x0000 }, /* R50 */
 	{ 0x0047, 0x0047, 0x0000 }, /* R51    - Class D Control 2 */
-- 
1.7.1
