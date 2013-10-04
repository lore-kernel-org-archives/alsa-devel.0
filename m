From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 7/7] ALSA: hda - hdmi: Tweak debug messages to
	be more useful
Date: Sat,  5 Oct 2013 02:25:44 +0300
Message-ID: <1380929144-24944-8-git-send-email-anssi.hannula@iki.fi>
References: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 275082617A5
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 01:26:23 +0200 (CEST)
In-Reply-To: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Allow channel map debugging for both automatic and manual channel maps,
and print CA always when updating infoframe.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/patch_hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 9f2c396..7dba20c 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -639,8 +639,6 @@ static void hdmi_std_setup_channel_mapping(struct hda_codec *codec,
 			break;
 		}
 	}
-
-	hdmi_debug_channel_mapping(codec, pin_nid);
 }
 
 struct channel_map_table {
@@ -795,6 +793,8 @@ static void hdmi_setup_channel_mapping(struct hda_codec *codec,
 		hdmi_std_setup_channel_mapping(codec, pin_nid, non_pcm, ca);
 		hdmi_setup_fake_chmap(map, ca);
 	}
+
+	hdmi_debug_channel_mapping(codec, pin_nid);
 }
 
 /*
@@ -985,9 +985,9 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 	if (!hdmi_infoframe_uptodate(codec, pin_nid, ai.bytes,
 					sizeof(ai))) {
 		snd_printdd("hdmi_setup_audio_infoframe: "
-			    "pin=%d channels=%d\n",
+			    "pin=%d channels=%d ca=0x%02x\n",
 			    pin_nid,
-			    active_channels);
+			    active_channels, ca);
 		hdmi_setup_channel_mapping(codec, pin_nid, non_pcm, ca,
 					   channels, per_pin->chmap,
 					   per_pin->chmap_set);
-- 
1.8.1.5
