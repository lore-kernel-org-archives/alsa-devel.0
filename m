From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cnl-match: remove prefix for SOF
	files" to the asoc tree
Date: Tue, 12 Feb 2019 16:58:40 +0000 (GMT)
Message-ID: <20190212165840.957FD1128114@debutante.sirena.org.uk>
References: <20190208234557.7816-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AC48267968
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 17:58:41 +0100 (CET)
In-Reply-To: <20190208234557.7816-5-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cnl-match: remove prefix for SOF files

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

>From 7466e749a3b4e838882cc8728bc66a39df0e9dfa Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Feb 2019 17:45:44 -0600
Subject: [PATCH] ASoC: Intel: cnl-match: remove prefix for SOF files

Prefix is now handled in the code. This allows for default and
alternate paths, and more flexibility for OEMs and distros

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
index ec8e28e7b937..b80b50ddb22b 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
@@ -20,8 +20,8 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[] = {
 		.drv_name = "cnl_rt274",
 		.fw_filename = "intel/dsp_fw_cnl.bin",
 		.pdata = &cnl_pdata,
-		.sof_fw_filename = "intel/sof-cnl.ri",
-		.sof_tplg_filename = "intel/sof-cnl-rt274.tplg",
+		.sof_fw_filename = "sof-cnl.ri",
+		.sof_tplg_filename = "sof-cnl-rt274.tplg",
 		.asoc_plat_name = "0000:00:1f.3",
 	},
 	{},
-- 
2.20.1
