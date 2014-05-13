From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Update register
	CLASS_D_CONTROL_1 to be non-volatile
Date: Tue, 13 May 2014 13:45:15 +0100
Message-ID: <1399985115-29117-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4DBEA2654C9
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 14:52:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: shawn.guo@linaro.org, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The register CLASS_D_CONTROL_1 is marked as volatile because it contains
a bit, DAC_MUTE, which is also mirrored in the ADC_DAC_CONTROL_1
register. This causes problems for the "Speaker Switch" control, which
will report an error if the CODEC is suspended because it relies on a
volatile register.

To resolve this issue mark CLASS_D_CONTROL_1 as non-volatile and
manually keep the register cache in sync by updating both bits when
changing the mute status.

Reported-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
Hi Shawn,

I am afraid I don't have access to hardware for 8962 at the
moment, so have only build tested this, but I believe it
should fix your issue.

Please let me know how you get on.

Thanks,
Charles

 sound/soc/codecs/wm8962.c |   15 ++++++++++++---
 sound/soc/codecs/wm8962.h |    4 ++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 5522d25..ecd26dd 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -154,6 +154,7 @@ static struct reg_default wm8962_reg[] = {
 	{ 40, 0x0000 },   /* R40    - SPKOUTL volume */
 	{ 41, 0x0000 },   /* R41    - SPKOUTR volume */
 
+	{ 49, 0x0010 },   /* R49    - Class D Control 1 */
 	{ 51, 0x0003 },   /* R51    - Class D Control 2 */
 
 	{ 56, 0x0506 },   /* R56    - Clocking 4 */
@@ -795,7 +796,6 @@ static bool wm8962_volatile_register(struct device *dev, unsigned int reg)
 	case WM8962_ALC2:
 	case WM8962_THERMAL_SHUTDOWN_STATUS:
 	case WM8962_ADDITIONAL_CONTROL_4:
-	case WM8962_CLASS_D_CONTROL_1:
 	case WM8962_DC_SERVO_6:
 	case WM8962_INTERRUPT_STATUS_1:
 	case WM8962_INTERRUPT_STATUS_2:
@@ -2929,13 +2929,22 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 static int wm8962_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	int val;
+	int val, ret;
 
 	if (mute)
-		val = WM8962_DAC_MUTE;
+		val = WM8962_DAC_MUTE | WM8962_DAC_MUTE_ALT;
 	else
 		val = 0;
 
+	/**
+	 * The DAC mute bit is mirrored in two registers, update both to keep
+	 * the register cache consistent.
+	 */
+	ret = snd_soc_update_bits(codec, WM8962_CLASS_D_CONTROL_1,
+				  WM8962_DAC_MUTE_ALT, val);
+	if (ret < 0)
+		return ret;
+
 	return snd_soc_update_bits(codec, WM8962_ADC_DAC_CONTROL_1,
 				   WM8962_DAC_MUTE, val);
 }
diff --git a/sound/soc/codecs/wm8962.h b/sound/soc/codecs/wm8962.h
index a1a5d52..910aafd 100644
--- a/sound/soc/codecs/wm8962.h
+++ b/sound/soc/codecs/wm8962.h
@@ -1954,6 +1954,10 @@
 #define WM8962_SPKOUTL_ENA_MASK                 0x0040  /* SPKOUTL_ENA */
 #define WM8962_SPKOUTL_ENA_SHIFT                     6  /* SPKOUTL_ENA */
 #define WM8962_SPKOUTL_ENA_WIDTH                     1  /* SPKOUTL_ENA */
+#define WM8962_DAC_MUTE_ALT                     0x0010  /* DAC_MUTE */
+#define WM8962_DAC_MUTE_ALT_MASK                0x0010  /* DAC_MUTE */
+#define WM8962_DAC_MUTE_ALT_SHIFT                    4  /* DAC_MUTE */
+#define WM8962_DAC_MUTE_ALT_WIDTH                    1  /* DAC_MUTE */
 #define WM8962_SPKOUTL_PGA_MUTE                 0x0002  /* SPKOUTL_PGA_MUTE */
 #define WM8962_SPKOUTL_PGA_MUTE_MASK            0x0002  /* SPKOUTL_PGA_MUTE */
 #define WM8962_SPKOUTL_PGA_MUTE_SHIFT                1  /* SPKOUTL_PGA_MUTE */
-- 
1.7.2.5
