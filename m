From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix invalid pin powermap without
	jack detection
Date: Thu, 11 Sep 2014 16:10:44 +0200
Message-ID: <1410444644-23021-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C9ED02656E9
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:10:45 +0200 (CEST)
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
Cc: Adam Richter <adam_richter2004@yahoo.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When a driver is set up without the jack detection explicitly (either
by passing a model option or via a specific fixup), the pin powermap
of IDT/STAC codecs is set up wrongly, resulting in the silence
output.  It's because of a logic failure in stac_init_power_map().
It tries to avoid creating a callback for the pins that have other
auto-hp and auto-mic callbacks, but the check is done in a wrong way
at a wrong time.  The stac_init_power_map() should be called after
creating other jack detection ctls, and the jack callback should be
created only for jack-detectable widgets.

This patch fixes the check in stac_init_power_map() and its callee
at the right place, after snd_hda_gen_build_controls().

Reported-by: Adam Richter <adam_richter2004@yahoo.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

This is the patch with a proper changelog.
Adam, let me know if this really works for you.  Once after confirmed,
I'll queue it to for-linus branch.


thanks,

Takashi

 sound/pci/hda/patch_sigmatel.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index ea823e1100da..98cd1908c039 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -566,8 +566,8 @@ static void stac_init_power_map(struct hda_codec *codec)
 		if (snd_hda_jack_tbl_get(codec, nid))
 			continue;
 		if (def_conf == AC_JACK_PORT_COMPLEX &&
-		    !(spec->vref_mute_led_nid == nid ||
-		      is_jack_detectable(codec, nid))) {
+		    spec->vref_mute_led_nid != nid &&
+		    is_jack_detectable(codec, nid)) {
 			snd_hda_jack_detect_enable_callback(codec, nid,
 							    STAC_PWR_EVENT,
 							    jack_update_power);
@@ -4276,11 +4276,18 @@ static int stac_parse_auto_config(struct hda_codec *codec)
 			return err;
 	}
 
-	stac_init_power_map(codec);
-
 	return 0;
 }
 
+static int stac_build_controls(struct hda_codec *codec)
+{
+	int err = snd_hda_gen_build_controls(codec);
+
+	if (err < 0)
+		return err;
+	stac_init_power_map(codec);
+	return 0;
+}
 
 static int stac_init(struct hda_codec *codec)
 {
@@ -4392,7 +4399,7 @@ static int stac_suspend(struct hda_codec *codec)
 #endif /* CONFIG_PM */
 
 static const struct hda_codec_ops stac_patch_ops = {
-	.build_controls = snd_hda_gen_build_controls,
+	.build_controls = stac_build_controls,
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = stac_init,
 	.free = stac_free,
-- 
2.1.0
