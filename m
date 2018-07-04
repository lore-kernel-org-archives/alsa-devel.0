From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/5] ASoC: Intel: bytcr_rt5651: Disable
	jack-detect over suspend/resume
Date: Thu,  5 Jul 2018 00:59:34 +0200
Message-ID: <20180704225935.7902-4-hdegoede@redhat.com>
References: <20180704225935.7902-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id BD94A2676E0
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 00:59:43 +0200 (CEST)
In-Reply-To: <20180704225935.7902-1-hdegoede@redhat.com>
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

Disable jack-detection and thus the codec IRQ over suspend/resume.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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
2.17.1
