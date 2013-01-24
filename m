From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/13] ALSA: hda - Synchronize the power state
	at the end of codec init
Date: Thu, 24 Jan 2013 18:37:59 +0100
Message-ID: <1359049082-5880-11-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AFBC52616F8
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 018DFA51BB
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
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

Put the power state synchronization at the end of the parsing of
codec.  This is necessary when the power filter is changed during the
codec probe.  Since the first power-up sequence is performed without
the special filter, all widgets are supposed to be ON at this point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 19ff923..2311114 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3765,6 +3765,37 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 	return state;
 }
 
+/* sync power states of all widgets;
+ * this is called at the end of codec parsing
+ */
+static void sync_power_up_states(struct hda_codec *codec)
+{
+	hda_nid_t nid = codec->start_nid;
+	int i;
+
+	/* don't care if no or standard filter is used */
+	if (!codec->power_filter || codec->power_filter == default_power_filter)
+		return;
+
+	for (i = 0; i < codec->num_nodes; i++, nid++) {
+		unsigned int wcaps = get_wcaps(codec, nid);
+		unsigned int state, target;
+		if (!(wcaps & AC_WCAP_POWER))
+			continue;
+		target = codec->power_filter(codec, nid, AC_PWRST_D0);
+		if (target == AC_PWRST_D0)
+			continue;
+		state = snd_hda_codec_read(codec, nid, 0,
+					   AC_VERB_GET_POWER_STATE, 0);
+		if (state & AC_PWRST_ERROR)
+			continue;
+		state = (state >> 4) & 0x0f;
+		if (state != target)
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_POWER_STATE, target);
+	}
+}
+
 #ifdef CONFIG_SND_HDA_HWDEP
 /* execute additional init verbs */
 static void hda_exec_init_verbs(struct hda_codec *codec)
@@ -3952,6 +3983,7 @@ int snd_hda_codec_build_controls(struct hda_codec *codec)
 		hda_jackpoll_work(&codec->jackpoll_work.work);
 	else
 		snd_hda_jack_report_sync(codec); /* call at the last init point */
+	sync_power_up_states(codec);
 	return 0;
 }
 
-- 
1.8.1.1
