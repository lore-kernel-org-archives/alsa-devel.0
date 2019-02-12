From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: set
	.ignore_module_refcount field in component" to the asoc tree
Date: Tue, 12 Feb 2019 14:22:06 +0000 (GMT)
Message-ID: <20190212142206.AB9B31128113@debutante.sirena.org.uk>
References: <20190201172224.14549-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8770D2678D2
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 15:22:07 +0100 (CET)
In-Reply-To: <20190201172224.14549-3-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: Skylake: set .ignore_module_refcount field in component

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

>From e0771fc98909096b65c9781c438ac9d9c98ac41a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 1 Feb 2019 11:22:24 -0600
Subject: [PATCH] ASoC: Intel: Skylake: set .ignore_module_refcount field in
 component

There is no risk of the module being removed while the platform
components are in use. This solves the problem of the snd_soc_skl
module not being removable with rmmod

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 8e589d698c58..a4284778f117 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1464,6 +1464,7 @@ static const struct snd_soc_component_driver skl_component  = {
 	.ops		= &skl_platform_ops,
 	.pcm_new	= skl_pcm_new,
 	.pcm_free	= skl_pcm_free,
+	.ignore_module_refcount = 1, /* do not increase the refcount in core */
 };
 
 int skl_platform_register(struct device *dev)
-- 
2.20.1
