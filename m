From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: conditionally increase module
	refcount on component open" to the asoc tree
Date: Mon,  8 Apr 2019 14:24:20 +0700 (+07)
Message-ID: <20190408072420.54C23441D3C@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B25CFF89728
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2019 09:24:34 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: conditionally increase module refcount on component open

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

>From b4ed6b51f356224c6c71540ed94087f7f09b84af Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Fri, 5 Apr 2019 09:57:08 -0700
Subject: [PATCH] ASoC: core: conditionally increase module refcount on
 component open

Recently, for Intel platforms the "ignore_module_refcount" field
was introduced for the component driver. In order to avoid a
deadlock preventing the PCI modules from being removed
even when the card was idle, the refcounts were not incremented
for the device driver module during component probe.

However, this change introduced a nasty side effect:
the device driver module can be unloaded while a pcm stream is open.

This patch proposes to change the field to be renamed as
"module_get_upon_open". When this field is set, the module
refcount should be incremented on pcm open amd decremented
upon pcm close. This will enable modules to be removed
when no PCM playback/capture happens and prevent removal
when the component is actually in use.

Also, align with the skylake component driver with the new name.

Fixes: b450b878('ASoC: core: don't increase component module refcount
                 unconditionally'
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h               | 9 +++++++--
 sound/soc/intel/skylake/skl-pcm.c | 2 +-
 sound/soc/soc-core.c              | 4 ++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1e2be35ed36f..482b4ea87c3c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -802,8 +802,13 @@ struct snd_soc_component_driver {
 	int probe_order;
 	int remove_order;
 
-	/* signal if the module handling the component cannot be removed */
-	unsigned int ignore_module_refcount:1;
+	/*
+	 * signal if the module handling the component should not be removed
+	 * if a pcm is open. Setting this would prevent the module
+	 * refcount being incremented in probe() but allow it be incremented
+	 * when a pcm is opened and decremented when it is closed.
+	 */
+	unsigned int module_get_upon_open:1;
 
 	/* bits */
 	unsigned int idle_bias_on:1;
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 57031b6d4d45..9735e2412251 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1475,7 +1475,7 @@ static const struct snd_soc_component_driver skl_component  = {
 	.ops		= &skl_platform_ops,
 	.pcm_new	= skl_pcm_new,
 	.pcm_free	= skl_pcm_free,
-	.ignore_module_refcount = 1, /* do not increase the refcount in core */
+	.module_get_upon_open = 1, /* increment refcount when a pcm is opened */
 };
 
 int skl_platform_register(struct device *dev)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d88757659729..46e3ab0fced4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -947,7 +947,7 @@ static void soc_cleanup_component(struct snd_soc_component *component)
 	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
 	soc_cleanup_component_debugfs(component);
 	component->card = NULL;
-	if (!component->driver->ignore_module_refcount)
+	if (!component->driver->module_get_upon_open)
 		module_put(component->dev->driver->owner);
 }
 
@@ -1381,7 +1381,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 		return 0;
 	}
 
-	if (!component->driver->ignore_module_refcount &&
+	if (!component->driver->module_get_upon_open &&
 	    !try_module_get(component->dev->driver->owner))
 		return -ENODEV;
 
-- 
2.20.1
