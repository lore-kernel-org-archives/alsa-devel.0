From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: atom: fix 0-day warnings" to the
	asoc tree
Date: Wed, 17 Aug 2016 12:24:50 +0100
Message-ID: <E1bZyxm-00062x-RH@debutante>
References: <1471390103-915-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 118A12669E3
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 13:24:58 +0200 (CEST)
In-Reply-To: <1471390103-915-2-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, sfr@canb.auug.org.au, alsa-devel@alsa-project.org, broonie@kernel.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: atom: fix 0-day warnings

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From cac17731df11e076850c46f50a17266181a10b7c Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 16 Aug 2016 18:28:21 -0500
Subject: [PATCH] ASoC: Intel: atom: fix 0-day warnings

spurious __initconst copy/pasted from other drivers

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c   | 2 +-
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 0c2cc4207b95..773acfbaaf2f 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -245,7 +245,7 @@ static int is_byt_cr(struct device *dev, bool *bytcr)
 	int status = 0;
 
 	if (IS_ENABLED(CONFIG_IOSF_MBI)) {
-		static const struct x86_cpu_id cpu_ids[] __initconst = {
+		static const struct x86_cpu_id cpu_ids[] = {
 			{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
 			{}
 		};
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 09ec3d718357..254881594c36 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -668,7 +668,7 @@ static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 
 static bool is_valleyview(void)
 {
-	static const struct x86_cpu_id cpu_ids[] __initconst = {
+	static const struct x86_cpu_id cpu_ids[] = {
 		{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
 		{}
 	};
-- 
2.8.1
