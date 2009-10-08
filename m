From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 8/31] HDA patch_via.c: Change VT1708S &
	VT1702 hp mode controls
Date: Thu, 8 Oct 2009 13:29:54 +0800
Message-ID: <16685ee0910072229j4cc23fb1g47348b93574779ed@mail.gmail.com>
References: <16685ee0910050725u67cdf3b5g8dcd20275bcf773f@mail.gmail.com>
	<s5hab056fwc.wl%tiwai@suse.de>
	<16685ee0910052144r444996bdqee29f374207cd7@mail.gmail.com>
	<s5hk4z9rs3o.wl%tiwai@suse.de>
	<16685ee0910060855i1e6dc4c5mf2ec443e71745b7@mail.gmail.com>
	<16685ee0910061042u68bb6822p12a37f942ec5bafa@mail.gmail.com>
	<s5hpr90o0we.wl%tiwai@suse.de>
	<16685ee0910062301w1f372f88r24d17e78491bfbbb@mail.gmail.com>
	<s5h1vlfzo3l.wl%tiwai@suse.de>
	<16685ee0910072229q53c3a649g84cfa716aa70d86a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 25F31103927
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:29:56 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1457924bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:29:55 -0700 (PDT)
In-Reply-To: <16685ee0910072229q53c3a649g84cfa716aa70d86a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: LoganLi@viatech.com.cn, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Change VT1708S & VT1702 hp mode controls

For VT1708S and VT1702, deactivate "Headphone Playback Volume" and
"Headphone Playback Mute" control if "Independent HP" mode is OFF.
and rename VT1702 "Independent HP" text.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -572,6 +572,18 @@
 	return 0;
 }

+static void activate_ctl(struct hda_codec *codec, const char *name, int active)
+{
+	struct snd_kcontrol *ctl = snd_hda_find_mixer_ctl(codec, name);
+	if (ctl) {
+		ctl->vd[0].access &= SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+		ctl->vd[0].access |= active
+			? 0 : SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+		snd_ctl_notify(codec->bus->card,
+			       SNDRV_CTL_EVENT_MASK_VALUE, &ctl->id);
+	}
+}
+
 static int via_independent_hp_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
@@ -620,6 +632,14 @@
 						   spec->multiout.hp_nid,
 						   0, 0, 0);

+	/* update HP volume/swtich active state */
+	if (spec->codec_type == VT1708S
+	    || spec->codec_type == VT1702) {
+		activate_ctl(codec, "Headphone Playback Volume",
+			     spec->hp_independent_mode);
+		activate_ctl(codec, "Headphone Playback Switch",
+			     spec->hp_independent_mode);
+	}
 	return 0;
 }

@@ -3342,11 +3362,11 @@

 static int vt1702_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
 {
-	int err;
-
+	int err, i;
+	struct hda_input_mux *imux;
+	static const char *texts[] = { "ON", "OFF", NULL};
 	if (!pin)
 		return 0;
-
 	spec->multiout.hp_nid = 0x1D;

 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
@@ -3361,8 +3381,18 @@
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
