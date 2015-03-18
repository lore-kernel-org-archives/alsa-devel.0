From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ALSA: hda - Support indirect execution of
	verbs
Date: Wed, 18 Mar 2015 16:16:35 +0100
Message-ID: <1426691797-17178-6-git-send-email-tiwai@suse.de>
References: <1426691797-17178-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D8D9E2650FF
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 16:16:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BC04AAD9C
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 15:16:40 +0000 (UTC)
In-Reply-To: <1426691797-17178-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Add an overriding exec_verb op to struct hdac_device so that the call
via snd_hdac_exec_verb() can switch to a different route depending on
the setup.  The codec driver sets this field so that it can handle the
errors or applying quirks appropriately.  Furthermore, this mechanism
will be used for smooth transition for the regmap support in later
patches.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h   |  6 ++++++
 sound/hda/hdac_device.c   | 24 +++++++++++++++++++++++-
 sound/pci/hda/hda_codec.c | 12 +++++++-----
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 6ed2b421e29e..675614dc2b88 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -48,6 +48,10 @@ struct hdac_device {
 	const char *vendor_name;	/* codec vendor name */
 	const char *chip_name;		/* codec chip name */
 
+	/* verb exec op override */
+	int (*exec_verb)(struct hdac_device *dev, unsigned int cmd,
+			 unsigned int flags, unsigned int *res);
+
 	/* widgets */
 	unsigned int num_nodes;
 	hda_nid_t start_nid, end_nid;
@@ -82,6 +86,8 @@ int snd_hdac_refresh_widgets(struct hdac_device *codec);
 
 unsigned int snd_hdac_make_cmd(struct hdac_device *codec, hda_nid_t nid,
 			       unsigned int verb, unsigned int parm);
+int snd_hdac_exec_verb(struct hdac_device *codec, unsigned int cmd,
+		       unsigned int flags, unsigned int *res);
 int snd_hdac_read(struct hdac_device *codec, hda_nid_t nid,
 		  unsigned int verb, unsigned int parm, unsigned int *res);
 int snd_hdac_read_parm(struct hdac_device *codec, hda_nid_t nid, int parm);
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 1470ecc354db..aaece36247e7 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -194,6 +194,28 @@ unsigned int snd_hdac_make_cmd(struct hdac_device *codec, hda_nid_t nid,
 EXPORT_SYMBOL_GPL(snd_hdac_make_cmd);
 
 /**
+ * snd_hdac_exec_verb - execute an encoded verb
+ * @codec: the codec object
+ * @cmd: encoded verb to execute
+ * @flags: optional flags, pass zero for default
+ * @res: the pointer to store the result, NULL if running async
+ *
+ * Returns zero if successful, or a negative error code.
+ *
+ * This calls the exec_verb op when set in hdac_codec.  If not,
+ * call the default snd_hdac_bus_exec_verb().
+ */
+int snd_hdac_exec_verb(struct hdac_device *codec, unsigned int cmd,
+		       unsigned int flags, unsigned int *res)
+{
+	if (codec->exec_verb)
+		return codec->exec_verb(codec, cmd, flags, res);
+	return snd_hdac_bus_exec_verb(codec->bus, codec->addr, cmd, res);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_exec_verb);
+
+
+/**
  * snd_hdac_read - execute a verb
  * @codec: the codec object
  * @nid: NID to execute a verb
@@ -208,7 +230,7 @@ int snd_hdac_read(struct hdac_device *codec, hda_nid_t nid,
 {
 	unsigned int cmd = snd_hdac_make_cmd(codec, nid, verb, parm);
 
-	return snd_hdac_bus_exec_verb(codec->bus, codec->addr, cmd, res);
+	return snd_hdac_exec_verb(codec, cmd, 0, res);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_read);
 
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b162fc40348f..36483f7dd3ce 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -124,11 +124,12 @@ const char *snd_hda_get_jack_type(u32 cfg)
 EXPORT_SYMBOL_GPL(snd_hda_get_jack_type);
 
 /*
- * Send and receive a verb
+ * Send and receive a verb - passed to exec_verb override for hdac_device
  */
-static int codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
-			   int flags, unsigned int *res)
+static int codec_exec_verb(struct hdac_device *dev, unsigned int cmd,
+			   unsigned int flags, unsigned int *res)
 {
+	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
 	struct hda_bus *bus = codec->bus;
 	int err;
 
@@ -177,7 +178,7 @@ unsigned int snd_hda_codec_read(struct hda_codec *codec, hda_nid_t nid,
 {
 	unsigned int cmd = snd_hdac_make_cmd(&codec->core, nid, verb, parm);
 	unsigned int res;
-	if (codec_exec_verb(codec, cmd, flags, &res))
+	if (snd_hdac_exec_verb(&codec->core, cmd, flags, &res))
 		return -1;
 	return res;
 }
@@ -199,7 +200,7 @@ int snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
 			unsigned int verb, unsigned int parm)
 {
 	unsigned int cmd = snd_hdac_make_cmd(&codec->core, nid, verb, parm);
-	return codec_exec_verb(codec, cmd, flags, NULL);
+	return snd_hdac_exec_verb(&codec->core, cmd, flags, NULL);
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_write);
 
@@ -1026,6 +1027,7 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 
 	codec->core.dev.release = snd_hda_codec_dev_release;
 	codec->core.type = HDA_DEV_LEGACY;
+	codec->core.exec_verb = codec_exec_verb;
 
 	codec->bus = bus;
 	codec->card = card;
-- 
2.3.3
