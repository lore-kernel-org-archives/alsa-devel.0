From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Simplify card
	long-name" to the asoc tree
Date: Wed, 27 Jun 2018 12:31:23 +0100 (BST)
Message-ID: <20180627113123.24D6D440070@finisterre.ee.mobilebroadband>
References: <20180624140634.16835-8-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E0D5026797D
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 13:31:24 +0200 (CEST)
In-Reply-To: <20180624140634.16835-8-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Simplify card long-name

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8e69cd640097fa7af53fb476dbd3597608f32b10 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 24 Jun 2018 16:06:32 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Simplify card long-name

Now that the headset-mic is always IN3 there is no reason to have
the headset-mic mapping in the long-name.

This commit simplifies the long name to "bytcr-rt5651-<intmic-map>-mic".

We can safely do this without causing regressions (UCM profile not found
due to the longname change) as the UCM profiles are not in upstream
alsa-lib yet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 042334d9be32..e778142b8a6e 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -662,7 +662,7 @@ static struct snd_soc_card byt_rt5651_card = {
 static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
 static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
 static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
-static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-spk-*-mic" */
+static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-mic" */
 
 static bool is_valleyview(void)
 {
@@ -683,8 +683,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
-	const char * const intmic_name[] = { "dmic", "in1", "in12" };
-	const char * const hsmic_name[] = { "in3", "in3", "in3" };
+	const char * const mic_name[] = { "dmic", "in1", "in12" };
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
@@ -831,9 +830,8 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
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
