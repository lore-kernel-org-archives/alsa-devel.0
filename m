From: Li Bo <liboat@gmail.com>
Subject: [PATCH 8/31] HDA patch_via.c: Change VT1708S & VT1702
	hp mode controls
Date: Mon, 5 Oct 2009 22:25:15 +0800
Message-ID: <16685ee0910050725u67cdf3b5g8dcd20275bcf773f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id D043410385D
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:25:15 +0200 (CEST)
Received: by mail-bw0-f225.google.com with SMTP id 25so10047195bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:25:15 -0700 (PDT)
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Change VT1708S & VT1702 hp mode controls

For VT1708S and VT1702, deactivate "Headphone Playback Volume" and
"Headphone Playback Mute" control if "Independent HP" mode is OFF.
and rename VT1702 "Independent HP" text.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:09:18.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:09:33.000000000 +0800
@@ -566,9 +566,26 @@
 	unsigned int pinsel = snd_hda_codec_read(codec, nid, 0,
 						 AC_VERB_GET_CONNECT_SEL,
 						 0x00);
+	static int hp_ctl_initialized = -1;

 	ucontrol->value.enumerated.item[0] = pinsel;
-
+	/* update HP controls on first time */
+	if ((spec->codec_type == VT1708S
+	     || spec->codec_type == VT1702)
+	    && hp_ctl_initialized == -1) {
+		struct snd_card *card = codec->bus->card;
+		struct snd_kcontrol *kctl;
+		/* deactive hp volume & switch in independent mode */
+		list_for_each_entry(kctl, &card->controls, list)
+			if (spec->hp_independent_mode
+			    && (strcmp(kctl->id.name,
+				       "Headphone Playback Volume") == 0
+				|| strcmp(kctl->id.name,
+					  "Headphone Playback Switch") == 0))
+				kctl->vd[0].access |=
+					SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+		hp_ctl_initialized = 1;
+	}
 	return 0;
 }

@@ -3342,11 +3359,13 @@

 static int vt1702_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
 {
-	int err;
-
+	int err, i;
+	struct hda_input_mux *imux;
+	static const char *texts[] = { "ON (need reboot)",
+				       "OFF (need reboot)",
+				       NULL};
 	if (!pin)
 		return 0;
-
 	spec->multiout.hp_nid = 0x1D;

 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
@@ -3361,8 +3380,18 @@
 	if (err < 0)
 		return err;

-	create_hp_imux(spec);
+	imux = &spec->private_imux[1];

+	/* for hp mode select */
+	i = 0;
+	while (texts[i] != NULL)	{
+		imux->items[imux->num_items].label =  texts[i];
+		imux->items[imux->num_items].index = i;
+		imux->num_items++;
+		i++;
+	}
+
+	spec->hp_mux = &spec->private_imux[1];
 	return 0;
 }
