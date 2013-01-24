From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/13] ALSA: hda - Fix invalid snd_BUG_ON() in
	alc271_hp_gate_mic_jack()
Date: Thu, 24 Jan 2013 18:37:50 +0100
Message-ID: <1359049082-5880-2-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AD59A2616EA
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id E72AEA50E4
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

The fixup function is called multiple times before parsing the pins,
so snd_BUG_ON() hits when loaded.  Move it to the proper place in the
if block.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 604fe5e..515f83b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2729,12 +2729,13 @@ static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
 {
 	struct alc_spec *spec = codec->spec;
 
-	if (snd_BUG_ON(!spec->gen.am_entry[1].pin ||
-		       !spec->gen.autocfg.hp_pins[0]))
-		return;
-	if (action == HDA_FIXUP_ACT_PROBE)
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		if (snd_BUG_ON(!spec->gen.am_entry[1].pin ||
+			       !spec->gen.autocfg.hp_pins[0]))
+			return;
 		snd_hda_jack_set_gating_jack(codec, spec->gen.am_entry[1].pin,
 					     spec->gen.autocfg.hp_pins[0]);
+	}
 }
 
 enum {
-- 
1.8.1.1
