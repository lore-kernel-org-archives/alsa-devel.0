From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH v2 2/2] ASoC: pcm: update module refcount if
	module_get_upon_open is set
Date: Fri,  5 Apr 2019 09:57:09 -0700
Message-ID: <20190405165709.14202-2-ranjani.sridharan@linux.intel.com>
References: <20190405165709.14202-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43B09F80792
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 18:57:15 +0200 (CEST)
In-Reply-To: <20190405165709.14202-1-ranjani.sridharan@linux.intel.com>
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

Setting the module_get_upon_open field for component driver
prevents the module refcount from being incremented during
component probe(). This could lead to the module being
allowed to be unloaded when a pcm stream is open. So,
if this field is set, the module's refcount should be
incremented during pcm open to prevent module removal
when the component is in use. And, the refcount should
be decremented upon pcm close.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-pcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7fe5321000e8..4192f6900d4d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/export.h>
@@ -463,6 +464,9 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream,
 			continue;
 
 		component->driver->ops->close(substream);
+
+		if (component->driver->module_get_upon_open)
+			module_put(component->dev->driver->owner);
 	}
 
 	return 0;
@@ -513,6 +517,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		    !component->driver->ops->open)
 			continue;
 
+		if (component->driver->module_get_upon_open &&
+		    !try_module_get(component->dev->driver->owner))
+			return -ENODEV;
+
 		ret = component->driver->ops->open(substream);
 		if (ret < 0) {
 			dev_err(component->dev,
-- 
2.17.1
