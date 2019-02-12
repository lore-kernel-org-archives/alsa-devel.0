From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: don't increase component module
	refcount unconditionally" to the asoc tree
Date: Tue, 12 Feb 2019 14:22:08 +0000 (GMT)
Message-ID: <20190212142208.D454C1128113@debutante.sirena.org.uk>
References: <20190201172224.14549-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E5FDB26789B
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 15:22:09 +0100 (CET)
In-Reply-To: <20190201172224.14549-2-pierre-louis.bossart@linux.intel.com>
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

   ASoC: core: don't increase component module refcount unconditionally

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

>From b450b87847b157d69dbf9af7aefb4cec29e89cc9 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 1 Feb 2019 11:22:23 -0600
Subject: [PATCH] ASoC: core: don't increase component module refcount
 unconditionally

The ASoC core has for the longest time increased the module reference
counts, even before the transition to the component model. This is
probably fine on most platforms, but it introduces a deadlock case on
Intel devices with the Skylake and SOF drivers which cannot be removed
due to their reference counts being modified by the core.

In these 2 cases, the PCI or ACPI driver .probe creates a platform
device to let the machine driver .probe register the audio
card. Conversely the PCI or ACPI driver .remove will unregister the
platform device which results in the card being removed by the machine
driver .remove.

With ascii art, this can be represented as

modprobe
snd_soc_skl/
soc-pci-dev/sof-acpci-dev  ----------> pci/acpi probe
       ^                                    |
       |                     ---------------|
       |                    |               |
       |                    V               V
    increase            register        register machine
    refcount            component       platform_device
       ^                                    |
       |                                    |
       |                                    V
    component <----   register card  <---- probe
    probe

The issue is that by playing with the component's module reference
counts during the card registration, it's no longer possible to remove
the module which controls the component. This can be shown, e.g. with
the following error:

root@plb-XPS-13-9350:~# lsmod | grep snd_soc_skl
snd_soc_skl           110592  1

root@plb-XPS-13-9350:~# rmmod snd_soc_skl
rmmod: ERROR: Module snd_soc_skl is in use

Increasing the reference count during the component probe is not
useful. If the PCI/ACPI module is removed, the card will be removed
anyway.

To avoid breaking existing platforms and allowing Intel platforms to
safely deal with module load/unload cases, this patch introduces a
flag which needs to be set during the component initialization. This
is a strictly opt-in capability that should only be used when the
handling of the component module does not require a reference count
increase to prevent removal during use.

Note that this solution is not directly applicable to the legacy
Atom/SST driver, which uses a different device hierarchy. There are
however additional refcount issues which prevent the ACPI driver from
being removed. This is a different issue which would need a different
patch.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 3 +++
 sound/soc/soc-core.c | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 95689680336b..eb7db605955b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -802,6 +802,9 @@ struct snd_soc_component_driver {
 	int probe_order;
 	int remove_order;
 
+	/* signal if the module handling the component cannot be removed */
+	unsigned int ignore_module_refcount:1;
+
 	/* bits */
 	unsigned int idle_bias_on:1;
 	unsigned int suspend_bias_off:1;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 994d21d7ba0f..93d316d5bf8e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -947,7 +947,8 @@ static void soc_cleanup_component(struct snd_soc_component *component)
 	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
 	soc_cleanup_component_debugfs(component);
 	component->card = NULL;
-	module_put(component->dev->driver->owner);
+	if (!component->driver->ignore_module_refcount)
+		module_put(component->dev->driver->owner);
 }
 
 static void soc_remove_component(struct snd_soc_component *component)
@@ -1380,7 +1381,8 @@ static int soc_probe_component(struct snd_soc_card *card,
 		return 0;
 	}
 
-	if (!try_module_get(component->dev->driver->owner))
+	if (!component->driver->ignore_module_refcount &&
+	    !try_module_get(component->dev->driver->owner))
 		return -ENODEV;
 
 	component->card = card;
-- 
2.20.1
