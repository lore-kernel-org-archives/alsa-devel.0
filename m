From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v8 2/7] ASoC: simple-amplifier: add VCC
	regulator widget
Date: Tue, 20 Nov 2018 21:17:47 -0800
Message-ID: <20181121051752.18387-3-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 42DB2267965
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 06:19:14 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id gn14so3721826plb.10
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 21:19:14 -0800 (PST)
In-Reply-To: <20181121051752.18387-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Amplifier may have assosicated regulator, so add a widget for it
and appropriate route.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/codecs/simple-amplifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/simple-amplifier.c b/sound/soc/codecs/simple-amplifier.c
index 85524acf3e9c..c07e8a80b4b7 100644
--- a/sound/soc/codecs/simple-amplifier.c
+++ b/sound/soc/codecs/simple-amplifier.c
@@ -19,6 +19,7 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <sound/soc.h>
 
 #define DRV_NAME "simple-amplifier"
@@ -58,11 +59,14 @@ static const struct snd_soc_dapm_widget simple_amp_dapm_widgets[] = {
 			       (SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)),
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VCC", 20, 0),
 };
 
 static const struct snd_soc_dapm_route simple_amp_dapm_routes[] = {
 	{ "DRV", NULL, "INL" },
 	{ "DRV", NULL, "INR" },
+	{ "OUTL", NULL, "VCC" },
+	{ "OUTR", NULL, "VCC" },
 	{ "OUTL", NULL, "DRV" },
 	{ "OUTR", NULL, "DRV" },
 };
-- 
2.19.1
