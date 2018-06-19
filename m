From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: cleanup before moving
	ACPI tables" to the asoc tree
Date: Tue, 19 Jun 2018 16:24:42 +0100
Message-ID: <E1fVIUs-0002QE-48@debutante>
References: <20180618182942.4925-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BB412676E3
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 17:24:44 +0200 (CEST)
In-Reply-To: <20180618182942.4925-3-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: Skylake: cleanup before moving ACPI tables

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

>From 5f15f267daf81a4c7c2a1cd2a0d6743ec7fc8b59 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 18 Jun 2018 13:29:36 -0500
Subject: [PATCH] ASoC: Intel: Skylake: cleanup before moving ACPI tables

There is no need to deal with DMICs if the DSP is not present and
there is no ACPI machine ID found.

Simplify before moving these ACPI tables to sound/soc/intel/common

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 0a8f0768e987..6dec748e8949 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -500,10 +500,12 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
 
 	skl->mach = mach;
 	skl->fw_name = mach->fw_filename;
-	pdata = skl->mach->pdata;
+	pdata = mach->pdata;
 
-	if (mach->pdata)
+	if (pdata) {
 		skl->use_tplg_pcm = pdata->use_tplg_pcm;
+		pdata->dmic_num = skl_get_dmic_geo(skl);
+	}
 
 	return 0;
 }
@@ -930,8 +932,6 @@ static int skl_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(skl->pci, ebus);
 
-	skl_dmic_data.dmic_num = skl_get_dmic_geo(skl);
-
 	/* check if dsp is there */
 	if (bus->ppcap) {
 		/* create device for dsp clk */
-- 
2.17.1
