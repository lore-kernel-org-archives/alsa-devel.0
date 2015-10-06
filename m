From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 18/18] ALSA: hda: remove the old helpers
Date: Tue,  6 Oct 2015 16:07:55 +0100
Message-ID: <1444144075-28963-19-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 57F762658A7
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:09:59 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
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

Now that all the users are converted to use new hdac helpers,
remove the old APIs

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_codec.c | 43 -------------------------------------------
 sound/pci/hda/hda_codec.h |  5 -----
 sound/pci/hda/hda_local.h | 13 -------------
 3 files changed, 61 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index c551dda68803..8d8dfc42dfcf 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -90,49 +90,6 @@ static int codec_exec_verb(struct hdac_device *dev, unsigned int cmd,
 	return err;
 }
 
-/**
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
 
 /**
  * snd_hda_sequence_write - sequence writes
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 2970413f18a0..cf0261c2d40c 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -309,11 +309,6 @@ int snd_hda_codec_update_widgets(struct hda_codec *codec);
 /*
  * low level functions
  */
-unsigned int snd_hda_codec_read(struct hda_codec *codec, hda_nid_t nid,
-				int flags,
-				unsigned int verb, unsigned int parm);
-int snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
-			unsigned int verb, unsigned int parm);
 #define snd_hda_param_read(codec, nid, param) \
 	snd_hdac_read_parm(&(codec)->core, nid, param)
 #define snd_hda_get_sub_nodes(codec, nid, start_nid) \
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 4a21c2199e02..82ce77445cfa 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -676,19 +676,6 @@ int snd_hda_check_amp_list_power(struct hda_codec *codec,
 				 struct hda_loopback_check *check,
 				 hda_nid_t nid);
 
-/* check whether the actual power state matches with the target state */
-static inline bool
-snd_hda_check_power_state(struct hda_codec *codec, hda_nid_t nid,
-			  unsigned int target_state)
-{
-	unsigned int state = snd_hda_codec_read(codec, nid, 0,
-						AC_VERB_GET_POWER_STATE, 0);
-	if (state & AC_PWRST_ERROR)
-		return true;
-	state = (state >> 4) & 0x0f;
-	return (state == target_state);
-}
-
 unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
 					     hda_nid_t nid,
 					     unsigned int power_state);
-- 
2.4.3
