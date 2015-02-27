From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ALSA: hda - Use regmap for codec parameter
	reads
Date: Fri, 27 Feb 2015 22:28:17 +0100
Message-ID: <1425072502-3204-3-git-send-email-tiwai@suse.de>
References: <1425072502-3204-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C08926519B
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:28:28 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5CF26ABF8
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

Let's start converting the access functions to regmap.
The first one is the simplest, just converting the codec parameter
read helper function snd_hda_param_read().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 18 ++++++++++++++++++
 sound/pci/hda/hda_codec.h |  3 +--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0fd71131193a..3a209e8b6130 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -34,6 +34,7 @@
 #include <sound/tlv.h>
 #include <sound/initval.h>
 #include <sound/jack.h>
+#include "hda_regmap.h"
 #include "hda_local.h"
 #include "hda_beep.h"
 #include "hda_jack.h"
@@ -255,6 +256,23 @@ void snd_hda_sequence_write(struct hda_codec *codec, const struct hda_verb *seq)
 EXPORT_SYMBOL_GPL(snd_hda_sequence_write);
 
 /**
+ * snd_hda_param_read - read a parameter
+ * @codec: the HDA codec
+ * @nid: NID to read
+ * @parm: parameter value
+ */
+int snd_hda_param_read(struct hda_codec *codec, hda_nid_t nid, int parm)
+{
+	unsigned int verb = (AC_VERB_PARAMETERS << 8) | (nid << 20) | parm;
+	unsigned int val;
+
+	if (snd_hda_reg_raw_read(codec, verb, &val) < 0)
+		return -1;
+	return val;
+}
+EXPORT_SYMBOL_GPL(snd_hda_param_read);
+
+/**
  * snd_hda_get_sub_nodes - get the range of sub nodes
  * @codec: the HDA codec
  * @nid: NID to parse
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 3be4e1040036..db310e9c53ff 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -439,8 +439,7 @@ unsigned int snd_hda_codec_read(struct hda_codec *codec, hda_nid_t nid,
 				unsigned int verb, unsigned int parm);
 int snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
 			unsigned int verb, unsigned int parm);
-#define snd_hda_param_read(codec, nid, param) \
-	snd_hda_codec_read(codec, nid, 0, AC_VERB_PARAMETERS, param)
+int snd_hda_param_read(struct hda_codec *codec, hda_nid_t nid, int parm);
 int snd_hda_get_sub_nodes(struct hda_codec *codec, hda_nid_t nid,
 			  hda_nid_t *start_id);
 int snd_hda_get_connections(struct hda_codec *codec, hda_nid_t nid,
-- 
2.3.0
