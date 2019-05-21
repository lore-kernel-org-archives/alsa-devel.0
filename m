From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: soc-acpi: Fix machine selection
	order" to the asoc tree
Date: Tue, 21 May 2019 21:32:43 +0100 (BST)
Message-ID: <20190521203243.607721126D22@debutante.sirena.org.uk>
References: <20190518183009.13359-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E6B9F89728
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 22:32:51 +0200 (CEST)
In-Reply-To: <20190518183009.13359-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: soc-acpi: Fix machine selection order

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 30d9d4ff53532087bc13ed29d7715df868794b5e Mon Sep 17 00:00:00 2001
From: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Date: Sat, 18 May 2019 13:30:08 -0500
Subject: [PATCH] ASoC: Intel: soc-acpi: Fix machine selection order

The selection order of m/c in match table is corrected
to use common codec as last in the list.

Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
index df7c52cad5c3..c36c0aa4f683 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
@@ -29,17 +29,17 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[] = {
 		.sof_tplg_filename = "sof-cnl-rt274.tplg",
 	},
 	{
-		.id = "10EC5682",
+		.id = "MX98357A",
 		.drv_name = "sof_rt5682",
+		.quirk_data = &cml_codecs,
 		.sof_fw_filename = "sof-cnl.ri",
-		.sof_tplg_filename = "sof-cml-rt5682.tplg",
+		.sof_tplg_filename = "sof-cml-rt5682-max98357a.tplg",
 	},
 	{
-		.id = "MX98357A",
+		.id = "10EC5682",
 		.drv_name = "sof_rt5682",
-		.quirk_data = &cml_codecs,
 		.sof_fw_filename = "sof-cnl.ri",
-		.sof_tplg_filename = "sof-cml-rt5682-max98357a.tplg",
+		.sof_tplg_filename = "sof-cml-rt5682.tplg",
 	},
 
 	{},
-- 
2.20.1
