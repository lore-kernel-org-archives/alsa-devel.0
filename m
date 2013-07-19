From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/13] ALSA: hda - Add GPIO control to AD1884
	HP fixup
Date: Fri, 19 Jul 2013 17:12:10 +0200
Message-ID: <1374246742-14373-2-git-send-email-tiwai@suse.de>
References: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C97226573F
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 39F2AA5386
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
In-Reply-To: <1374246742-14373-1-git-send-email-tiwai@suse.de>
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

The AD1884 HP laptop/mobile quirks control GPIO1 bit as the primary
mute as well.  Add the similar control to ad1884 fixup for auto
parser, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index d97f0d6..2ae7dc5 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -3599,14 +3599,34 @@ static void ad1884_fixup_amp_override(struct hda_codec *codec,
 					  (1 << AC_AMPCAP_MUTE_SHIFT));
 }
 
+/* toggle GPIO1 according to the mute state */
+static void ad1884_vmaster_hp_gpio_hook(void *private_data, int enabled)
+{
+	struct hda_codec *codec = private_data;
+	struct ad198x_spec *spec = codec->spec;
+
+	if (spec->eapd_nid)
+		ad_vmaster_eapd_hook(private_data, enabled);
+	snd_hda_codec_update_cache(codec, 0x01, 0,
+				   AC_VERB_SET_GPIO_DATA,
+				   enabled ? 0x00 : 0x02);
+}
+
 static void ad1884_fixup_hp_eapd(struct hda_codec *codec,
 				 const struct hda_fixup *fix, int action)
 {
 	struct ad198x_spec *spec = codec->spec;
+	static const struct hda_verb gpio_init_verbs[] = {
+		{0x01, AC_VERB_SET_GPIO_MASK, 0x02},
+		{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x02},
+		{0x01, AC_VERB_SET_GPIO_DATA, 0x02},
+		{},
+	};
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
-		spec->gen.vmaster_mute.hook = ad_vmaster_eapd_hook;
+		spec->gen.vmaster_mute.hook = ad1884_vmaster_hp_gpio_hook;
+		snd_hda_sequence_write_cache(codec, gpio_init_verbs);
 		break;
 	case HDA_FIXUP_ACT_PROBE:
 		if (spec->gen.autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT)
-- 
1.8.3.1
