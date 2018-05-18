From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Set card long_name
	based on quirks
Date: Fri, 18 May 2018 21:35:06 +0200
Message-ID: <20180518193506.8251-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id A4AD0267046
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 21:35:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Many X86 devices using a BYT SoC + RT5651 codec are cheap devices with
generic DMI strings, causing snd_soc_set_dmi_name() to fail to set a
long_name, making it impossible for userspace to have a correct UCM
profile which knowns which input is connected to the internal mic,
which input is connected to the hsmic (for correct jack-based switching)
and which inputs are unused.

Our quirks already specify which inputs the internal and headset mic
are connected to.

This commit sets a long_name based on the quirks so that userspace can
have UCM profiles doing the right thing based on the long_name.

Note that if we ever encounter the need for a special UCM profile for
some device we can add a quirk to set a specific long_name for the
device,

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 469e2695d121..987720e203f9 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -706,6 +706,7 @@ static struct snd_soc_card byt_rt5651_card = {
 static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
 static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
 static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
+static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-spk-*-mic" */
 
 static bool is_valleyview(void)
 {
@@ -726,6 +727,10 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
+	const char * const intmic_name[] =
+		{ "dmic", "in1", "in2", "in12", "in1", "in2" };
+	const char * const hsmic_name[] =
+		{  "in2", "in2", "in1",  "in3", "in3", "in3" };
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
@@ -871,6 +876,12 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	snprintf(byt_rt5651_long_name, sizeof(byt_rt5651_long_name),
+		 "bytcr-rt5651-%s-intmic-%s-hsmic",
+		 intmic_name[BYT_RT5651_MAP(byt_rt5651_quirk)],
+		 hsmic_name[BYT_RT5651_MAP(byt_rt5651_quirk)]);
+	byt_rt5651_card.long_name = byt_rt5651_long_name;
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5651_card);
 
 	if (ret_val) {
-- 
2.17.0
