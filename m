From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: simplify boolean tests"
	to the asoc tree
Date: Fri, 21 Dec 2018 18:15:50 +0000 (GMT)
Message-ID: <20181221181550.817E31121B93@debutante.sirena.org.uk>
References: <20181216224910.16198-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D136D267B71
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 19:15:51 +0100 (CET)
In-Reply-To: <20181216224910.16198-3-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Cezary Rojewski <cezary.rojewski@intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: simplify boolean tests

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

>From e7b6afc7472f2b0edaad443814451cd2bf7267ac Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Sun, 16 Dec 2018 16:49:03 -0600
Subject: [PATCH] ASoC: Intel: Skylake: simplify boolean tests

Detected with Coccinelle

skl-messages.c:419:5-32: WARNING: Comparison to bool
skl-pcm.c:1426:6-33: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-pcm.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index b0e6fb93eaf8..28c4806b196a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -416,7 +416,7 @@ int skl_resume_dsp(struct skl *skl)
 	snd_hdac_ext_bus_ppcap_int_enable(bus, true);
 
 	/* check if DSP 1st boot is done */
-	if (skl->skl_sst->is_first_boot == true)
+	if (skl->skl_sst->is_first_boot)
 		return 0;
 
 	/*
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 557f80c0bfe5..8e589d698c58 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1423,7 +1423,7 @@ static int skl_platform_soc_probe(struct snd_soc_component *component)
 		if (!ops)
 			return -EIO;
 
-		if (skl->skl_sst->is_first_boot == false) {
+		if (!skl->skl_sst->is_first_boot) {
 			dev_err(component->dev, "DSP reports first boot done!!!\n");
 			return -EIO;
 		}
-- 
2.20.1
