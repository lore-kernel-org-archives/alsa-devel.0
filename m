From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v7 1/4] ASoC: sun8i-codec: add missing route
	for ADC
Date: Thu,  8 Nov 2018 20:24:19 -0800
Message-ID: <20181109042422.25653-2-anarsoul@gmail.com>
References: <20181109042422.25653-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 302FA267B05
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2018 05:24:34 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id v9-v6so346339pff.2
 for <alsa-devel@alsa-project.org>; Thu, 08 Nov 2018 20:24:34 -0800 (PST)
In-Reply-To: <20181109042422.25653-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sun8i-codec misses a route from ADC to AIF1 Slot 0 ADC. Add it
to the driver to avoid adding it to every dts.

Fixes: eda85d1fee05d ("ASoC: sun8i-codec: Add ADC support for a33")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/sunxi/sun8i-codec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index c4196d4e5915..92c5de026c43 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -481,7 +481,11 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
 	  "AIF1 Slot 0 Right"},
 
-	/* ADC routes */
+	/* ADC Routes */
+	{ "AIF1 Slot 0 Right ADC", NULL, "ADC" },
+	{ "AIF1 Slot 0 Left ADC", NULL, "ADC" },
+
+	/* ADC Mixer Routes */
 	{ "Left Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch",
 	  "AIF1 Slot 0 Left ADC" },
 	{ "Right Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch",
-- 
2.19.1
