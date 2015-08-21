From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/4] ALSA: hdac: add
	snd_hdac_refresh_widget_sysfs()
Date: Fri, 21 Aug 2015 15:47:43 +0530
Message-ID: <1440152263-24156-5-git-send-email-vinod.koul@intel.com>
References: <1440152263-24156-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 478FD2604E4
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 12:15:44 +0200 (CEST)
In-Reply-To: <1440152263-24156-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Some codecs like Intel HDMI by default do not show up all the pins, they
have to be manually enabled, so we need to refresh the codec widgets and
then recreate the sysfs tree. So add new API snd_hdac_refresh_widget_sysfs()
to do this. It should be be used by codec driver after sending magic verbs
to codec

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h |  1 +
 sound/hda/hdac_device.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 4caf1fde8a4f..e37c3355ae8a 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -119,6 +119,7 @@ int snd_hdac_device_register(struct hdac_device *codec);
 void snd_hdac_device_unregister(struct hdac_device *codec);
 
 int snd_hdac_refresh_widgets(struct hdac_device *codec);
+int snd_hdac_refresh_widget_sysfs(struct hdac_device *codec);
 
 unsigned int snd_hdac_make_cmd(struct hdac_device *codec, hda_nid_t nid,
 			       unsigned int verb, unsigned int parm);
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index cdee7103f649..8abba3f85784 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -372,6 +372,34 @@ int snd_hdac_refresh_widgets(struct hdac_device *codec)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_refresh_widgets);
 
+/**
+ * snd_hdac_refresh_widget_sysfs - Reset the codec widgets and reinit the
+ * codec sysfs
+ * @codec: the codec object
+ *
+ * first we need to remove sysfs, then refresh widgets and lastly
+ * recreate it
+ */
+int snd_hdac_refresh_widget_sysfs(struct hdac_device *codec)
+{
+	int ret;
+
+	hda_widget_sysfs_exit(codec);
+	ret = snd_hdac_refresh_widgets(codec);
+	if (ret) {
+		 dev_err(&codec->dev, "failed to refresh widget: %d\n", ret);
+		 return ret;
+	}
+	ret = hda_widget_sysfs_init(codec);
+	if (ret) {
+		 dev_err(&codec->dev, "failed to init sysfs: %d\n", ret);
+		 return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_refresh_widget_sysfs);
+
 /* return CONNLIST_LEN parameter of the given widget */
 static unsigned int get_num_conns(struct hdac_device *codec, hda_nid_t nid)
 {
-- 
1.9.1
