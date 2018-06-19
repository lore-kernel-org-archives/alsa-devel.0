From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: common: fix copy/paste issue
	with SOF/broadwell topology file" to the asoc tree
Date: Tue, 19 Jun 2018 16:24:31 +0100
Message-ID: <E1fVIUh-0002LO-6T@debutante>
References: <20180618182942.4925-9-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 500F92675D5
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 17:24:36 +0200 (CEST)
In-Reply-To: <20180618182942.4925-9-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: common: fix copy/paste issue with SOF/broadwell topology file

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

>From f0d9034b290d8bad590e843c2a1081eb47d813ad Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 18 Jun 2018 13:29:42 -0500
Subject: [PATCH] ASoC: Intel: common: fix copy/paste issue with SOF/broadwell
 topology file

There are two commercially-available Broadwell platforms based on I2S
(Dell XPS13 and 'Samus' Pixel 2015 Chromebook).

Fix a copy/paste issue to allow each platform to enable different
features if needed when SOF is enabled

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index e0e8c8c27528..53e7acdfbb81 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -45,7 +45,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.drv_name = "bdw-rt5677",
 		.fw_filename =  "intel/IntcSST2.bin",
 		.sof_fw_filename = "intel/reef-bdw.ri",
-		.sof_tplg_filename = "intel/reef-bdw-rt286.tplg",
+		.sof_tplg_filename = "intel/reef-bdw-rt5677.tplg",
 		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
-- 
2.17.1
