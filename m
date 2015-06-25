From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Disable widget power-save for VIA
	codecs
Date: Thu, 25 Jun 2015 08:55:08 +0200
Message-ID: <1435215308-4793-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C70872602AD
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 08:55:10 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E640CAC57
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 06:55:09 +0000 (UTC)
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

The widget power-save that was enabled in 4.1 kernel seems resulting
in the silent output on VIA codecs by some reason.  Some widgets get
wrong power states.

As a quick fix, turn this flag off while keeping power_down_unused
flag.  This will bring back to the state of 4.0.x.

Fixes: 688b12cc3ca8 ('ALSA: hda - Use the new power control for VIA codecs')
Reported-and-tested-by: Harald Dunkel <harri@afaics.de>
Cc: <stable@vger.kernel.org> # v4.1
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 0521be8d46a8..da5366405eda 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -241,7 +241,9 @@ static int via_pin_power_ctl_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	ucontrol->value.enumerated.item[0] = codec->power_save_node;
+	struct via_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->gen.power_down_unused;
 	return 0;
 }
 
@@ -252,9 +254,9 @@ static int via_pin_power_ctl_put(struct snd_kcontrol *kcontrol,
 	struct via_spec *spec = codec->spec;
 	bool val = !!ucontrol->value.enumerated.item[0];
 
-	if (val == codec->power_save_node)
+	if (val == spec->gen.power_down_unused)
 		return 0;
-	codec->power_save_node = val;
+	/* codec->power_save_node = val; */ /* widget PM seems yet broken */
 	spec->gen.power_down_unused = val;
 	analog_low_current_mode(codec);
 	return 1;
-- 
2.4.4
