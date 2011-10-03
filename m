From: Ryan Mallon <rmallon@gmail.com>
Subject: [PATCH 1/2] ASoC: max98088 codec: Catch driver bugs for eq channel name
Date: Tue,  4 Oct 2011 09:55:40 +1100
Message-ID: <1317682541-28494-1-git-send-email-rmallon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: axel.lin@gmail.com, linux-kernel@vger.kernel.org, lrg@ti.com, alsa-devel@alsa-project.org, peter.hsiang@maxim-ic.com, jesse.marroquin@maxim-ic.com, hidave.darkstar@gmail.com, Ryan Mallon <rmallon@gmail.com>
List-Id: alsa-devel@alsa-project.org

Move the EQ channel names to a separate array and iterate over it in
max98088_get_channel rather than duplicating the hardcoded channel
names. Add an error message if an invalid channel is passed and check
the error in the callers.

Also added a BUILD_BUG_ON to ensure that the eq_mode_name and controls
arrays are the same size.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 sound/soc/codecs/max98088.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index ac65a2d..8f55e34 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1697,13 +1697,19 @@ static struct snd_soc_dai_driver max98088_dai[] = {
 }
 };
 
-static int max98088_get_channel(const char *name)
+static const char *eq_mode_name[] = {"EQ1 Mode", "EQ2 Mode"};
+
+static int max98088_get_channel(struct snd_soc_codec *codec, const char *name)
 {
-       if (strcmp(name, "EQ1 Mode") == 0)
-               return 0;
-       if (strcmp(name, "EQ2 Mode") == 0)
-               return 1;
-       return -EINVAL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(eq_mode_name); i++)
+		if (strcmp(name, eq_mode_name[i]) == 0)
+			return i;
+
+	/* Shouldn't happen */
+	dev_err(codec->dev, "Bad EQ channel name '%s'\n", name);
+	return -EINVAL;
 }
 
 static void max98088_setup_eq1(struct snd_soc_codec *codec)
@@ -1807,10 +1813,13 @@ static int max98088_put_eq_enum(struct snd_kcontrol *kcontrol,
        struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
        struct max98088_pdata *pdata = max98088->pdata;
-       int channel = max98088_get_channel(kcontrol->id.name);
+       int channel = max98088_get_channel(codec, kcontrol->id.name);
        struct max98088_cdata *cdata;
        int sel = ucontrol->value.integer.value[0];
 
+       if (channel < 0)
+	       return channel;
+
        cdata = &max98088->dai[channel];
 
        if (sel >= pdata->eq_cfgcnt)
@@ -1835,9 +1844,12 @@ static int max98088_get_eq_enum(struct snd_kcontrol *kcontrol,
 {
        struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
-       int channel = max98088_get_channel(kcontrol->id.name);
+       int channel = max98088_get_channel(codec, kcontrol->id.name);
        struct max98088_cdata *cdata;
 
+       if (channel < 0)
+	       return channel;
+
        cdata = &max98088->dai[channel];
        ucontrol->value.enumerated.item[0] = cdata->eq_sel;
        return 0;
@@ -1852,17 +1864,17 @@ static void max98088_handle_eq_pdata(struct snd_soc_codec *codec)
        int i, j;
        const char **t;
        int ret;
-
        struct snd_kcontrol_new controls[] = {
-               SOC_ENUM_EXT("EQ1 Mode",
+               SOC_ENUM_EXT((char *)eq_mode_name[0],
                        max98088->eq_enum,
                        max98088_get_eq_enum,
                        max98088_put_eq_enum),
-               SOC_ENUM_EXT("EQ2 Mode",
+               SOC_ENUM_EXT((char *)eq_mode_name[1],
                        max98088->eq_enum,
                        max98088_get_eq_enum,
                        max98088_put_eq_enum),
        };
+       BUILD_BUG_ON(ARRAY_SIZE(controls) != ARRAY_SIZE(eq_mode_name));
 
        cfg = pdata->eq_cfg;
        cfgcnt = pdata->eq_cfgcnt;
-- 
1.7.0.4
