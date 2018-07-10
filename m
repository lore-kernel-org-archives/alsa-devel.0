From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Disable
	jack-detect over suspend/resume" to the asoc tree
Date: Tue, 10 Jul 2018 19:16:32 +0100
Message-ID: <E1fcxBg-0001gI-4m@debutante>
References: <20180704225935.7902-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 653CD267713
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 20:16:42 +0200 (CEST)
In-Reply-To: <20180704225935.7902-4-hdegoede@redhat.com>
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

   ASoC: Intel: bytcr_rt5651: Disable jack-detect over suspend/resume

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

>From b91f432cbc3326f715b8c3f02ff4066ab398833f Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 5 Jul 2018 00:59:34 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Disable jack-detect over
 suspend/resume

Disable jack-detection and thus the codec IRQ over suspend/resume.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 49 ++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 5301205496be..2a8f86dfe4cb 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -676,6 +676,48 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
 };
 
 /* SoC card */
+static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
+static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
+static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
+static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-mic[-swapped-hp]" */
+
+static int byt_rt5651_suspend(struct snd_soc_card *card)
+{
+	struct snd_soc_component *component;
+
+	if (!BYT_RT5651_JDSRC(byt_rt5651_quirk))
+		return 0;
+
+	list_for_each_entry(component, &card->component_dev_list, card_list) {
+		if (!strcmp(component->name, byt_rt5651_codec_name)) {
+			dev_dbg(component->dev, "disabling jack detect before suspend\n");
+			snd_soc_component_set_jack(component, NULL, NULL);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int byt_rt5651_resume(struct snd_soc_card *card)
+{
+	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
+	struct snd_soc_component *component;
+
+	if (!BYT_RT5651_JDSRC(byt_rt5651_quirk))
+		return 0;
+
+	list_for_each_entry(component, &card->component_dev_list, card_list) {
+		if (!strcmp(component->name, byt_rt5651_codec_name)) {
+			dev_dbg(component->dev, "re-enabling jack detect after resume\n");
+			snd_soc_component_set_jack(component, &priv->jack, NULL);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static struct snd_soc_card byt_rt5651_card = {
 	.name = "bytcr-rt5651",
 	.owner = THIS_MODULE,
@@ -686,13 +728,10 @@ static struct snd_soc_card byt_rt5651_card = {
 	.dapm_routes = byt_rt5651_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(byt_rt5651_audio_map),
 	.fully_routed = true,
+	.suspend_pre = byt_rt5651_suspend,
+	.resume_post = byt_rt5651_resume,
 };
 
-static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
-static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
-static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
-static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-mic[-swapped-hp]" */
-
 static const struct x86_cpu_id baytrail_cpu_ids[] = {
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT1 }, /* Valleyview */
 	{}
-- 
2.18.0.rc2
