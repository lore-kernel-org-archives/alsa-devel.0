From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC 05/10] ALSA: hda - make some of the functions
	externally visible
Date: Fri,  1 Dec 2017 14:44:03 +0530
Message-ID: <1512119648-2700-6-git-send-email-rakesh.a.ughreja@intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 245FE267BDB
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 10:10:06 +0100 (CET)
In-Reply-To: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
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
other kernel modules. These APIs would be called by ASoC based HDA codec
driver which will be added in the later patches.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/pci/hda/hda_codec.c | 9 +++++++--
 sound/pci/hda/hda_codec.h | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

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
index 681c360..2d02d02 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -83,7 +83,7 @@ struct hda_bus {
  * better than the generic parser.
  */
 typedef int (*hda_codec_patch_t)(struct hda_codec *);
-	
+
 #define HDA_CODEC_ID_GENERIC_HDMI	0x00000101
 #define HDA_CODEC_ID_GENERIC		0x00000201
 
@@ -497,6 +497,8 @@ int hda_call_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 #ifdef CONFIG_PM
 void snd_hda_set_power_save(struct hda_bus *bus, int delay);
 void snd_hda_update_power_acct(struct hda_codec *codec);
+int hda_codec_runtime_suspend(struct device *dev);
+int hda_codec_runtime_resume(struct device *dev);
 #else
 static inline void snd_hda_set_power_save(struct hda_bus *bus, int delay) {}
 #endif
-- 
2.7.4
