From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 047/112] ALSA: hda - Add EAPD control to
	generic parser
Date: Tue,  8 Jan 2013 12:38:40 +0100
Message-ID: <1357645185-7645-48-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FE342651C4
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id E77FEA525A
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
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

Enable EAPD in output path initializations automatically unless the
new flag spec->own_eapd_ctl is set.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 6 ++++++
 sound/pci/hda/hda_generic.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 2d19b91..31c5677 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3333,6 +3333,7 @@ EXPORT_SYMBOL_HDA(snd_hda_gen_build_pcms);
 static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
 				  int pin_type, hda_nid_t dac)
 {
+	struct hda_gen_spec *spec = codec->spec;
 	struct nid_path *path;
 
 	snd_hda_set_pin_ctl_cache(codec, pin, pin_type);
@@ -3342,6 +3343,11 @@ static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
 	if (path->active)
 		return;
 	snd_hda_activate_path(codec, path, true, true);
+
+	if (!spec->own_eapd_ctl &&
+	    (snd_hda_query_pin_caps(codec, pin) & AC_PINCAP_EAPD))
+		snd_hda_codec_update_cache(codec, pin, 0,
+					   AC_VERB_SET_EAPD_BTLENABLE, 0x02);
 }
 
 /* initialize primary output paths */
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index a9f4f63..9c00bd5 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -150,6 +150,7 @@ struct hda_gen_spec {
 	unsigned int no_primary_hp:1; /* Don't prefer HP pins to speaker pins */
 	unsigned int multi_cap_vol:1; /* allow multiple capture xxx volumes */
 	unsigned int inv_dmic_split:1; /* inverted dmic w/a for conexant */
+	unsigned int own_eapd_ctl:1; /* set EAPD by own function */
 
 	unsigned int parse_flags; /* passed to snd_hda_parse_pin_defcfg() */
 
-- 
1.8.0.1
