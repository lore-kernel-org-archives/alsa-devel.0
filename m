From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: hda/generic - Fix wrong initial
	power state for fixed pins
Date: Thu,  9 Apr 2015 10:40:35 +0200
Message-ID: <1428568838-21550-3-git-send-email-tiwai@suse.de>
References: <1428568838-21550-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 10D1C265268
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:40:40 +0200 (CEST)
In-Reply-To: <1428568838-21550-1-git-send-email-tiwai@suse.de>
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
Cc: Hui Wang <hui.wang@canonical.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When the widget power-saving is enabled, the first automute hook
invocation checks through the whole pins and it also tries to
synchronize the power state.  However, this results in a wrong state
because it calls unconditionally snd_hda_jack_detect_state().
This patch adds a check of jack detectability before the actual jack
detection call.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index afc6b1b0898c..46b559832d2c 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3959,6 +3959,14 @@ static hda_nid_t set_path_power(struct hda_codec *codec, hda_nid_t nid,
 	return changed;
 }
 
+/* check the jack status for power control */
+static bool detect_pin_state(struct hda_codec *codec, hda_nid_t pin)
+{
+	if (!is_jack_detectable(codec, pin))
+		return true;
+	return snd_hda_jack_detect_state(codec, pin) != HDA_JACK_NOT_PRESENT;
+}
+
 /* power up/down the paths of the given pin according to the jack state;
  * power = 0/1 : only power up/down if it matches with the jack state,
  *       < 0   : force power up/down to follow the jack sate
@@ -3973,7 +3981,8 @@ static hda_nid_t set_pin_power_jack(struct hda_codec *codec, hda_nid_t pin,
 	if (!codec->power_save_node)
 		return 0;
 
-	on = snd_hda_jack_detect_state(codec, pin) != HDA_JACK_NOT_PRESENT;
+	on = detect_pin_state(codec, pin);
+
 	if (power >= 0 && on != power)
 		return 0;
 	return set_path_power(codec, pin, on, -1);
@@ -4225,8 +4234,7 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 		if (codec->power_save_node) {
 			bool on = !mute;
 			if (on)
-				on = snd_hda_jack_detect_state(codec, nid)
-					!= HDA_JACK_NOT_PRESENT;
+				on = detect_pin_state(codec, nid);
 			set_path_power(codec, nid, on, -1);
 		}
 	}
-- 
2.3.5
