From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Set card long_name
	based on quirks" to the asoc tree
Date: Thu, 31 May 2018 12:06:14 +0100
Message-ID: <E1fOLPK-0001vO-Jm@debutante>
References: <20180518193506.8251-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 98276267901
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 13:06:28 +0200 (CEST)
In-Reply-To: <20180518193506.8251-1-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Set card long_name based on quirks

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

>From 64484ccee7af53f08cca2ee3853cb8e18914d8b2 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 18 May 2018 21:35:06 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Set card long_name based on quirks

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 3c7d93520c52..1be788e04193 100644
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
@@ -870,6 +875,12 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
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
