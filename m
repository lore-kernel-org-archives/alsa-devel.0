From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ALSA: hda - Allow driver to add
	vendor-specific verbs for regmap
Date: Fri, 27 Feb 2015 22:28:20 +0100
Message-ID: <1425072502-3204-6-git-send-email-tiwai@suse.de>
References: <1425072502-3204-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C713A26128B
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:28:27 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6BCA7AC70
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 21:28:27 +0000 (UTC)
In-Reply-To: <1425072502-3204-1-git-send-email-tiwai@suse.de>
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

Codecs may have own vendor-specific verbs, and we need to allow each
driver to give such verbs for cached accesses.  Here a verb can be put
into a single array and looked through it at readable and writeable
callbacks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.h  |  1 +
 sound/pci/hda/hda_regmap.c | 20 ++++++++++++++++++++
 sound/pci/hda/hda_regmap.h |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 953625c85ee4..8cf7b2870dd1 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -398,6 +398,7 @@ struct hda_codec {
 
 	/* regmap */
 	struct regmap *regmap;
+	struct snd_array vendor_verbs;
 	bool caps_overwriting; /* caps overwrite being in process */
 };
 
diff --git a/sound/pci/hda/hda_regmap.c b/sound/pci/hda/hda_regmap.c
index 8f12c23f3489..38934c06a813 100644
--- a/sound/pci/hda/hda_regmap.c
+++ b/sound/pci/hda/hda_regmap.c
@@ -35,10 +35,17 @@ static bool hda_writeable_reg(struct device *dev, unsigned int reg)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 	unsigned int verb = get_verb(reg);
+	int i;
 
 	if (codec->caps_overwriting)
 		return true;
 
+	for (i = 0; i < codec->vendor_verbs.used; i++) {
+		unsigned int *v = snd_array_elem(&codec->vendor_verbs, i);
+		if (verb == *v)
+			return true;
+	}
+
 	switch (verb & 0xf00) {
 	case AC_VERB_GET_STREAM_FORMAT:
 	case AC_VERB_GET_AMP_GAIN_MUTE:
@@ -178,6 +185,7 @@ int snd_hda_regmap_init(struct hda_codec *codec)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 	codec->regmap = regmap;
+	snd_array_init(&codec->vendor_verbs, sizeof(unsigned int), 8);
 	return 0;
 }
 
@@ -187,7 +195,19 @@ void snd_hda_regmap_exit(struct hda_codec *codec)
 		regmap_exit(codec->regmap);
 		codec->regmap = NULL;
 	}
+	snd_array_free(&codec->vendor_verbs);
+}
+
+int snd_hda_regmap_add_vendor_verb(struct hda_codec *codec, unsigned int verb)
+{
+	unsigned int *p = snd_array_new(&codec->vendor_verbs);
+
+	if (!p)
+		return -ENOMEM;
+	*p = verb;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_hda_regmap_add_vendor_verb);
 
 /*
  * helper functions
diff --git a/sound/pci/hda/hda_regmap.h b/sound/pci/hda/hda_regmap.h
index 7d4b8be58975..562c58c4cbc1 100644
--- a/sound/pci/hda/hda_regmap.h
+++ b/sound/pci/hda/hda_regmap.h
@@ -13,6 +13,8 @@
 int snd_hda_regmap_init(struct hda_codec *codec);
 void snd_hda_regmap_exit(struct hda_codec *codec);
 
+int snd_hda_regmap_add_vendor_verb(struct hda_codec *codec, unsigned int verb);
+
 int snd_hda_regmap_write(struct hda_codec *codec, hda_nid_t nid,
 			 unsigned int verb, unsigned int val);
 int snd_hda_regmap_update_bits(struct hda_codec *codec, hda_nid_t nid,
-- 
2.3.0
