From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Fix parsing of CMI8888 codec
Date: Wed,  6 Aug 2014 14:39:15 +0200
Message-ID: <1407328755-1021-2-git-send-email-tiwai@suse.de>
References: <1407328755-1021-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C3ADC2610A1
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 14:39:15 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3419BAD8A
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 12:39:15 +0000 (UTC)
In-Reply-To: <1407328755-1021-1-git-send-email-tiwai@suse.de>
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

CMI8888 codec chip has a boost amp (only) on the headphone pin, and
this confuses the generic parser, which tends to pick up the most
outside amp.  This results in the wrong volume setup, as the driver
complains like:
  hda_codec: Mismatching dB step for vmaster slave (-100!=1000)

For avoiding this problem, rule out the amp on NID 0x10 and create
"Headphone Amp" volume control manually instead.

Note that this patch still doesn't fix all problems yet.  The sound
output from the line out seems still too low.  It will be fixed in
another patch (hopefully).

Reported-and-tested-by: Vincent Lejeune <vljn@ovi.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_cmedia.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index ed3d133ffbb6..c895a8f21192 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -75,15 +75,62 @@ static int patch_cmi9880(struct hda_codec *codec)
 	return err;
 }
 
+static int patch_cmi8888(struct hda_codec *codec)
+{
+	struct cmi_spec *spec;
+	struct auto_pin_cfg *cfg;
+	int err;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	cfg = &spec->gen.autocfg;
+	snd_hda_gen_spec_init(&spec->gen);
+
+	/* mask NID 0x10 from the playback volume selection;
+	 * it's a headphone boost volume handled manually below
+	 */
+	spec->gen.out_vol_mask = (1ULL << 0x10);
+
+	err = snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
+	if (err < 0)
+		goto error;
+	err = snd_hda_gen_parse_auto_config(codec, cfg);
+	if (err < 0)
+		goto error;
+
+	if (get_defcfg_device(snd_hda_codec_get_pincfg(codec, 0x10)) ==
+	    AC_JACK_HP_OUT) {
+		static const struct snd_kcontrol_new amp_kctl =
+			HDA_CODEC_VOLUME("Headphone Amp Playback Volume",
+					 0x10, 0, HDA_OUTPUT);
+		if (!snd_hda_gen_add_kctl(&spec->gen, NULL, &amp_kctl)) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
+	codec->patch_ops = cmi_auto_patch_ops;
+	return 0;
+
+ error:
+	snd_hda_gen_free(codec);
+	return err;
+}
+
 /*
  * patch entries
  */
 static const struct hda_codec_preset snd_hda_preset_cmedia[] = {
+	{ .id = 0x13f68888, .name = "CMI8888", .patch = patch_cmi8888 },
 	{ .id = 0x13f69880, .name = "CMI9880", .patch = patch_cmi9880 },
  	{ .id = 0x434d4980, .name = "CMI9880", .patch = patch_cmi9880 },
 	{} /* terminator */
 };
 
+MODULE_ALIAS("snd-hda-codec-id:13f68888");
 MODULE_ALIAS("snd-hda-codec-id:13f69880");
 MODULE_ALIAS("snd-hda-codec-id:434d4980");
 
-- 
2.0.3
