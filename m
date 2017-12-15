From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v3 05/11] ALSA: hda - make some of the functions
	externally visible
Date: Fri, 15 Dec 2017 17:00:42 +0530
Message-ID: <1513337448-31685-6-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C916C267BC0
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:26:25 +0100 (CET)
In-Reply-To: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Mark some functions with EXPORT_SYMBOL_GPL so that it can be called by
other kernel modules. Move the probe function into generic driver.
These APIs would be called by ASoC based HDA codec driver which will be
added in the later patches.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/pci/hda/hda_bind.c    | 10 +++++-----
 sound/pci/hda/hda_codec.c   |  9 +++++++--
 sound/pci/hda/hda_codec.h   |  6 ++++++
 sound/pci/hda/hda_generic.c | 13 +++++++++++++
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index d361bb7..d8715a1 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -149,8 +149,8 @@ static void hda_codec_driver_shutdown(struct device *dev)
 		codec->patch_ops.reboot_notify(codec);
 }
 
-int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
-			       struct module *owner)
+int __hda_legacy_codec_driver_register(struct hda_codec_driver *drv,
+					const char *name, struct module *owner)
 {
 	drv->core.driver.name = name;
 	drv->core.driver.owner = owner;
@@ -164,13 +164,13 @@ int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
 	drv->core.unsol_event = hda_codec_unsol_event;
 	return driver_register(&drv->core.driver);
 }
-EXPORT_SYMBOL_GPL(__hda_codec_driver_register);
+EXPORT_SYMBOL_GPL(__hda_legacy_codec_driver_register);
 
-void hda_codec_driver_unregister(struct hda_codec_driver *drv)
+void hda_legacy_codec_driver_unregister(struct hda_codec_driver *drv)
 {
 	driver_unregister(&drv->core.driver);
 }
-EXPORT_SYMBOL_GPL(hda_codec_driver_unregister);
+EXPORT_SYMBOL_GPL(hda_legacy_codec_driver_unregister);
 
 static inline bool codec_probed(struct hda_codec *codec)
 {
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e018ecb..085fd9e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2903,7 +2903,7 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	atomic_dec(&codec->core.in_pm);
 }
 
-static int hda_codec_runtime_suspend(struct device *dev)
+int hda_codec_runtime_suspend(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 	struct hda_pcm *pcm;
@@ -2919,8 +2919,9 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	snd_hdac_link_power(&codec->core, false);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hda_codec_runtime_suspend);
 
-static int hda_codec_runtime_resume(struct device *dev)
+int hda_codec_runtime_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
@@ -2930,6 +2931,7 @@ static int hda_codec_runtime_resume(struct device *dev)
 	pm_runtime_mark_last_busy(dev);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hda_codec_runtime_resume);
 #endif /* CONFIG_PM */
 
 /* referred in hda_bind.c */
@@ -3005,6 +3007,7 @@ int snd_hda_codec_build_controls(struct hda_codec *codec)
 	sync_power_up_states(codec);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_hda_codec_build_controls);
 
 /*
  * PCM stuff
@@ -3210,6 +3213,7 @@ int snd_hda_codec_parse_pcms(struct hda_codec *codec)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_hda_codec_parse_pcms);
 
 /* assign all PCMs of the given codec */
 int snd_hda_codec_build_pcms(struct hda_codec *codec)
@@ -3246,6 +3250,7 @@ int snd_hda_codec_build_pcms(struct hda_codec *codec)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_hda_codec_build_pcms);
 
 /**
  * snd_hda_add_new_ctls - create controls from the array
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 681c360..ef626cf 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -99,6 +99,10 @@ struct hda_codec_driver {
 	const struct hda_device_id *id;
 };
 
+int __hda_legacy_codec_driver_register(struct hda_codec_driver *drv,
+				const char *name, struct module *owner);
+void hda_legacy_codec_driver_unregister(struct hda_codec_driver *drv);
+
 int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
 			       struct module *owner);
 #define hda_codec_driver_register(drv) \
@@ -497,6 +501,8 @@ int hda_call_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 #ifdef CONFIG_PM
 void snd_hda_set_power_save(struct hda_bus *bus, int delay);
 void snd_hda_update_power_acct(struct hda_codec *codec);
+int hda_codec_runtime_suspend(struct device *dev);
+int hda_codec_runtime_resume(struct device *dev);
 #else
 static inline void snd_hda_set_power_save(struct hda_bus *bus, int delay) {}
 #endif
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 5cc6509..09ab02e 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5961,6 +5961,19 @@ static int snd_hda_parse_generic_codec(struct hda_codec *codec)
 	return err;
 }
 
+int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
+			       struct module *owner)
+{
+	return __hda_legacy_codec_driver_register(drv, name, owner);
+}
+EXPORT_SYMBOL_GPL(__hda_codec_driver_register);
+
+void hda_codec_driver_unregister(struct hda_codec_driver *drv)
+{
+	hda_legacy_codec_driver_unregister(drv);
+}
+EXPORT_SYMBOL_GPL(hda_codec_driver_unregister);
+
 static const struct hda_device_id snd_hda_id_generic[] = {
 	HDA_CODEC_ENTRY(HDA_CODEC_ID_GENERIC, "Generic", snd_hda_parse_generic_codec),
 	{} /* terminator */
-- 
2.7.4
