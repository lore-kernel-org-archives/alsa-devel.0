From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: skylake: add remove() callback
	for component driver" to the asoc tree
Date: Fri,  5 Apr 2019 09:43:28 +0700 (+07)
Message-ID: <20190405024328.6AA50441D3B@finisterre.ee.mobilebroadband>
References: <20190405003040.8709-3-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 001BBF89746
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 04:43:31 +0200 (CEST)
In-Reply-To: <20190405003040.8709-3-ranjani.sridharan@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: skylake: add remove() callback for component driver

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

>From 2e05ddd2c9f8000751d52fcf35b8318da46026bc Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Thu, 4 Apr 2019 17:30:39 -0700
Subject: [PATCH] ASoC: intel: skylake: add remove() callback for component
 driver

Topology is not unloaded in the core during unregister_component()
anymore. So, add the remove() callback that will unload the
topology.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 56099db8f86d..57031b6d4d45 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1462,9 +1462,16 @@ static int skl_platform_soc_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static void skl_pcm_remove(struct snd_soc_component *component)
+{
+	/* remove topology */
+	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
+}
+
 static const struct snd_soc_component_driver skl_component  = {
 	.name		= "pcm",
 	.probe		= skl_platform_soc_probe,
+	.remove		= skl_pcm_remove,
 	.ops		= &skl_platform_ops,
 	.pcm_new	= skl_pcm_new,
 	.pcm_free	= skl_pcm_free,
-- 
2.20.1
