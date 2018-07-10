From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Remove
	is_valleyview helper" to the asoc tree
Date: Tue, 10 Jul 2018 19:16:45 +0100
Message-ID: <E1fcxBt-0001mY-Ex@debutante>
References: <20180701183631.5532-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 06C10267720
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 20:16:51 +0200 (CEST)
In-Reply-To: <20180701183631.5532-1-hdegoede@redhat.com>
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

   ASoC: Intel: bytcr_rt5651: Remove is_valleyview helper

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

>From fbea16dbc0a31484811c5f335ae344b2bbc66f40 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 1 Jul 2018 20:36:29 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Remove is_valleyview helper

Remove is_valleyview helper, this is not necessary, we can simply call
x86_match_cpu() directly instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index ba2753e0e12a..80f47a45cb10 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -28,6 +28,7 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include <asm/platform_sst_audio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -680,17 +681,10 @@ static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
 static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 static char byt_rt5651_long_name[40]; /* = "bytcr-rt5651-*-mic[-swapped-hp]" */
 
-static bool is_valleyview(void)
-{
-	static const struct x86_cpu_id cpu_ids[] = {
-		{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
-		{}
-	};
-
-	if (!x86_match_cpu(cpu_ids))
-		return false;
-	return true;
-}
+static const struct x86_cpu_id baytrail_cpu_ids[] = {
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT1 }, /* Valleyview */
+	{}
+};
 
 struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 	u64 aif_value;       /* 1: AIF1, 2: AIF2 */
@@ -741,7 +735,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	 * swap SSP0 if bytcr is detected
 	 * (will be overridden if DMI quirk is detected)
 	 */
-	if (is_valleyview()) {
+	if (x86_match_cpu(baytrail_cpu_ids)) {
 		struct sst_platform_info *p_info = mach->pdata;
 		const struct sst_res_info *res_info = p_info->res_info;
 
-- 
2.18.0.rc2
