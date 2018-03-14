From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: evea: add switch for changing
	source of line-in
Date: Wed, 14 Mar 2018 21:39:00 +0900
Message-ID: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 508D02670BE
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 13:39:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds mixer switch for changing audio source of line-in.
We can choose one of LIN1, 2, 3, default is LIN1.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/evea.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index 439f14f91b23..73fd6730095c 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -18,6 +18,8 @@
 
 #define AADCPOW(n)                           (0x0078 + 0x04 * (n))
 #define   AADCPOW_AADC_POWD                   BIT(0)
+#define ALINSW1                              0x0088
+#define   ALINSW1_SEL1_SHIFT                  3
 #define AHPOUTPOW                            0x0098
 #define   AHPOUTPOW_HP_ON                     BIT(4)
 #define ALINEPOW                             0x009c
@@ -278,7 +280,16 @@ static int evea_set_switch_hp(struct snd_kcontrol *kcontrol,
 	return evea_update_switch_hp(evea);
 }
 
+static const char * const linsw1_sel1_text[] = {
+	"LIN1", "LIN2", "LIN3"
+};
+
+static SOC_ENUM_SINGLE_DECL(linsw1_sel1_enum,
+	ALINSW1, ALINSW1_SEL1_SHIFT,
+	linsw1_sel1_text);
+
 static const struct snd_kcontrol_new evea_controls[] = {
+	SOC_ENUM("Line Capture Source", linsw1_sel1_enum),
 	SOC_SINGLE_BOOL_EXT("Line Capture Switch", 0,
 			    evea_get_switch_lin, evea_set_switch_lin),
 	SOC_SINGLE_BOOL_EXT("Line Playback Switch", 0,
-- 
2.16.1
