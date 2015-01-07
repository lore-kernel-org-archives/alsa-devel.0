From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - Debug output which type of
	fixup was selected
Date: Wed,  7 Jan 2015 14:41:59 +0100
Message-ID: <1420638119-20885-2-git-send-email-david.henningsson@canonical.com>
References: <1420638119-20885-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F180260537
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 14:42:07 +0100 (CET)
In-Reply-To: <1420638119-20885-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Our fixup system is becoming increasingly complex, so it's becoming
time consuming to figure out which way the fix was applied.
This patch adds a few debug prints to aid when debugging why a specific
fixup was selected.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 6ec3775..3f8706b 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -920,6 +920,8 @@ void snd_hda_pick_pin_fixup(struct hda_codec *codec,
 			codec->fixup_id = pq->value;
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 			codec->fixup_name = pq->name;
+			codec_dbg(codec, "%s: picked fixup %s (pin match)\n",
+				  codec->chip_name, codec->fixup_name);
 #endif
 			codec->fixup_list = fixlist;
 			return;
@@ -960,6 +962,8 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 		codec->fixup_list = NULL;
 		codec->fixup_name = NULL;
 		codec->fixup_id = HDA_FIXUP_ID_NO_FIXUP;
+		codec_dbg(codec, "%s: picked no fixup (nofixup specified)\n",
+			  codec->chip_name);
 		return;
 	}
 
@@ -969,6 +973,8 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 				codec->fixup_id = models->id;
 				codec->fixup_name = models->name;
 				codec->fixup_list = fixlist;
+				codec_dbg(codec, "%s: picked fixup %s (model specified)\n",
+					  codec->chip_name, codec->fixup_name);
 				return;
 			}
 			models++;
@@ -980,6 +986,8 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 			id = q->value;
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 			name = q->name;
+			codec_dbg(codec, "%s: picked fixup %s (PCI SSID%s)\n",
+				  codec->chip_name, name, q->subdevice_mask ? "" : " - vendor generic");
 #endif
 		}
 	}
@@ -992,6 +1000,8 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 				id = q->value;
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 				name = q->name;
+				codec_dbg(codec, "%s: picked fixup %s (codec SSID)\n",
+					  codec->chip_name, name);
 #endif
 				break;
 			}
-- 
1.9.1
