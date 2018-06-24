From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 7/9] ASoC: Intel: bytcr_rt5651: Simplify card
	long-name
Date: Sun, 24 Jun 2018 16:06:32 +0200
Message-ID: <20180624140634.16835-8-hdegoede@redhat.com>
References: <20180624140634.16835-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E45C267716
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 16:06:49 +0200 (CEST)
In-Reply-To: <20180624140634.16835-1-hdegoede@redhat.com>
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

Now that the headset-mic is always IN3 there is no reason to have
the headset-mic mapping in the long-name.

This commit simplifies the long name to "bytcr-rt5651-<intmic-map>-mic".

We can safely do this without causing regressions (UCM profile not found
due to the longname change) as the UCM profiles are not in upstream
alsa-lib yet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 4499960e1c21..45a11799c008 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -683,7 +683,7 @@ static struct snd_soc_card byt_rt5651_card = {
 static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
 static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
 static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
-static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-spk-*-mic" */
+static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-mic" */
 
 static bool is_valleyview(void)
 {
@@ -704,8 +704,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
-	const char * const intmic_name[] = { "dmic", "in1", "in12" };
-	const char * const hsmic_name[] = { "in3", "in3", "in3" };
+	const char * const mic_name[] = { "dmic", "in1", "in12" };
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
@@ -852,9 +851,8 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	}
 
 	snprintf(byt_rt5651_long_name, sizeof(byt_rt5651_long_name),
-		 "bytcr-rt5651-%s-intmic-%s-hsmic",
-		 intmic_name[BYT_RT5651_MAP(byt_rt5651_quirk)],
-		 hsmic_name[BYT_RT5651_MAP(byt_rt5651_quirk)]);
+		 "bytcr-rt5651-%s-mic",
+		 mic_name[BYT_RT5651_MAP(byt_rt5651_quirk)]);
 	byt_rt5651_card.long_name = byt_rt5651_long_name;
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5651_card);
-- 
2.17.1
