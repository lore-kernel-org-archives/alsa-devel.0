From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 001/112] ALSA: hda/realtek - Simplify
	alc_auto_is_dac_reachable()
Date: Tue,  8 Jan 2013 12:37:54 +0100
Message-ID: <1357645185-7645-2-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F9882615CC
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 02F15A51BB
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
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

Use the helper function snd_hda_get_conn_index() instead of open
codes.  This also improves the detection of some routes to DAC on
ALC260 (although the difference doesn't influence on the end
results of the mapping).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 71ae23d..d8118c9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2938,19 +2938,9 @@ static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
 static bool alc_auto_is_dac_reachable(struct hda_codec *codec,
 				      hda_nid_t pin, hda_nid_t dac)
 {
-	hda_nid_t srcs[5];
-	int i, num;
-
 	if (!pin || !dac)
 		return false;
-	pin = alc_go_down_to_selector(codec, pin);
-	num = snd_hda_get_connections(codec, pin, srcs, ARRAY_SIZE(srcs));
-	for (i = 0; i < num; i++) {
-		hda_nid_t nid = alc_auto_mix_to_dac(codec, srcs[i]);
-		if (nid == dac)
-			return true;
-	}
-	return false;
+	return snd_hda_get_conn_index(codec, pin, dac, true) >= 0;
 }
 
 static hda_nid_t get_dac_if_single(struct hda_codec *codec, hda_nid_t pin)
-- 
1.8.0.1
