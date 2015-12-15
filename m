From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: hda - Set codec to D3 at
	reboot/shutdown on Thinkpads
Date: Tue, 15 Dec 2015 15:14:09 +0100
Message-ID: <1450188850-22441-3-git-send-email-tiwai@suse.de>
References: <1450188850-22441-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E7DD2625CF
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 15:14:10 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 52DF3ADB7
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 14:14:10 +0000 (UTC)
In-Reply-To: <1450188850-22441-1-git-send-email-tiwai@suse.de>
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

Lenovo Thinkpads with Realtek codecs may still have some loud
crackling noises at reboot/shutdown even though a few previous fixes
have been applied.  It's because the previous fix (disabling the
default shutup callback) takes effect only at transition of the codec
power state.  Meanwhile, at reboot or shutdown, we don't take down the
codec power as default, thus it triggers the same problem unless the
codec is powered down casually by runtime PM.

This patch tries to address the issue.  It gives two things:
- implement the separate reboot_notify hook to struct alc_spec, and
  call it optionally if defined.
- turn off the codec to D3 for Thinkpad models via this new callback

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=958439
Reported-and-tested-by: Benjamin Poirier <bpoirier@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 531065eaac1b..5a79c7a2187a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -111,6 +111,7 @@ struct alc_spec {
 	void (*power_hook)(struct hda_codec *codec);
 #endif
 	void (*shutup)(struct hda_codec *codec);
+	void (*reboot_notify)(struct hda_codec *codec);
 
 	int init_amp;
 	int codec_variant;	/* flag for other variants */
@@ -773,6 +774,25 @@ static inline void alc_shutup(struct hda_codec *codec)
 		snd_hda_shutup_pins(codec);
 }
 
+static void alc_reboot_notify(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (spec && spec->reboot_notify)
+		spec->reboot_notify(codec);
+	else
+		alc_shutup(codec);
+}
+
+/* power down codec to D3 at reboot/shutdown; set as reboot_notify ops */
+static void alc_d3_at_reboot(struct hda_codec *codec)
+{
+	snd_hda_codec_set_power_to_all(codec, codec->core.afg, AC_PWRST_D3);
+	snd_hda_codec_write(codec, codec->core.afg, 0,
+			    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+	msleep(10);
+}
+
 #define alc_free	snd_hda_gen_free
 
 #ifdef CONFIG_PM
@@ -818,7 +838,7 @@ static const struct hda_codec_ops alc_patch_ops = {
 	.suspend = alc_suspend,
 	.check_power_status = snd_hda_gen_check_power_status,
 #endif
-	.reboot_notify = alc_shutup,
+	.reboot_notify = alc_reboot_notify,
 };
 
 
@@ -4199,6 +4219,7 @@ static void alc_fixup_tpt440_dock(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->shutup = alc_no_shutup; /* reduce click noise */
+		spec->reboot_notify = alc_d3_at_reboot; /* reduce noise */
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 		codec->power_save_node = 0; /* avoid click noises */
 		snd_hda_apply_pincfgs(codec, pincfgs);
-- 
2.6.4
