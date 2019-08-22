From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda/realtek - Check beep whitelist
	before assigning in all codecs
Date: Thu, 22 Aug 2019 10:00:41 +0200
Message-ID: <20190822080042.15772-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A67F9F80147
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 10:00:46 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4760AAC1C
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 08:00:46 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some Realtek codec parsers didn't check the availability of PC beep.
Add has_cdefine_beep() check appropriately.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b6ae452a1d8f..19831521bd95 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2848,7 +2848,8 @@ static int patch_alc268(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
-	spec->gen.beep_nid = 0x01;
+	if (has_cdefine_beep(codec))
+		spec->gen.beep_nid = 0x01;
 
 	spec->shutup = alc_eapd_shutup;
 
@@ -8102,7 +8103,8 @@ static int patch_alc861(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
-	spec->gen.beep_nid = 0x23;
+	if (has_cdefine_beep(codec))
+		spec->gen.beep_nid = 0x23;
 
 #ifdef CONFIG_PM
 	spec->power_hook = alc_power_eapd;
@@ -8203,7 +8205,8 @@ static int patch_alc861vd(struct hda_codec *codec)
 		return err;
 
 	spec = codec->spec;
-	spec->gen.beep_nid = 0x23;
+	if (has_cdefine_beep(codec))
+		spec->gen.beep_nid = 0x23;
 
 	spec->shutup = alc_eapd_shutup;
 
-- 
2.16.4
