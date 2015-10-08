From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ALSA: hda: make use of core codec fns
Date: Thu,  8 Oct 2015 09:48:06 +0100
Message-ID: <1444294086-27031-2-git-send-email-vinod.koul@intel.com>
References: <1444294086-27031-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 158A8261B1E
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 10:48:20 +0200 (CEST)
In-Reply-To: <1444294086-27031-1-git-send-email-vinod.koul@intel.com>
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

Now that we have introduced the core fns we should make hda use these
helpers

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_codec.c | 44 --------------------------------------------
 sound/pci/hda/hda_codec.h | 18 ++++++++++++++----
 sound/pci/hda/hda_local.h |  7 +------
 3 files changed, 15 insertions(+), 54 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 37f43a1b34ef..2eeaf5ea20f9 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -91,50 +91,6 @@ static int codec_exec_verb(struct hdac_device *dev, unsigned int cmd,
 }
 
 /**
- * snd_hda_codec_read - send a command and get the response
- * @codec: the HDA codec
- * @nid: NID to send the command
- * @flags: optional bit flags
- * @verb: the verb to send
- * @parm: the parameter for the verb
- *
- * Send a single command and read the corresponding response.
- *
- * Returns the obtained response value, or -1 for an error.
- */
-unsigned int snd_hda_codec_read(struct hda_codec *codec, hda_nid_t nid,
-				int flags,
-				unsigned int verb, unsigned int parm)
-{
-	unsigned int cmd = snd_hdac_make_cmd(&codec->core, nid, verb, parm);
-	unsigned int res;
-	if (snd_hdac_exec_verb(&codec->core, cmd, flags, &res))
-		return -1;
-	return res;
-}
-EXPORT_SYMBOL_GPL(snd_hda_codec_read);
-
-/**
- * snd_hda_codec_write - send a single command without waiting for response
- * @codec: the HDA codec
- * @nid: NID to send the command
- * @flags: optional bit flags
- * @verb: the verb to send
- * @parm: the parameter for the verb
- *
- * Send a single command without waiting for response.
- *
- * Returns 0 if successful, or a negative error code.
- */
-int snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
-			unsigned int verb, unsigned int parm)
-{
-	unsigned int cmd = snd_hdac_make_cmd(&codec->core, nid, verb, parm);
-	return snd_hdac_exec_verb(&codec->core, cmd, flags, NULL);
-}
-EXPORT_SYMBOL_GPL(snd_hda_codec_write);
-
-/**
  * snd_hda_sequence_write - sequence writes
  * @codec: the HDA codec
  * @seq: VERB array to send
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 2970413f18a0..95991e463abb 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -309,11 +309,21 @@ int snd_hda_codec_update_widgets(struct hda_codec *codec);
 /*
  * low level functions
  */
-unsigned int snd_hda_codec_read(struct hda_codec *codec, hda_nid_t nid,
+static inline unsigned int
+snd_hda_codec_read(struct hda_codec *codec, hda_nid_t nid,
 				int flags,
-				unsigned int verb, unsigned int parm);
-int snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
-			unsigned int verb, unsigned int parm);
+				unsigned int verb, unsigned int parm)
+{
+	return snd_hdac_codec_read(&codec->core, nid, flags, verb, parm);
+}
+
+static inline int
+snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
+			unsigned int verb, unsigned int parm)
+{
+	return snd_hdac_codec_write(&codec->core, nid, flags, verb, parm);
+}
+
 #define snd_hda_param_read(codec, nid, param) \
 	snd_hdac_read_parm(&(codec)->core, nid, param)
 #define snd_hda_get_sub_nodes(codec, nid, start_nid) \
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 4a21c2199e02..d0e066e4c985 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -681,12 +681,7 @@ static inline bool
 snd_hda_check_power_state(struct hda_codec *codec, hda_nid_t nid,
 			  unsigned int target_state)
 {
-	unsigned int state = snd_hda_codec_read(codec, nid, 0,
-						AC_VERB_GET_POWER_STATE, 0);
-	if (state & AC_PWRST_ERROR)
-		return true;
-	state = (state >> 4) & 0x0f;
-	return (state == target_state);
+	return snd_hdac_check_power_state(&codec->core, nid, target_state);
 }
 
 unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
-- 
2.4.3
