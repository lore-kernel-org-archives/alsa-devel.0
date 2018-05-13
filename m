From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 10/10] ASoC: Intel: bytcr_rt5640: Set card
	long_name based on quirks
Date: Sun, 13 May 2018 09:24:35 +0200
Message-ID: <20180513072435.3358-11-hdegoede@redhat.com>
References: <20180513072435.3358-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 99804267677
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 09:25:17 +0200 (CEST)
In-Reply-To: <20180513072435.3358-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Many X86 devices using a BYT SoC + RT5640 codec are cheap devices with
generic DMI strings, causing snd_soc_set_dmi_name() to fail to set a
long_name, making it impossible for userspace to have a correct UCM
profile which only uses inputs / outputs which are actually hooked up
on the device.

Our quirks already specify which input the internal mic is connected to
and if a single (mono) speaker is used or if the device has stereo
speakers.

This commit sets a long_name based on the quirks so that userspace can
have UCM profiles doing the right thing based on the long_name.

Note that if we ever encounter the need for a special UCM profile for
some device we can add a quirk to set a specific long_name for the
device,

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 686d00405493..b0eec0a9b7b9 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -950,6 +950,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 static char byt_rt5640_codec_name[SND_ACPI_I2C_ID_LEN];
 static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
 static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
+static char byt_rt5640_long_name[40]; /* = "bytcr-rt5640-*-spk-*-mic" */
 
 static int byt_rt5640_suspend(struct snd_soc_card *card)
 {
@@ -1021,6 +1022,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
+	const char * const map_name[] = { "dmic1", "dmic2", "in1", "in3" };
 	const struct dmi_system_id *dmi_id;
 	struct byt_rt5640_private *priv;
 	struct snd_soc_acpi_mach *mach;
@@ -1184,6 +1186,13 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	snprintf(byt_rt5640_long_name, sizeof(byt_rt5640_long_name),
+		 "bytcr-rt5640-%s-spk-%s-mic",
+		 (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) ?
+			"mono" : "stereo",
+		 map_name[BYT_RT5640_MAP(byt_rt5640_quirk)]);
+	byt_rt5640_card.long_name = byt_rt5640_long_name;
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
 
 	if (ret_val) {
-- 
2.17.0
