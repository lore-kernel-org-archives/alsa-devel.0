From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 4/5] ALSA: hda - move dsp lock to hdac
Date: Wed,  1 Apr 2015 17:01:01 +0530
Message-ID: <1427887862-29054-5-git-send-email-vinod.koul@intel.com>
References: <1427887862-29054-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id DC63126527E
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 13:35:39 +0200 (CEST)
In-Reply-To: <1427887862-29054-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

DSP lock will be used by DSP code loader in hdac as well

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h        |   17 +++++++++++++++++
 sound/pci/hda/hda_controller.c |   13 -------------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 647d5ef44222..df4033fc864d 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -15,6 +15,19 @@
 
 #define HDA_MAX_CODECS		8
 
+/* DSP lock helpers */
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+#define dsp_lock_init(dev)	mutex_init(&(dev)->dsp_mutex)
+#define dsp_lock(dev)		mutex_lock(&(dev)->dsp_mutex)
+#define dsp_unlock(dev)		mutex_unlock(&(dev)->dsp_mutex)
+#define dsp_is_locked(dev)	((dev)->locked)
+#else
+#define dsp_lock_init(dev)	do {} while (0)
+#define dsp_lock(dev)		do {} while (0)
+#define dsp_unlock(dev)		do {} while (0)
+#define dsp_is_locked(dev)	0
+#endif
+
 /* codec node id */
 typedef u16 hda_nid_t;
 
@@ -283,6 +296,7 @@ struct hdac_stream {
 	unsigned int opened:1;
 	unsigned int running:1;
 	unsigned int no_period_wakeup:1;
+	unsigned int locked:1;
 
 	/* timestamp */
 	unsigned long start_wallclk;	/* start + minimum wallclk */
@@ -292,6 +306,9 @@ struct hdac_stream {
 	int delay_negative_threshold;
 
 	struct list_head list;
+
+	/* DSP mutex */
+	struct mutex dsp_mutex;
 };
 
 void snd_hdac_bus_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index abb3822f5488..318635184edd 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -34,19 +34,6 @@
 #define CREATE_TRACE_POINTS
 #include "hda_intel_trace.h"
 
-/* DSP lock helpers */
-#ifdef CONFIG_SND_HDA_DSP_LOADER
-#define dsp_lock_init(dev)	mutex_init(&(dev)->dsp_mutex)
-#define dsp_lock(dev)		mutex_lock(&(dev)->dsp_mutex)
-#define dsp_unlock(dev)		mutex_unlock(&(dev)->dsp_mutex)
-#define dsp_is_locked(dev)	((dev)->locked)
-#else
-#define dsp_lock_init(dev)	do {} while (0)
-#define dsp_lock(dev)		do {} while (0)
-#define dsp_unlock(dev)		do {} while (0)
-#define dsp_is_locked(dev)	0
-#endif
-
 /*
  * AZX stream operations.
  */
-- 
1.7.9.5
