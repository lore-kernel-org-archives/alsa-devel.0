From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 35/38] ALSA: hda/realtek - Create individual
	mute switches for shared DAC
Date: Fri, 24 Feb 2012 17:36:28 +0100
Message-ID: <1330101391-8788-36-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id BD991104328
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BE187932D7
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Even if the outputs are using shared DACs, we can still create individual
mute siwtches since they are assigned per pin.  This allows to create,
e.g. Speaker and Bass Speaker mute switches while the single volume is
used for these outputs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   50 ++++++++++++++++------------------------
 1 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 997cc81..3cedb26 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3717,41 +3717,31 @@ static int alc_auto_create_extra_outs(struct hda_codec *codec, int num_pins,
 		return alc_auto_create_extra_out(codec, *pins, dac, pfx, 0);
 	}
 
-	if (dacs[num_pins - 1]) {
-		/* OK, we have a multi-output system with individual volumes */
-		for (i = 0; i < num_pins; i++) {
-			if (num_pins >= 3) {
-				snprintf(name, sizeof(name), "%s %s",
-					 pfx, channel_name[i]);
-				err = alc_auto_create_extra_out(codec, pins[i], dacs[i],
-								name, 0);
-			} else {
-				err = alc_auto_create_extra_out(codec, pins[i], dacs[i],
-								pfx, i);
-			}
-			if (err < 0)
-				return err;
-		}
-		return 0;
-	}
-
-	/* Let's create a bind-controls */
-	ctl = new_bind_ctl(codec, num_pins, &snd_hda_bind_sw);
-	if (!ctl)
-		return -ENOMEM;
-	n = 0;
 	for (i = 0; i < num_pins; i++) {
-		if (get_wcaps(codec, pins[i]) & AC_WCAP_OUT_AMP)
-			ctl->values[n++] =
-				HDA_COMPOSE_AMP_VAL(pins[i], 3, 0, HDA_OUTPUT);
-	}
-	if (n) {
-		snprintf(name, sizeof(name), "%s Playback Switch", pfx);
-		err = add_control(spec, ALC_CTL_BIND_SW, name, 0, (long)ctl);
+		hda_nid_t dac;
+		if (dacs[num_pins - 1])
+			dac = dacs[i]; /* with individual volumes */
+		else
+			dac = 0;
+		if (num_pins == 2 && i == 1 && !strcmp(pfx, "Speaker")) {
+			err = alc_auto_create_extra_out(codec, pins[i], dac,
+							"Bass Speaker", 0);
+		} else if (num_pins >= 3) {
+			snprintf(name, sizeof(name), "%s %s",
+				 pfx, channel_name[i]);
+			err = alc_auto_create_extra_out(codec, pins[i], dac,
+							name, 0);
+		} else {
+			err = alc_auto_create_extra_out(codec, pins[i], dac,
+							pfx, i);
+		}
 		if (err < 0)
 			return err;
 	}
+	if (dacs[num_pins - 1])
+		return 0;
 
+	/* Let's create a bind-controls for volumes */
 	ctl = new_bind_ctl(codec, num_pins, &snd_hda_bind_vol);
 	if (!ctl)
 		return -ENOMEM;
-- 
1.7.9
