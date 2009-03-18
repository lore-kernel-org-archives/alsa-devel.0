From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.30][topic/asoc][PATCH 2/2] ASoC: OMAP: N810: Add
	more jack functions
Date: Wed, 18 Mar 2009 16:46:54 +0200
Message-ID: <1237387614-27295-2-git-send-email-jarkko.nikula@nokia.com>
References: <1237387614-27295-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 988D21038FA
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 15:49:42 +0100 (CET)
In-Reply-To: <1237387614-27295-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Add functions "Headset" and "Mic" to the control "Jack Function" for
activating and de-activating codec input pin LINE1L which is connected to
the mic pin of 4-pole Nokia AV connecter.

Note there is no mic bias voltage management here since bias is coming from
Nokia ASIC and driver for it is not in mainline.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/n810.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index f203221..a6d1178 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -40,6 +40,13 @@
 #define N810_HEADSET_AMP_GPIO	10
 #define N810_SPEAKER_AMP_GPIO	101
 
+enum {
+	N810_JACK_DISABLED,
+	N810_JACK_HP,
+	N810_JACK_HS,
+	N810_JACK_MIC,
+};
+
 static struct clk *sys_clkout2;
 static struct clk *sys_clkout2_src;
 static struct clk *func96m_clk;
@@ -50,15 +57,32 @@ static int n810_dmic_func;
 
 static void n810_ext_control(struct snd_soc_codec *codec)
 {
+	int hp = 0, line1l = 0;
+
+	switch (n810_jack_func) {
+	case N810_JACK_HS:
+		line1l = 1;
+	case N810_JACK_HP:
+		hp = 1;
+		break;
+	case N810_JACK_MIC:
+		line1l = 1;
+		break;
+	}
+
 	if (n810_spk_func)
 		snd_soc_dapm_enable_pin(codec, "Ext Spk");
 	else
 		snd_soc_dapm_disable_pin(codec, "Ext Spk");
 
-	if (n810_jack_func)
+	if (hp)
 		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
 	else
 		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+	if (line1l)
+		snd_soc_dapm_enable_pin(codec, "LINE1L");
+	else
+		snd_soc_dapm_disable_pin(codec, "LINE1L");
 
 	if (n810_dmic_func)
 		snd_soc_dapm_enable_pin(codec, "DMic");
@@ -229,7 +253,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 };
 
 static const char *spk_function[] = {"Off", "On"};
-static const char *jack_function[] = {"Off", "Headphone"};
+static const char *jack_function[] = {"Off", "Headphone", "Headset", "Mic"};
 static const char *input_function[] = {"ADC", "Digital Mic"};
 static const struct soc_enum n810_enum[] = {
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spk_function), spk_function),
-- 
1.6.2
