From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Report Platform ID info
	from NHLT" to the asoc tree
Date: Mon, 06 Feb 2017 13:37:41 +0000
Message-ID: <E1cajUD-0001rO-Nd@finisterre>
References: <1484132462-3581-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A7AB7266DA1
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 14:38:00 +0100 (CET)
In-Reply-To: <1484132462-3581-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Sodhi,
 VunnyX" <vunnyx.sodhi@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Report Platform ID info from NHLT

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0cf5a17159edbebfe3ce2a0ce1dd36bd5809479a Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Wed, 11 Jan 2017 16:31:02 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Report Platform ID info from NHLT

This patch create entry in sysfs file system to report the
platform_id = "pci-id-oem_id-oem_table_id-oem_revision"
for board identification.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Sodhi, VunnyX <vunnyx.sodhi@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-nhlt.c | 42 +++++++++++++++++++++++++++++++++++---
 sound/soc/intel/skylake/skl.c      |  5 +++++
 sound/soc/intel/skylake/skl.h      |  2 ++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 3f8e6f0b7eb5..2710a3704a38 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -189,9 +189,9 @@ int skl_get_dmic_geo(struct skl *skl)
 	return dmic_geo;
 }
 
-static void skl_nhlt_trim_space(struct skl *skl)
+static void skl_nhlt_trim_space(char *trim)
 {
-	char *s = skl->tplg_name;
+	char *s = trim;
 	int cnt;
 	int i;
 
@@ -218,7 +218,43 @@ int skl_nhlt_update_topology_bin(struct skl *skl)
 		skl->pci_id, nhlt->header.oem_id, nhlt->header.oem_table_id,
 		nhlt->header.oem_revision, "-tplg.bin");
 
-	skl_nhlt_trim_space(skl);
+	skl_nhlt_trim_space(skl->tplg_name);
 
 	return 0;
 }
+
+static ssize_t skl_nhlt_platform_id_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct skl *skl = ebus_to_skl(ebus);
+	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
+	char platform_id[32];
+
+	sprintf(platform_id, "%x-%.6s-%.8s-%d", skl->pci_id,
+			nhlt->header.oem_id, nhlt->header.oem_table_id,
+			nhlt->header.oem_revision);
+
+	skl_nhlt_trim_space(platform_id);
+	return sprintf(buf, "%s\n", platform_id);
+}
+
+static DEVICE_ATTR(platform_id, 0444, skl_nhlt_platform_id_show, NULL);
+
+int skl_nhlt_create_sysfs(struct skl *skl)
+{
+	struct device *dev = &skl->pci->dev;
+
+	if (sysfs_create_file(&dev->kobj, &dev_attr_platform_id.attr))
+		dev_warn(dev, "Error creating sysfs entry\n");
+
+	return 0;
+}
+
+void skl_nhlt_remove_sysfs(struct skl *skl)
+{
+	struct device *dev = &skl->pci->dev;
+
+	sysfs_remove_file(&dev->kobj, &dev_attr_platform_id.attr);
+}
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index da5db5098274..1152e46daede 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -732,6 +732,10 @@ static int skl_probe(struct pci_dev *pci,
 		goto out_display_power_off;
 	}
 
+	err = skl_nhlt_create_sysfs(skl);
+	if (err < 0)
+		goto out_nhlt_free;
+
 	skl_nhlt_update_topology_bin(skl);
 
 	pci_set_drvdata(skl->pci, ebus);
@@ -852,6 +856,7 @@ static void skl_remove(struct pci_dev *pci)
 	skl_free_dsp(skl);
 	skl_machine_device_unregister(skl);
 	skl_dmic_device_unregister(skl);
+	skl_nhlt_remove_sysfs(skl);
 	skl_nhlt_free(skl->nhlt);
 	skl_free(ebus);
 	dev_set_drvdata(&pci->dev, NULL);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 4986e3929dd3..0a1b02e21277 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -130,5 +130,7 @@ int skl_resume_dsp(struct skl *skl);
 void skl_cleanup_resources(struct skl *skl);
 const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id);
 void skl_update_d0i3c(struct device *dev, bool enable);
+int skl_nhlt_create_sysfs(struct skl *skl);
+void skl_nhlt_remove_sysfs(struct skl *skl);
 
 #endif /* __SOUND_SOC_SKL_H */
-- 
2.11.0
