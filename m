From: mengdong.lin@intel.com
Subject: [PATCH v3 4/4] ALSA: hda - add device entry and
	inactive flag to unsolicited response
Date: Mon, 26 Aug 2013 21:35:49 -0400
Message-ID: <1377567349-1256-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 51B6526500A
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 10:35:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch adds two fields to unsolicited response, according to spec HDA040-A:
- Device Entry (bit 20:15)
- Inactive (bit 2)
and show the info in debug message.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index b838c70..7aa9870 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -255,6 +255,11 @@ enum {
 #define AC_UNSOL_RES_TAG_SHIFT		26
 #define AC_UNSOL_RES_SUBTAG		(0x1f<<21)
 #define AC_UNSOL_RES_SUBTAG_SHIFT	21
+#define AC_UNSOL_RES_DE			(0x3f<<15)  /* Device Entry
+						     * (for DP1.2 MST)
+						     */
+#define AC_UNSOL_RES_DE_SHIFT		15
+#define AC_UNSOL_RES_IA			(1<<2)	/* Inactive (for DP1.2 MST) */
 #define AC_UNSOL_RES_ELDV		(1<<1)	/* ELD Data valid (for HDMI) */
 #define AC_UNSOL_RES_PD			(1<<0)	/* pinsense detect */
 #define AC_UNSOL_RES_CP_STATE		(1<<1)	/* content protection */
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 87ca984..895a0d3 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -959,6 +959,7 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 	int pin_nid;
 	int pin_idx;
 	struct hda_jack_tbl *jack;
+	int dev_entry = (res & AC_UNSOL_RES_DE) >> AC_UNSOL_RES_DE_SHIFT;
 
 	jack = snd_hda_jack_tbl_get_from_tag(codec, tag);
 	if (!jack)
@@ -967,8 +968,8 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 	jack->jack_dirty = 1;
 
 	_snd_printd(SND_PR_VERBOSE,
-		"HDMI hot plug event: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
-		codec->addr, pin_nid,
+		"HDMI hot plug event: Codec=%d Pin=%d Device=%d Inactive=%d Presence_Detect=%d ELD_Valid=%d\n",
+		codec->addr, pin_nid, dev_entry, !!(res & AC_UNSOL_RES_IA),
 		!!(res & AC_UNSOL_RES_PD), !!(res & AC_UNSOL_RES_ELDV));
 
 	pin_idx = pin_nid_to_pin_index(spec, pin_nid);
-- 
1.8.1.2
