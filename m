From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/6] ASoC: Intel: bytcr_rt5651: Add mono
	speaker quirk
Date: Wed, 18 Jul 2018 22:55:41 +0200
Message-ID: <20180718205542.12364-6-hdegoede@redhat.com>
References: <20180718205542.12364-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 5716F2677A0
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 22:55:53 +0200 (CEST)
In-Reply-To: <20180718205542.12364-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

During my initial round of bytcr_rt5651 long-name patches I did not include
a difference for mono vs stereo speaker setups in the longname because it
seems that all 5651 devices with only a single speaker do some mixing of
left + right on the PCB.

However further testing has shown that while this works great when only
playing audio on the left or right channel, the output becomes garbled
when using both channels at once. Something which does not happen when
using the Stereo DAC MIXL / MIXR switches to mix the channels together
inside the codec and then only outputting on a single channel.

So we need to have separate UCM profiles and thus separate long-names
for devices with a mono speaker vs stereo speakers. Just as we already
have for the bytcr_rt5640 case.

This commit adds a new BYT_RT5651_MONO_SPEAKER quirk and adds "stereo-spk"
or "mono-spk" to the long-name based on this and enables this mapping on
devices with a mono speaker.

Changing the long-name like this is ok for now, since I'm still working
on the UCM profiles, so they are not in upstream alsa-lib yet.

This brings the long-name naming scheme fully in sync with the bytcr_rt5640
case, which is good from a consistency pov.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index d85530b1cc8e..8374e633796d 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -79,6 +79,7 @@ enum {
 #define BYT_RT5651_SSP0_AIF1		BIT(20)
 #define BYT_RT5651_SSP0_AIF2		BIT(21)
 #define BYT_RT5651_HP_LR_SWAPPED	BIT(22)
+#define BYT_RT5651_MONO_SPEAKER		BIT(23)
 
 #define BYT_RT5651_DEFAULT_QUIRKS	(BYT_RT5651_MCLK_EN | \
 					 BYT_RT5651_JD1_1   | \
@@ -128,6 +129,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk SSP0_AIF1 enabled\n");
 	if (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)
 		dev_info(dev, "quirk SSP0_AIF2 enabled\n");
+	if (byt_rt5651_quirk & BYT_RT5651_MONO_SPEAKER)
+		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
 }
 
 #define BYT_CODEC_DAI1	"rt5651-aif1"
@@ -374,7 +377,8 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 		},
 		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN2_MAP |
-					BYT_RT5651_HP_LR_SWAPPED),
+					BYT_RT5651_HP_LR_SWAPPED |
+					BYT_RT5651_MONO_SPEAKER),
 	},
 	{
 		/* Chuwi Vi8 Plus (CWI519) */
@@ -385,7 +389,8 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 		},
 		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN2_MAP |
-					BYT_RT5651_HP_LR_SWAPPED),
+					BYT_RT5651_HP_LR_SWAPPED |
+					BYT_RT5651_MONO_SPEAKER),
 	},
 	{
 		/* KIANO SlimNote 14.2 */
@@ -700,7 +705,7 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
 static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
 static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
 static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
-static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-mic[-swapped-hp]" */
+static char byt_rt5651_long_name[50]; /* = "bytcr-rt5651-*-spk-*-mic[-swapped-hp]" */
 
 static int byt_rt5651_suspend(struct snd_soc_card *card)
 {
@@ -1025,7 +1030,9 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		hp_swapped = "";
 
 	snprintf(byt_rt5651_long_name, sizeof(byt_rt5651_long_name),
-		 "bytcr-rt5651-%s-mic%s",
+		 "bytcr-rt5651-%s-spk-%s-mic%s",
+		 (byt_rt5651_quirk & BYT_RT5651_MONO_SPEAKER) ?
+			"mono" : "stereo",
 		 mic_name[BYT_RT5651_MAP(byt_rt5651_quirk)], hp_swapped);
 	byt_rt5651_card.long_name = byt_rt5651_long_name;
 
-- 
2.17.1
