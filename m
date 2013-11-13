From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Control EAPD for Master volume
	on Lenovo N100
Date: Wed, 13 Nov 2013 09:45:33 +0100
Message-ID: <1384332333-20674-2-git-send-email-tiwai@suse.de>
References: <1384332333-20674-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B1EB260840
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 09:45:33 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5D0C5A70DC
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 09:45:33 +0100 (CET)
In-Reply-To: <1384332333-20674-1-git-send-email-tiwai@suse.de>
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

Similarly as other laptops with AD1981 & co codecs, we can control
EAPD on AD1986A more safely depending on the Master switch, in order
to save some power.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index ba37116168ac..1a83559f4cbd 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -139,6 +139,18 @@ static int ad198x_suspend(struct hda_codec *codec)
 }
 #endif
 
+/* follow EAPD via vmaster hook */
+static void ad_vmaster_eapd_hook(void *private_data, int enabled)
+{
+	struct hda_codec *codec = private_data;
+	struct ad198x_spec *spec = codec->spec;
+
+	if (!spec->eapd_nid)
+		return;
+	snd_hda_codec_update_cache(codec, spec->eapd_nid, 0,
+				   AC_VERB_SET_EAPD_BTLENABLE,
+				   enabled ? 0x02 : 0x00);
+}
 
 /*
  * Automatic parse of I/O pins from the BIOS configuration
@@ -224,6 +236,8 @@ static void ad_fixup_inv_jack_detect(struct hda_codec *codec,
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		codec->inv_jack_detect = 1;
 		spec->gen.keep_eapd_on = 1;
+		spec->gen.vmaster_mute.hook = ad_vmaster_eapd_hook;
+		spec->eapd_nid = 0x1b;
 	}
 }
 
@@ -469,19 +483,6 @@ static int patch_ad1983(struct hda_codec *codec)
  * AD1981 HD specific
  */
 
-/* follow EAPD via vmaster hook */
-static void ad_vmaster_eapd_hook(void *private_data, int enabled)
-{
-	struct hda_codec *codec = private_data;
-	struct ad198x_spec *spec = codec->spec;
-
-	if (!spec->eapd_nid)
-		return;
-	snd_hda_codec_update_cache(codec, spec->eapd_nid, 0,
-				   AC_VERB_SET_EAPD_BTLENABLE,
-				   enabled ? 0x02 : 0x00);
-}
-
 static void ad1981_fixup_hp_eapd(struct hda_codec *codec,
 				 const struct hda_fixup *fix, int action)
 {
-- 
1.8.4.2
