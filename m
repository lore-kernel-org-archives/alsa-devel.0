From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 1/2] ALSA: hda: add snd_adsp_enable module
	flag
Date: Thu, 18 Jun 2015 12:08:24 +0530
Message-ID: <1434609505-776-2-git-send-email-vinod.koul@intel.com>
References: <1434609505-776-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 784E826616A
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 08:36:55 +0200 (CEST)
In-Reply-To: <1434609505-776-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

Some Intel HDA controllers sport a DSP. These systems can also be
enabled with ASoC HDA driver as well. So add a flag in hda-core to
enable/disable aDSP. This flag for now is false, and should be true
once the ASoC based systems mature.  The integrators/OS vendors can
configure this flag based on system preference.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h  | 11 +++++++++++
 sound/hda/hda_bus_type.c |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 4caf1fde8a4f..7c4dd26abd4e 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -13,6 +13,17 @@
 #include <sound/hda_verbs.h>
 #include <drm/i915_component.h>
 
+/*
+ * snd_adsp_enable: exported HD-A aDSP enable configuration.
+ *
+ * Some Intel HDA controllers sport a DSP, for these platform we can bypass
+ * aDSP and use as regular HDA controller or enable aDSP and use aDSP
+ * along with I2S codecs etc.
+ * hdac_adsp_enable would enable the aDSP based HDA controller if the
+ * platform supports it
+ */
+extern bool snd_adsp_enable;
+
 /* codec node id */
 typedef u16 hda_nid_t;
 
diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
index 89c2711baaaf..8fb4e8b1398e 100644
--- a/sound/hda/hda_bus_type.c
+++ b/sound/hda/hda_bus_type.c
@@ -10,6 +10,12 @@
 MODULE_DESCRIPTION("HD-audio bus");
 MODULE_LICENSE("GPL");
 
+bool snd_adsp_enable = false;
+EXPORT_SYMBOL_GPL(snd_adsp_enable);
+
+module_param(snd_adsp_enable, bool, 0444);
+MODULE_PARM_DESC(snd_adsp_enable, "HD-A aDSP enable configuration");
+
 /**
  * hdac_get_device_id - gets the hdac device id entry
  * @hdev: HD-audio core device
-- 
1.9.1
