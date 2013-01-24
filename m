From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/13] ALSA: hda - Add power state filtering
Date: Thu, 24 Jan 2013 18:37:58 +0100
Message-ID: <1359049082-5880-10-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 891832616DD
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id EDFE7A51B8
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:14 +0100 (CET)
In-Reply-To: <1359049082-5880-1-git-send-email-tiwai@suse.de>
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

Add a hook to struct hda_codec for filtering the target power state of
each widget when powering up/down.  The current hackish EAPD check is
implemented as the default hook pointer, too.

This allows codec drivers to implement own power filter.  In the
upcoming changes, the generic parser will have the better power filter
based on the active paths.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 39 +++++++++++++++++++++++++--------------
 sound/pci/hda/hda_codec.h      |  7 +++++--
 sound/pci/hda/patch_conexant.c |  2 +-
 sound/pci/hda/patch_sigmatel.c |  2 +-
 4 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e4e0501..19ff923 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1276,6 +1276,8 @@ static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec,
 
 static unsigned int hda_set_power_state(struct hda_codec *codec,
 				unsigned int power_state);
+static unsigned int default_power_filter(struct hda_codec *codec, hda_nid_t nid,
+					 unsigned int power_state);
 
 /**
  * snd_hda_codec_new - create a HDA codec
@@ -1396,6 +1398,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 #endif
 	codec->epss = snd_hda_codec_get_supported_ps(codec, fg,
 					AC_PWRST_EPSS);
+	codec->power_filter = default_power_filter;
 
 	/* power-up all before initialization */
 	hda_set_power_state(codec, AC_PWRST_D0);
@@ -3649,29 +3652,23 @@ void snd_hda_codec_flush_cache(struct hda_codec *codec)
 EXPORT_SYMBOL_HDA(snd_hda_codec_flush_cache);
 
 void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
-				    unsigned int power_state,
-				    bool eapd_workaround)
+				    unsigned int power_state)
 {
 	hda_nid_t nid = codec->start_nid;
 	int i;
 
 	for (i = 0; i < codec->num_nodes; i++, nid++) {
 		unsigned int wcaps = get_wcaps(codec, nid);
+		unsigned int state = power_state;
 		if (!(wcaps & AC_WCAP_POWER))
 			continue;
-		/* don't power down the widget if it controls eapd and
-		 * EAPD_BTLENABLE is set.
-		 */
-		if (eapd_workaround && power_state == AC_PWRST_D3 &&
-		    get_wcaps_type(wcaps) == AC_WID_PIN &&
-		    (snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_EAPD)) {
-			int eapd = snd_hda_codec_read(codec, nid, 0,
-						AC_VERB_GET_EAPD_BTLENABLE, 0);
-			if (eapd & 0x02)
+		if (codec->power_filter) {
+			state = codec->power_filter(codec, nid, power_state);
+			if (state != power_state && power_state == AC_PWRST_D3)
 				continue;
 		}
 		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE,
-				    power_state);
+				    state);
 	}
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_set_power_to_all);
@@ -3718,6 +3715,21 @@ static unsigned int hda_sync_power_state(struct hda_codec *codec,
 	return state;
 }
 
+/* don't power down the widget if it controls eapd and EAPD_BTLENABLE is set */
+static unsigned int default_power_filter(struct hda_codec *codec, hda_nid_t nid,
+					 unsigned int power_state)
+{
+	if (power_state == AC_PWRST_D3 &&
+	    get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_PIN &&
+	    (snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_EAPD)) {
+		int eapd = snd_hda_codec_read(codec, nid, 0,
+					      AC_VERB_GET_EAPD_BTLENABLE, 0);
+		if (eapd & 0x02)
+			return AC_PWRST_D0;
+	}
+	return power_state;
+}
+
 /*
  * set power state of the codec, and return the power state
  */
@@ -3743,8 +3755,7 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 			snd_hda_codec_read(codec, fg, 0,
 					   AC_VERB_SET_POWER_STATE,
 					   power_state);
-			snd_hda_codec_set_power_to_all(codec, fg, power_state,
-						       true);
+			snd_hda_codec_set_power_to_all(codec, fg, power_state);
 		}
 		state = hda_sync_power_state(codec, fg, power_state);
 		if (!(state & AC_PWRST_ERROR))
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index cc73287..fbedcf3 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -886,6 +886,10 @@ struct hda_codec {
 	spinlock_t power_lock;
 #endif
 
+	/* filter the requested power state per nid */
+	unsigned int (*power_filter)(struct hda_codec *codec, hda_nid_t nid,
+				     unsigned int power_state);
+
 	/* codec-specific additional proc output */
 	void (*proc_widget_hook)(struct snd_info_buffer *buffer,
 				 struct hda_codec *codec, hda_nid_t nid);
@@ -1047,8 +1051,7 @@ extern const struct snd_pcm_chmap_elem snd_pcm_2_1_chmaps[];
 void snd_hda_get_codec_name(struct hda_codec *codec, char *name, int namelen);
 void snd_hda_bus_reboot_notify(struct hda_bus *bus);
 void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
-				    unsigned int power_state,
-				    bool eapd_workaround);
+				    unsigned int power_state);
 
 int snd_hda_lock_devices(struct hda_bus *bus);
 void snd_hda_unlock_devices(struct hda_bus *bus);
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index d98d470..7d941ef 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -435,7 +435,7 @@ static void conexant_set_power(struct hda_codec *codec, hda_nid_t fg,
 	/* partial workaround for "azx_get_response timeout" */
 	if (power_state == AC_PWRST_D0)
 		msleep(10);
-	snd_hda_codec_set_power_to_all(codec, fg, power_state, true);
+	snd_hda_codec_set_power_to_all(codec, fg, power_state);
 }
 
 static int conexant_init(struct hda_codec *codec)
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 0aa0ceb..5895d8f 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3724,7 +3724,7 @@ static void stac_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 	}
 	snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE,
 			afg_power_state);
-	snd_hda_codec_set_power_to_all(codec, fg, power_state, true);
+	snd_hda_codec_set_power_to_all(codec, fg, power_state);
 }
 #else
 #define stac_suspend		NULL
-- 
1.8.1.1
