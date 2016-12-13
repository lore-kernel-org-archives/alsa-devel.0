From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH] ASoC: nau8825: Add Class G function options
Date: Mon, 12 Dec 2016 22:12:06 -0800
Message-ID: <1481609526-21933-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 16B3A266D53
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 07:14:05 +0100 (CET)
Received: by mail-pf0-f182.google.com with SMTP id c4so16913625pfb.1
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2016 22:14:05 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Ben Zhang <benzh@chromium.org>, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, YHCHuang@nuvoton.com, Anatol Pomozov <anatol@google.com>, CTLIN0@nuvoton.com, Dylan Reid <dgreid@chromium.org>, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Add a DAPM_MUX for userspace to control the Class G function:
"Switching": Use +-1.8V or +-0.9V supply, based on signal amplitude.
"1.8V": Always use +-1.8V.

The default is "Switching" which is the existing behavior
without this patch, so no effect on current users. On some
devices, the switching may cause a clicking noise at low
volume. "1.8V" eliminates the noise at the expense of a few
additional mW.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/nau8825.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index efe3a44..ddd15a0 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1062,6 +1062,10 @@ static const char * const nau8825_dac_src[] = {
 	"DACL", "DACR",
 };
 
+static const char * const nau8825_class_g_src[] = {
+	"Switching", "1.8V"
+};
+
 static SOC_ENUM_SINGLE_DECL(
 	nau8825_dacl_enum, NAU8825_REG_DACL_CTRL,
 	NAU8825_DACL_CH_SEL_SFT, nau8825_dac_src);
@@ -1070,12 +1074,17 @@ static SOC_ENUM_SINGLE_DECL(
 	nau8825_dacr_enum, NAU8825_REG_DACR_CTRL,
 	NAU8825_DACR_CH_SEL_SFT, nau8825_dac_src);
 
+static SOC_ENUM_SINGLE_DECL(
+	nau8825_class_g_enum, SND_SOC_NOPM, 0, nau8825_class_g_src);
+
 static const struct snd_kcontrol_new nau8825_dacl_mux =
 	SOC_DAPM_ENUM("DACL Source", nau8825_dacl_enum);
 
 static const struct snd_kcontrol_new nau8825_dacr_mux =
 	SOC_DAPM_ENUM("DACR Source", nau8825_dacr_enum);
 
+static const struct snd_kcontrol_new nau8825_class_g_mux =
+	SOC_DAPM_ENUM("Class G Source", nau8825_class_g_enum);
 
 static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("AIFTX", "Capture", 0, NAU8825_REG_I2S_PCM_CTRL2,
@@ -1154,9 +1163,16 @@ static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA_S("HP Boost Driver", 9,
 		NAU8825_REG_BOOST, 9, 1, NULL, 0),
 
-	/* Class G operation control*/
-	SND_SOC_DAPM_PGA_S("Class G", 10,
+	/* Class G operation control. "Class G" MUX options:
+	 * "Switching": Use +-1.8V or +-0.9V supply, based on signal amplitude.
+	 * "1.8V": Always use +-1.8V.
+	 * The PGA_S widget is used to ensure the Class G control bit is set at
+	 * the correct time w.r.t the other widgets.
+	 */
+	SND_SOC_DAPM_PGA_S("Class G Driver", 10,
 		NAU8825_REG_CLASSG_CTRL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MUX("Class G", SND_SOC_NOPM, 0, 0,
+		&nau8825_class_g_mux),
 
 	SND_SOC_DAPM_OUTPUT("HPOL"),
 	SND_SOC_DAPM_OUTPUT("HPOR"),
@@ -1197,7 +1213,9 @@ static const struct snd_soc_dapm_route nau8825_dapm_routes[] = {
 	{"HPOR Pulldown", NULL, "Output DACR"},
 	{"HP Boost Driver", NULL, "HPOL Pulldown"},
 	{"HP Boost Driver", NULL, "HPOR Pulldown"},
-	{"Class G", NULL, "HP Boost Driver"},
+	{"Class G Driver", NULL, "HP Boost Driver"},
+	{"Class G", "1.8V", "HP Boost Driver"},
+	{"Class G", "Switching", "Class G Driver"},
 	{"HPOL", NULL, "Class G"},
 	{"HPOR", NULL, "Class G"},
 };
-- 
2.8.0.rc3.226.g39d4020
