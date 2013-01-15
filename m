From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Add capture_switch_hook to
	generic parser
Date: Tue, 15 Jan 2013 12:07:32 +0100
Message-ID: <1358248053-14110-2-git-send-email-tiwai@suse.de>
References: <1358248053-14110-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A85A9265CBC
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:07:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8C59BA520D
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:07:34 +0100 (CET)
In-Reply-To: <1358248053-14110-1-git-send-email-tiwai@suse.de>
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

Add a hook for the capture mixer switch.  This will be used by IDT
codecs for controlling the mic-mute LED.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 16 +++++++++++++++-
 sound/pci/hda/hda_generic.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 4bc4cd9..932e6a1 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2517,9 +2517,23 @@ static const struct snd_kcontrol_new cap_vol_temp = {
 static int cap_sw_put(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	return cap_put_caller(kcontrol, ucontrol,
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	int ret;
+
+	ret = cap_put_caller(kcontrol, ucontrol,
 			      snd_hda_mixer_amp_switch_put,
 			      NID_PATH_MUTE_CTL);
+	if (ret < 0)
+		return ret;
+
+	if (spec->capture_switch_hook) {
+		bool enable = (ucontrol->value.integer.value[0] ||
+			       ucontrol->value.integer.value[1]);
+		spec->capture_switch_hook(codec, enable);
+	}
+
+	return ret;
 }
 
 static const struct snd_kcontrol_new cap_sw_temp = {
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index bfa2d97..1ceaacd 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -227,6 +227,9 @@ struct hda_gen_spec {
 				   struct hda_jack_tbl *tbl);
 	void (*mic_autoswitch_hook)(struct hda_codec *codec,
 				    struct hda_jack_tbl *tbl);
+
+	/* capture switch hook (for mic-mute LED) */
+	void (*capture_switch_hook)(struct hda_codec *codec, bool enable);
 };
 
 int snd_hda_gen_spec_init(struct hda_gen_spec *spec);
-- 
1.8.1
