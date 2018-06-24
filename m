From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6/9] ASoC: Intel: bytcr_rt5651: Fix DMIC map
	headsetmic mapping
Date: Sun, 24 Jun 2018 16:06:31 +0200
Message-ID: <20180624140634.16835-7-hdegoede@redhat.com>
References: <20180624140634.16835-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CB36267716
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 16:06:48 +0200 (CEST)
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

The initial bytcr_rt5651 machine driver commit mapped IN2 as the headset
mic. In retrospect this is not correct as all known boards have the headset
mic on IN3.

This commit fixes the original DMIC mapping to correctly have the headset
mic on IN3.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 70067e31a33e..4499960e1c21 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -238,9 +238,9 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
-	{"IN2P", NULL, "Headset Mic"},
 	{"DMIC L1", NULL, "Internal Mic"},
 	{"DMIC R1", NULL, "Internal Mic"},
+	{"IN3P", NULL, "Headset Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
@@ -705,7 +705,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
 	const char * const intmic_name[] = { "dmic", "in1", "in12" };
-	const char * const hsmic_name[] = { "in2", "in3", "in3" };
+	const char * const hsmic_name[] = { "in3", "in3", "in3" };
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
-- 
2.17.1
