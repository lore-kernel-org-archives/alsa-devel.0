From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 07/14] ALSA: hdac: add
	snd_hdac_ext_bus_link_power_up_all
Date: Fri, 11 Dec 2015 12:14:20 +0530
Message-ID: <1449816267-11910-8-git-send-email-vinod.koul@intel.com>
References: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BFD7D265D91
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 07:41:44 +0100 (CET)
In-Reply-To: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Jayachandran B <jayachandran.b@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

We have an API for powering down all links, we need a similar one
for powering up links, so add for power up as well

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h         |  1 +
 sound/hda/ext/hdac_ext_controller.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 65961bbb8ca3..68538fe94c77 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -147,6 +147,7 @@ struct hdac_ext_link {
 
 int snd_hdac_ext_bus_link_power_up(struct hdac_ext_link *link);
 int snd_hdac_ext_bus_link_power_down(struct hdac_ext_link *link);
+int snd_hdac_ext_bus_link_power_up_all(struct hdac_ext_bus *ebus);
 int snd_hdac_ext_bus_link_power_down_all(struct hdac_ext_bus *ebus);
 void snd_hdac_ext_link_set_stream_id(struct hdac_ext_link *link,
 				 int stream);
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 2524b3baa029..2b8e7ebcd00c 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -289,6 +289,27 @@ int snd_hdac_ext_bus_link_power_down(struct hdac_ext_link *link)
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down);
 
 /**
+ * snd_hdac_ext_bus_link_power_up_all -power up all hda link
+ * @ebus: HD-audio extended bus
+ */
+int snd_hdac_ext_bus_link_power_up_all(struct hdac_ext_bus *ebus)
+{
+	struct hdac_ext_link *hlink = NULL;
+	int ret;
+
+	list_for_each_entry(hlink, &ebus->hlink_list, list) {
+		snd_hdac_updatel(hlink->ml_addr,
+				AZX_REG_ML_LCTL, 0, AZX_MLCTL_SPA);
+		ret = check_hdac_link_power_active(hlink, true);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_up_all);
+
+/**
  * snd_hdac_ext_bus_link_power_down_all -power down all hda link
  * @ebus: HD-audio extended bus
  */
-- 
1.9.1
