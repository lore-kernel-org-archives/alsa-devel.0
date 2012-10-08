From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/3] ALSA: hda - Remove dead GPIO code for VIA
	codec
Date: Mon,  8 Oct 2012 15:44:13 +0200
Message-ID: <1349703855-7775-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E605E261726
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 15:44:23 +0200 (CEST)
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

>From what I can conclude all GPIO handling was removed in 2009.
Remove dead code remnants.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_via.c |   47 ---------------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 5a45a91..430cb33 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -299,7 +299,6 @@ static enum VIA_HDA_CODEC get_codec_type(struct hda_codec *codec)
 
 #define VIA_JACK_EVENT		0x20
 #define VIA_HP_EVENT		0x01
-#define VIA_GPIO_EVENT		0x02
 #define VIA_LINE_EVENT		0x03
 
 enum {
@@ -1685,50 +1684,6 @@ static void via_hp_automute(struct hda_codec *codec)
 	via_line_automute(codec, present);
 }
 
-static void via_gpio_control(struct hda_codec *codec)
-{
-	unsigned int gpio_data;
-	unsigned int vol_counter;
-	unsigned int vol;
-	unsigned int master_vol;
-
-	struct via_spec *spec = codec->spec;
-
-	gpio_data = snd_hda_codec_read(codec, codec->afg, 0,
-				       AC_VERB_GET_GPIO_DATA, 0) & 0x03;
-
-	vol_counter = (snd_hda_codec_read(codec, codec->afg, 0,
-					  0xF84, 0) & 0x3F0000) >> 16;
-
-	vol = vol_counter & 0x1F;
-	master_vol = snd_hda_codec_read(codec, 0x1A, 0,
-					AC_VERB_GET_AMP_GAIN_MUTE,
-					AC_AMP_GET_INPUT);
-
-	if (gpio_data == 0x02) {
-		/* unmute line out */
-		snd_hda_set_pin_ctl(codec, spec->autocfg.line_out_pins[0],
-				    PIN_OUT);
-		if (vol_counter & 0x20) {
-			/* decrease volume */
-			if (vol > master_vol)
-				vol = master_vol;
-			snd_hda_codec_amp_stereo(codec, 0x1A, HDA_INPUT,
-						 0, HDA_AMP_VOLMASK,
-						 master_vol-vol);
-		} else {
-			/* increase volume */
-			snd_hda_codec_amp_stereo(codec, 0x1A, HDA_INPUT, 0,
-					 HDA_AMP_VOLMASK,
-					 ((master_vol+vol) > 0x2A) ? 0x2A :
-					  (master_vol+vol));
-		}
-	} else if (!(gpio_data & 0x02)) {
-		/* mute line out */
-		snd_hda_set_pin_ctl(codec, spec->autocfg.line_out_pins[0], 0);
-	}
-}
-
 /* unsolicited event for jack sensing */
 static void via_unsol_event(struct hda_codec *codec,
 				  unsigned int res)
@@ -1743,8 +1698,6 @@ static void via_unsol_event(struct hda_codec *codec,
 
 	if (res == VIA_HP_EVENT || res == VIA_LINE_EVENT)
 		via_hp_automute(codec);
-	else if (res == VIA_GPIO_EVENT)
-		via_gpio_control(codec);
 	snd_hda_jack_report_sync(codec);
 }
 
-- 
1.7.9.5
