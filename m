From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 072/112] ALSA: hda - Use cached version for
	changing pins in hda_generic.c
Date: Tue,  8 Jan 2013 12:39:05 +0100
Message-ID: <1357645185-7645-73-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 792E6265209
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 7550CA5328
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

There is no reason to avoid snd_hda_set_pin_ctl_cache() there.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 46b00e0..f4b5043 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1572,11 +1572,12 @@ static void update_shared_mic_hp(struct hda_codec *codec, bool set_as_mic)
 		const hda_nid_t vref_pin = spec->shared_mic_vref_pin;
 		unsigned int vref_val = snd_hda_get_default_vref(codec, vref_pin);
 		if (vref_val != AC_PINCTL_VREF_HIZ)
-			snd_hda_set_pin_ctl(codec, vref_pin, PIN_IN | (set_as_mic ? vref_val : 0));
+			snd_hda_set_pin_ctl_cache(codec, vref_pin,
+					PIN_IN | (set_as_mic ? vref_val : 0));
 	}
 
 	val = set_as_mic ? val | PIN_IN : PIN_HP;
-	snd_hda_set_pin_ctl(codec, pin, val);
+	snd_hda_set_pin_ctl_cache(codec, pin, val);
 
 	spec->automute_speaker = !set_as_mic;
 	call_update_outputs(codec);
@@ -2431,7 +2432,7 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 		} else
 			val = 0;
 		val |= pin_bits;
-		snd_hda_set_pin_ctl(codec, nid, val);
+		snd_hda_set_pin_ctl_cache(codec, nid, val);
 		set_pin_eapd(codec, nid, !mute);
 	}
 }
@@ -3467,7 +3468,7 @@ static void set_input_pin(struct hda_codec *codec, hda_nid_t nid,
 	unsigned int val = PIN_IN;
 	if (auto_pin_type == AUTO_PIN_MIC)
 		val |= snd_hda_get_default_vref(codec, nid);
-	snd_hda_set_pin_ctl(codec, nid, val);
+	snd_hda_set_pin_ctl_cache(codec, nid, val);
 }
 
 /* set up input pins and loopback paths */
@@ -3541,7 +3542,7 @@ static void init_digital(struct hda_codec *codec)
 	}
 	pin = spec->autocfg.dig_in_pin;
 	if (pin)
-		snd_hda_set_pin_ctl(codec, pin, PIN_IN);
+		snd_hda_set_pin_ctl_cache(codec, pin, PIN_IN);
 }
 
 /* clear unsol-event tags on unused pins; Conexant codecs seem to leave
-- 
1.8.0.1
