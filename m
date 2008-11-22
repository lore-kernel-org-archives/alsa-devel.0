From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 3/7] hda - make HDMI messages more user friendly
Date: Sat, 22 Nov 2008 09:40:53 +0800
Message-ID: <20081122014309.049805587@linux.intel.com>
References: <20081122014050.348491872@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id DADBA103839
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 04:09:03 +0100 (CET)
Content-Disposition: inline; filename=alsa-user-friendly-print.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

- make some messages more user friendly
- add message prefix "HDMI:" to indicate the problem's domain
  (also easier to do `dmesg | grep HDMI` ;-)

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c         |   30 +++++++++++++++-------------
 sound/pci/hda/patch_intelhdmi.c |   32 +++++++++++++++---------------
 2 files changed, 32 insertions(+), 30 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -168,11 +168,11 @@ static unsigned char hdmi_get_eld_byte(s
 					AC_VERB_GET_HDMI_ELDD, byte_index);
 
 #ifdef BE_PARANOID
-	printk(KERN_INFO "ELD data byte %d: 0x%x\n", byte_index, val);
+	printk(KERN_INFO "HDMI: ELD data byte %d: 0x%x\n", byte_index, val);
 #endif
 
 	if ((val & AC_ELDD_ELD_VALID) == 0) {
-		snd_printd(KERN_INFO "Invalid ELD data byte %d\n",
+		snd_printd(KERN_INFO "HDMI: invalid ELD data byte %d\n",
 								byte_index);
 		val = 0;
 	}
@@ -208,7 +208,7 @@ static void hdmi_update_short_audio_desc
 	switch (a->format) {
 	case AUDIO_CODING_TYPE_REF_STREAM_HEADER:
 		snd_printd(KERN_INFO
-				"audio coding type 0 not expected in ELD\n");
+				"HDMI: audio coding type 0 not expected\n");
 		break;
 
 	case AUDIO_CODING_TYPE_LPCM:
@@ -254,7 +254,7 @@ static void hdmi_update_short_audio_desc
 		if (a->format == AUDIO_CODING_XTYPE_HE_REF_CT ||
 		    a->format >= AUDIO_CODING_XTYPE_FIRST_RESERVED) {
 			snd_printd(KERN_INFO
-				"audio coding xtype %d not expected in ELD\n",
+				"HDMI: audio coding xtype %d not expected\n",
 				a->format);
 			a->format = 0;
 		} else
@@ -276,7 +276,8 @@ static int hdmi_update_eld(struct hdmi_e
 	e->eld_ver = GRAB_BITS(buf, 0, 3, 5);
 	if (e->eld_ver != ELD_VER_CEA_861D &&
 	    e->eld_ver != ELD_VER_PARTIAL) {
-		snd_printd(KERN_INFO "Unknown ELD version %d\n", e->eld_ver);
+		snd_printd(KERN_INFO "HDMI: Unknown ELD version %d\n",
+								e->eld_ver);
 		goto out_fail;
 	}
 
@@ -300,17 +301,17 @@ static int hdmi_update_eld(struct hdmi_e
 	e->product_id	  = get_unaligned_le16(buf + 18);
 
 	if (mnl > ELD_MAX_MNL) {
-		snd_printd(KERN_INFO "MNL is reserved value %d\n", mnl);
+		snd_printd(KERN_INFO "HDMI: MNL is reserved value %d\n", mnl);
 		goto out_fail;
 	} else if (ELD_FIXED_BYTES + mnl > size) {
-		snd_printd(KERN_INFO "out of range MNL %d\n", mnl);
+		snd_printd(KERN_INFO "HDMI: out of range MNL %d\n", mnl);
 		goto out_fail;
 	} else
 		strlcpy(e->monitor_name, buf + ELD_FIXED_BYTES, mnl);
 
 	for (i = 0; i < e->sad_count; i++) {
 		if (ELD_FIXED_BYTES + mnl + 3 * (i + 1) > size) {
-			snd_printd(KERN_INFO "out of range SAD %d\n", i);
+			snd_printd(KERN_INFO "HDMI: out of range SAD %d\n", i);
 			goto out_fail;
 		}
 		hdmi_update_short_audio_desc(e->sad + i,
@@ -339,7 +340,8 @@ static int hdmi_eld_valid(struct hda_cod
 	present = (present & AC_PINSENSE_PRESENCE);
 
 #ifdef CONFIG_SND_DEBUG_VERBOSE
-	printk(KERN_INFO "pinp = %d, eldv = %d\n", !!present, !!eldv);
+	printk(KERN_INFO "HDMI: sink_present = %d, eld_valid = %d\n",
+			!!present, !!eldv);
 #endif
 
 	return eldv && present;
@@ -365,11 +367,11 @@ int snd_hdmi_get_eld(struct hdmi_eld *el
 	size = snd_hdmi_get_eld_size(codec, nid);
 	if (size == 0) {
 		/* wfg: workaround for ASUS P5E-VM HDMI board */
-		snd_printd(KERN_INFO "ELD buf size is 0, force 128\n");
+		snd_printd(KERN_INFO "HDMI: ELD buf size is 0, force 128\n");
 		size = 128;
 	}
 	if (size < ELD_FIXED_BYTES || size > PAGE_SIZE) {
-		snd_printd(KERN_INFO "Invalid ELD buf size %d\n", size);
+		snd_printd(KERN_INFO "HDMI: invalid ELD buf size %d\n", size);
 		return -ERANGE;
 	}
 
@@ -404,7 +406,7 @@ static void hdmi_show_short_audio_desc(s
 	else
 		buf2[0] = '\0';
 
-	printk(KERN_INFO "supports coding type %s:"
+	printk(KERN_INFO "HDMI: supports coding type %s:"
 			" channels = %d, rates =%s%s\n",
 			cea_audio_coding_type_names[a->format],
 			a->channels,
@@ -428,14 +430,14 @@ void snd_hdmi_show_eld(struct hdmi_eld *
 {
 	int i;
 
-	printk(KERN_INFO "detected monitor %s at connection type %s\n",
+	printk(KERN_INFO "HDMI: detected monitor %s at connection type %s\n",
 			e->monitor_name,
 			eld_connection_type_names[e->conn_type]);
 
 	if (e->spk_alloc) {
 		char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 		snd_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
-		printk(KERN_INFO "available speakers:%s\n", buf);
+		printk(KERN_INFO "HDMI: available speakers:%s\n", buf);
 	}
 
 	for (i = 0; i < e->sad_count; i++)
--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -286,7 +286,7 @@ static void hdmi_set_channel_count(struc
 					AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
 
 	if (chs != hdmi_get_channel_count(codec))
-		snd_printd(KERN_INFO "Channel count expect=%d, real=%d\n",
+		snd_printd(KERN_INFO "HDMI channel count: expect %d, get %d\n",
 					chs, hdmi_get_channel_count(codec));
 }
 
@@ -299,7 +299,7 @@ static void hdmi_debug_channel_mapping(s
 	for (i = 0; i < 8; i++) {
 		slot = snd_hda_codec_read(codec, CVT_NID, 0,
 						AC_VERB_GET_HDMI_CHAN_SLOT, i);
-		printk(KERN_DEBUG "ASP channel %d => slot %d\n",
+		printk(KERN_DEBUG "HDMI: ASP channel %d => slot %d\n",
 						slot >> 4, slot & 0x7);
 	}
 #endif
@@ -326,12 +326,12 @@ static void hdmi_debug_dip_size(struct h
 	int size;
 
 	size = snd_hdmi_get_eld_size(codec, PIN_NID);
-	printk(KERN_DEBUG "ELD buf size is %d\n", size);
+	printk(KERN_DEBUG "HDMI: ELD buf size is %d\n", size);
 
 	for (i = 0; i < 8; i++) {
 		size = snd_hda_codec_read(codec, PIN_NID, 0,
 						AC_VERB_GET_HDMI_DIP_SIZE, i);
-		printk(KERN_DEBUG "DIP GP[%d] buf size is %d\n", i, size);
+		printk(KERN_DEBUG "HDMI: DIP GP[%d] buf size is %d\n", i, size);
 	}
 #endif
 }
@@ -359,8 +359,8 @@ static void hdmi_clear_dip_buffers(struc
 				break;
 		}
 		snd_printd(KERN_INFO
-				"DIP GP[%d] buf reported size=%d, written=%d\n",
-				i, size, j);
+			"HDMI: DIP GP[%d] buf reported size=%d, written=%d\n",
+			i, size, j);
 	}
 #endif
 }
@@ -498,7 +498,9 @@ static void hdmi_intrinsic_event(struct 
 	int pind = !!(res & AC_UNSOL_RES_PD);
 	int eldv = !!(res & AC_UNSOL_RES_ELDV);
 
-	printk(KERN_INFO "HDMI intrinsic event: PD=%d ELDV=%d\n", pind, eldv);
+	printk(KERN_INFO
+		"HDMI hot plug event: Presence_Detect=%d ELD_Valid=%d\n",
+		pind, eldv);
 
 	if (pind && eldv) {
 		hdmi_parse_eld(codec);
@@ -512,13 +514,13 @@ static void hdmi_non_intrinsic_event(str
 	int cp_state = !!(res & AC_UNSOL_RES_CP_STATE);
 	int cp_ready = !!(res & AC_UNSOL_RES_CP_READY);
 
-	printk(KERN_INFO "HDMI non-intrinsic event: "
-			"SUBTAG=0x%x CP_STATE=%d CP_READY=%d\n",
-			subtag,
-			cp_state,
-			cp_ready);
+	printk(KERN_INFO
+		"HDMI content protection event: SUBTAG=0x%x CP_STATE=%d CP_READY=%d\n",
+		subtag,
+		cp_state,
+		cp_ready);
 
-	/* who cares? */
+	/* TODO */
 	if (cp_state)
 		;
 	if (cp_ready)
@@ -532,9 +534,7 @@ static void intel_hdmi_unsol_event(struc
 	int subtag = (res & AC_UNSOL_RES_SUBTAG) >> AC_UNSOL_RES_SUBTAG_SHIFT;
 
 	if (tag != INTEL_HDMI_EVENT_TAG) {
-		snd_printd(KERN_INFO
-				"Unexpected HDMI unsolicited event tag 0x%x\n",
-				tag);
+		snd_printd(KERN_INFO "Unexpected HDMI event tag 0x%x\n", tag);
 		return;
 	}
 

-- 
