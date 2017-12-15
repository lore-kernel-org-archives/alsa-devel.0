From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v3 07/11] ALSA: hda: split API snd_hda_codec_new
	for using it from ASoC codec drivers
Date: Fri, 15 Dec 2017 17:00:44 +0530
Message-ID: <1513337448-31685-8-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B4D9D267BCB
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:26:31 +0100 (CET)
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

Split snd_hda_codec_new API into two separate functions.
snd_hda_codec_device_init allocates memory and registers with bus.
snd_hda_codec_device_new initialializes the fields and performs
snd_device_new. This split would help in reusing the functions from
ASoC HDA codec drivers.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/pci/hda/hda_codec.c | 79 +++++++++++++++++++++++++++++++++++++----------
 sound/pci/hda/hda_codec.h |  4 ++-
 2 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 085fd9e..b77dcf2 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -857,25 +857,21 @@ static void snd_hda_codec_dev_release(struct device *dev)
 }
 
 /**
- * snd_hda_codec_new - create a HDA codec
+ * snd_hda_codec_device_init - allocate and register hdac device with bus
  * @bus: the bus to assign
  * @codec_addr: the codec address
  * @codecp: the pointer to store the generated codec
  *
  * Returns 0 if successful, or a negative error code.
  */
-int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
-		      unsigned int codec_addr, struct hda_codec **codecp)
+static int snd_hda_codec_device_init(struct hda_bus *bus, struct snd_card *card,
+			unsigned int codec_addr, struct hda_codec **codecp)
 {
-	struct hda_codec *codec;
-	char component[31];
-	hda_nid_t fg;
 	int err;
-	static struct snd_device_ops dev_ops = {
-		.dev_register = snd_hda_codec_dev_register,
-		.dev_disconnect = snd_hda_codec_dev_disconnect,
-		.dev_free = snd_hda_codec_dev_free,
-	};
+	char component[31];
+	struct hda_codec *codec;
+
+	dev_dbg(card->dev, "%s: entry\n", __func__);
 
 	if (snd_BUG_ON(!bus))
 		return -EINVAL;
@@ -888,14 +884,67 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 
 	sprintf(component, "hdaudioC%dD%d", card->number, codec_addr);
 	err = snd_hdac_device_init(&codec->core, &bus->core, component,
-				   codec_addr);
+					codec_addr);
 	if (err < 0) {
 		kfree(codec);
 		return err;
 	}
+	codec->core.type = HDA_DEV_LEGACY;
+
+	*codecp = codec;
+
+	return err;
+}
+
+/**
+ * snd_hda_codec_new - create a HDA codec
+ * @bus: the bus to assign
+ * @codec_addr: the codec address
+ * @codecp: the pointer to store the generated codec
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
+			unsigned int codec_addr, struct hda_codec **codecp)
+{
+	int ret;
+
+	ret = snd_hda_codec_device_init(bus, card, codec_addr, codecp);
+	if (ret < 0)
+		return ret;
+
+	return snd_hda_codec_device_new(bus, card, codec_addr, *codecp);
+}
+EXPORT_SYMBOL_GPL(snd_hda_codec_new);
+
+/**
+ * snd_hda_codec_device_new - add HDA codec into device list
+ * @bus: the bus to assign
+ * @codec_addr: the codec address
+ * @codec: the pointer to store the codec
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
+			unsigned int codec_addr, struct hda_codec *codec)
+{
+	char component[31];
+	hda_nid_t fg;
+	int err;
+	static struct snd_device_ops dev_ops = {
+		.dev_register = snd_hda_codec_dev_register,
+		.dev_disconnect = snd_hda_codec_dev_disconnect,
+		.dev_free = snd_hda_codec_dev_free,
+	};
+
+	dev_dbg(card->dev, "%s: entry\n", __func__);
+
+	if (snd_BUG_ON(!bus))
+		return -EINVAL;
+	if (snd_BUG_ON(codec_addr > HDA_MAX_CODEC_ADDRESS))
+		return -EINVAL;
 
 	codec->core.dev.release = snd_hda_codec_dev_release;
-	codec->core.type = HDA_DEV_LEGACY;
 	codec->core.exec_verb = codec_exec_verb;
 
 	codec->bus = bus;
@@ -955,15 +1004,13 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	if (err < 0)
 		goto error;
 
-	if (codecp)
-		*codecp = codec;
 	return 0;
 
  error:
 	put_device(hda_codec_dev(codec));
 	return err;
 }
-EXPORT_SYMBOL_GPL(snd_hda_codec_new);
+EXPORT_SYMBOL_GPL(snd_hda_codec_device_new);
 
 /**
  * snd_hda_codec_update_widgets - Refresh widget caps and pin defaults
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 1525c5a..33395b1 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -311,7 +311,9 @@ struct hda_codec {
  * constructors
  */
 int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
-		      unsigned int codec_addr, struct hda_codec **codecp);
+			unsigned int codec_addr, struct hda_codec **codecp);
+int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
+		      unsigned int codec_addr, struct hda_codec *codec);
 int snd_hda_codec_configure(struct hda_codec *codec);
 int snd_hda_codec_update_widgets(struct hda_codec *codec);
 
-- 
2.7.4
