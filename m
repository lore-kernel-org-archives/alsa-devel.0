From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH] ASoC: wm8962: set ALC2 as non-volatile register
Date: Fri, 23 Oct 2015 14:18:48 +0900
Message-ID: <1445577528-2354-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id EA18D260674
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 07:18:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ckeepax@opensource.wolfsonmicro.com
Cc: jiada_wang@mentor.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Previously ALC2 register is set as a volatile register, declare
it as one of ALC Coefficients register together with other non-volatile
registers will cause issue, in case wm8962 has enter suspend mode,
and cache_only flag is set, any attempt to read from ALC2 will fail.

Because the 5 status bits in ALC2 aren't used anywhere nor are useful
to end user, so this patch removes ALC2 register from volatile
register list to make ALC2 be possible to be accessed when cache_only
flag is set.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/codecs/wm8962.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 2fbc6ef..371ec72 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -131,7 +131,7 @@ static const struct reg_default wm8962_reg[] = {
 	{ 15, 0x6243 },   /* R15    - Software Reset */
 
 	{ 17, 0x007B },   /* R17    - ALC1 */
-
+	{ 18, 0x0000 },   /* R18    - ALC2 */
 	{ 19, 0x1C32 },   /* R19    - ALC3 */
 	{ 20, 0x3200 },   /* R20    - Noise Gate */
 	{ 21, 0x00C0 },   /* R21    - Left ADC volume */
@@ -794,7 +794,6 @@ static bool wm8962_volatile_register(struct device *dev, unsigned int reg)
 	case WM8962_CLOCKING1:
 	case WM8962_CLOCKING2:
 	case WM8962_SOFTWARE_RESET:
-	case WM8962_ALC2:
 	case WM8962_THERMAL_SHUTDOWN_STATUS:
 	case WM8962_ADDITIONAL_CONTROL_4:
 	case WM8962_DC_SERVO_6:
-- 
2.4.5
