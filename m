From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add missing default for WM5100 Clocking 1
Date: Tue, 11 Oct 2011 16:06:36 +0100
Message-ID: <1318345596-4059-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C45091038FB
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 17:06:39 +0200 (CEST)
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
 sound/soc/codecs/wm5100-tables.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5100-tables.c b/sound/soc/codecs/wm5100-tables.c
index 960617b..e9ce81a 100644
--- a/sound/soc/codecs/wm5100-tables.c
+++ b/sound/soc/codecs/wm5100-tables.c
@@ -794,6 +794,7 @@ u16 wm5100_reg_defaults[WM5100_MAX_REGISTER + 1] = {
 	[0x0030] = 0x0000,     /* R48    - PWM Drive 1 */
 	[0x0031] = 0x0100,     /* R49    - PWM Drive 2 */
 	[0x0032] = 0x0100,     /* R50    - PWM Drive 3 */
+	[0x0100] = 0x0002,     /* R256   - Clocking 1 */
 	[0x0101] = 0x0000,     /* R257   - Clocking 3 */
 	[0x0102] = 0x0011,     /* R258   - Clocking 4 */
 	[0x0103] = 0x0011,     /* R259   - Clocking 5 */
-- 
1.7.6.3
