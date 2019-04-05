From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH 1/2] ASoC: core: conditionally increase module
	refcount on component open
Date: Thu,  4 Apr 2019 20:06:54 -0700
Message-ID: <20190405030655.13144-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15F0CF80792
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 05:06:58 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

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
index 56099db8f86d..ee53d047c3bd 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1468,7 +1468,7 @@ static const struct snd_soc_component_driver skl_component  = {
 	.ops		= &skl_platform_ops,
 	.pcm_new	= skl_pcm_new,
 	.pcm_free	= skl_pcm_free,
-	.ignore_module_refcount = 1, /* do not increase the refcount in core */
+	.module_get_upon_open = 1, /* increment refcount when a pcm is opened */
 };
 
 int skl_platform_register(struct device *dev)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6f4842977b8d..e78534bbd092 100644
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
2.17.1
