From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 08/13] ALSA: hda: split snd_hda_codec_new
	function
Date: Fri,  1 Jun 2018 22:53:56 -0500
Message-ID: <20180602035401.26934-9-pierre-louis.bossart@linux.intel.com>
References: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 63D22267842
 for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2018 05:54:19 +0200 (CEST)
In-Reply-To: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>

Split snd_hda_codec_new into two separate functions.
snd_hda_codec_device_init allocates memory and registers with bus.
snd_hda_codec_device_new initialializes the fields and performs
snd_device_new. This enables reuse of legacy HDA codec drivers as ASoC
codec drivers.

In addition mark some functions with EXPORT_SYMBOL_GPL so that it can
be called by ASoC wrapper around the legacy HDA driver (hdac_hda).

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 68 +++++++++++++++++++++++++++++++++++------------
 sound/pci/hda/hda_codec.h |  2 ++
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5bc3a7468e17..76f4f097e83e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -856,6 +856,39 @@ static void snd_hda_codec_dev_release(struct device *dev)
 	kfree(codec);
 }
 
+#define DEV_NAME_LEN 31
+
+static int snd_hda_codec_device_init(struct hda_bus *bus, struct snd_card *card,
+			unsigned int codec_addr, struct hda_codec **codecp)
+{
+	char name[DEV_NAME_LEN];
+	struct hda_codec *codec;
+	int err;
+
+	dev_dbg(card->dev, "%s: entry\n", __func__);
+
+	if (snd_BUG_ON(!bus))
+		return -EINVAL;
+	if (snd_BUG_ON(codec_addr > HDA_MAX_CODEC_ADDRESS))
+		return -EINVAL;
+
+	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
+	if (!codec)
+		return -ENOMEM;
+
+	sprintf(name, "hdaudioC%dD%d", card->number, codec_addr);
+	err = snd_hdac_device_init(&codec->core, &bus->core, name, codec_addr);
+	if (err < 0) {
+		kfree(codec);
+		return err;
+	}
+
+	codec->core.type = HDA_DEV_LEGACY;
+	*codecp = codec;
+
+	return err;
+}
+
 /**
  * snd_hda_codec_new - create a HDA codec
  * @bus: the bus to assign
@@ -867,7 +900,19 @@ static void snd_hda_codec_dev_release(struct device *dev)
 int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		      unsigned int codec_addr, struct hda_codec **codecp)
 {
-	struct hda_codec *codec;
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
+int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
+			unsigned int codec_addr, struct hda_codec *codec)
+{
 	char component[31];
 	hda_nid_t fg;
 	int err;
@@ -877,25 +922,14 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		.dev_free = snd_hda_codec_dev_free,
 	};
 
+	dev_dbg(card->dev, "%s: entry\n", __func__);
+
 	if (snd_BUG_ON(!bus))
 		return -EINVAL;
 	if (snd_BUG_ON(codec_addr > HDA_MAX_CODEC_ADDRESS))
 		return -EINVAL;
 
-	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
-	if (!codec)
-		return -ENOMEM;
-
-	sprintf(component, "hdaudioC%dD%d", card->number, codec_addr);
-	err = snd_hdac_device_init(&codec->core, &bus->core, component,
-				   codec_addr);
-	if (err < 0) {
-		kfree(codec);
-		return err;
-	}
-
 	codec->core.dev.release = snd_hda_codec_dev_release;
-	codec->core.type = HDA_DEV_LEGACY;
 	codec->core.exec_verb = codec_exec_verb;
 
 	codec->bus = bus;
@@ -955,15 +989,13 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
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
@@ -2979,6 +3011,7 @@ int snd_hda_codec_build_controls(struct hda_codec *codec)
 	sync_power_up_states(codec);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_hda_codec_build_controls);
 
 /*
  * PCM stuff
@@ -3184,6 +3217,7 @@ int snd_hda_codec_parse_pcms(struct hda_codec *codec)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_hda_codec_parse_pcms);
 
 /* assign all PCMs of the given codec */
 int snd_hda_codec_build_pcms(struct hda_codec *codec)
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 681c360f29f9..8bbedf7f3f54 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -307,6 +307,8 @@ struct hda_codec {
  */
 int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		      unsigned int codec_addr, struct hda_codec **codecp);
+int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
+		      unsigned int codec_addr, struct hda_codec *codec);
 int snd_hda_codec_configure(struct hda_codec *codec);
 int snd_hda_codec_update_widgets(struct hda_codec *codec);
 
-- 
2.14.1
