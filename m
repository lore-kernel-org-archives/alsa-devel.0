From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm: update module refcount if
	module_get_upon_open is set" to the asoc tree
Date: Mon,  8 Apr 2019 14:24:10 +0700 (+07)
Message-ID: <20190408072410.82FF0441D3B@finisterre.ee.mobilebroadband>
References: <20190405165709.14202-2-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 241B4F8971B
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2019 09:24:25 +0200 (CEST)
In-Reply-To: <20190405165709.14202-2-ranjani.sridharan@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm: update module refcount if module_get_upon_open is set

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

>From 52034add758e268c39110f33d46e2a9492e82aef Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Fri, 5 Apr 2019 09:57:09 -0700
Subject: [PATCH] ASoC: pcm: update module refcount if module_get_upon_open is
 set

Setting the module_get_upon_open field for component driver
prevents the module refcount from being incremented during
component probe(). This could lead to the module being
allowed to be unloaded when a pcm stream is open. So,
if this field is set, the module's refcount should be
incremented during pcm open to prevent module removal
when the component is in use. And, the refcount should
be decremented upon pcm close.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2d5d5cac4ba6..d21247546f7f 100644
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
2.20.1
