From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 7/7] ASoC: Intel: bytcr_rt5651: Actually honor
	the DMIC_EN quirk if specified
Date: Thu, 22 Feb 2018 18:07:38 +0100
Message-ID: <20180222170738.8508-8-hdegoede@redhat.com>
References: <20180222170738.8508-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 9954D2677BA
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 18:07:50 +0100 (CET)
In-Reply-To: <20180222170738.8508-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Before this commit it was possible to set the DMIC_EN quirk in the machine
driver, but it would never be passed to the codec driver so it was a nop.

This commit adds code to actually pass the quirk to the codec driver.

Since the DMIC_EN quirk was ignored before, this commit removes it from
the default quirk settings, to avoid this causing an unexpected functional
change. If we really want the DMIC_EN behavior anywhere it should be
specifically enabled by follow up commits.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index ccefe356d528..8f7a2e823f7f 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -56,8 +56,8 @@ enum {
 #define BYT_RT5651_MCLK_EN		BIT(17)
 #define BYT_RT5651_MCLK_25MHZ		BIT(18)
 
-/* jack-detect-source + terminating empty entry */
-#define MAX_NO_PROPS 2
+/* jack-detect-source + dmic-en + terminating empty entry */
+#define MAX_NO_PROPS 3
 
 struct byt_rt5651_private {
 	struct clk *mclk;
@@ -65,7 +65,6 @@ struct byt_rt5651_private {
 };
 
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DMIC_MAP |
-					BYT_RT5651_DMIC_EN |
 					BYT_RT5651_MCLK_EN;
 
 static void log_quirks(struct device *dev)
@@ -380,10 +379,15 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 	props[no_props++] = PROPERTY_ENTRY_U32("realtek,jack-detect-source",
 					  BYT_RT5651_JDSRC(byt_rt5651_quirk));
 
+	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
+		props[no_props++] = PROPERTY_ENTRY_BOOL("realtek,dmic-en");
+
 	ret = device_add_properties(codec->dev, props);
 	if (ret)
 		return ret;
 
+	rt5651_apply_properties(codec);
+
 	ret = snd_soc_card_jack_new(runtime->card, "Headset",
 				    SND_JACK_HEADSET, &priv->jack,
 				    bytcr_jack_pins, ARRAY_SIZE(bytcr_jack_pins));
-- 
2.14.3
