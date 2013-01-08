From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 083/112] ALSA: hda - Add hooks for HP/line/mic
	auto switching
Date: Tue,  8 Jan 2013 12:39:16 +0100
Message-ID: <1357645185-7645-84-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C25D6265218
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 9A6F0A51C9
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

... as a preliminary work for migrating patch_sigmatel.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 6 ++++++
 sound/pci/hda/hda_generic.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f69f2ab..c5a9b84 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2778,6 +2778,8 @@ static int check_auto_mute_availability(struct hda_codec *codec)
 		snd_printdd("hda-codec: Enable HP auto-muting on NID 0x%x\n",
 			    nid);
 		snd_hda_jack_detect_enable_callback(codec, nid, HDA_GEN_HP_EVENT,
+						    spec->hp_automute_hook ?
+						    spec->hp_automute_hook :
 						    snd_hda_gen_hp_automute);
 		spec->detect_hp = 1;
 	}
@@ -2791,6 +2793,8 @@ static int check_auto_mute_availability(struct hda_codec *codec)
 				snd_printdd("hda-codec: Enable Line-Out auto-muting on NID 0x%x\n", nid);
 				snd_hda_jack_detect_enable_callback(codec, nid,
 								    HDA_GEN_FRONT_EVENT,
+								    spec->line_automute_hook ?
+								    spec->line_automute_hook :
 								    snd_hda_gen_line_automute);
 				spec->detect_lo = 1;
 			}
@@ -2843,6 +2847,8 @@ static bool auto_mic_check_imux(struct hda_codec *codec)
 		snd_hda_jack_detect_enable_callback(codec,
 						    spec->am_entry[i].pin,
 						    HDA_GEN_MIC_EVENT,
+						    spec->mic_autoswitch_hook ?
+						    spec->mic_autoswitch_hook :
 						    snd_hda_gen_mic_autoswitch);
 	return true;
 }
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 5c1569c..1090a52 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -180,6 +180,14 @@ struct hda_gen_spec {
 	void (*init_hook)(struct hda_codec *codec);
 	void (*automute_hook)(struct hda_codec *codec);
 	void (*cap_sync_hook)(struct hda_codec *codec);
+
+	/* automute / autoswitch hooks */
+	void (*hp_automute_hook)(struct hda_codec *codec,
+				 struct hda_jack_tbl *tbl);
+	void (*line_automute_hook)(struct hda_codec *codec,
+				   struct hda_jack_tbl *tbl);
+	void (*mic_autoswitch_hook)(struct hda_codec *codec,
+				    struct hda_jack_tbl *tbl);
 };
 
 int snd_hda_gen_spec_init(struct hda_gen_spec *spec);
-- 
1.8.0.1
