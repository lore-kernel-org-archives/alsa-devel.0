From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/5] ALSA: hdac: Add
	snd_hdac_ext_bus_link_power_down_all()
Date: Fri, 21 Aug 2015 21:36:18 +0530
Message-ID: <1440173181-3150-3-git-send-email-vinod.koul@intel.com>
References: <1440173181-3150-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E78372604EB
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 18:04:33 +0200 (CEST)
In-Reply-To: <1440173181-3150-1-git-send-email-vinod.koul@intel.com>
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

From: Jeeja KP <jeeja.kp@intel.com>

New HDA controllers like Skylake sport multiple HDA links, so we need a
helper to turn off all the links in one go while suspending the device so
add snd_hdac_ext_bus_link_power_down_all() API

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h         |  1 +
 sound/hda/ext/hdac_ext_controller.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 55e2fc36177f..160160d9bffc 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -116,6 +116,7 @@ struct hdac_ext_link {
 
 int snd_hdac_ext_bus_link_power_up(struct hdac_ext_link *link);
 int snd_hdac_ext_bus_link_power_down(struct hdac_ext_link *link);
+int snd_hdac_ext_bus_link_power_down_all(struct hdac_ext_bus *ebus);
 void snd_hdac_ext_link_set_stream_id(struct hdac_ext_link *link,
 				 int stream);
 void snd_hdac_ext_link_clear_stream_id(struct hdac_ext_link *link,
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index d3bb112754f2..63215b17247c 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -280,3 +280,23 @@ int snd_hdac_ext_bus_link_power_down(struct hdac_ext_link *link)
 	return check_hdac_link_power_active(link, false);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down);
+
+/**
+ * snd_hdac_ext_bus_link_power_down_all -power down all hda link
+ * @ebus: HD-audio extended bus
+ */
+int snd_hdac_ext_bus_link_power_down_all(struct hdac_ext_bus *ebus)
+{
+	struct hdac_ext_link *hlink = NULL;
+	int ret;
+
+	list_for_each_entry(hlink, &ebus->hlink_list, list) {
+		snd_hdac_updatel(hlink->ml_addr, AZX_REG_ML_LCTL, AZX_MLCTL_SPA, 0);
+		ret = check_hdac_link_power_active(hlink, false);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down_all);
-- 
1.9.1
