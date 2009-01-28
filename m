From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH] ALSA: hda - Consider additional capture
	source/selector in ALC889
Date: Wed, 28 Jan 2009 15:56:49 -0200
Message-ID: <200901281556.50512.herton@mandriva.com.br>
References: <200901280916.37234.herton@mandriva.com.br>
	<s5hmydbv471.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 11C6D103804
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 18:56:40 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 32F693EBE
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 12:56:54 -0500 (EST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id c1iybXV4lgvG for <alsa-devel@alsa-project.org>;
	Wed, 28 Jan 2009 12:56:53 -0500 (EST)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 865603EA6
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 12:56:53 -0500 (EST)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 1A9EF2F487
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 14:56:35 -0300 (BRT)
In-Reply-To: <s5hmydbv471.wl%tiwai@suse.de>
Content-Disposition: inline
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

Em Quarta-feira 28 Janeiro 2009, =E0s 13:30:10, Takashi Iwai escreveu:
> At Wed, 28 Jan 2009 09:16:33 -0200,
> Herton Ronaldo Krzesinski wrote:
> > =

> > Currently code for capture source support in ALC889 only considers
> > capture mixers. This change adds aditional support for ADC+selector
> > present in ALC889, taking into account also the presence of an
> > additional DMIC connection item in the selector.
> > =

> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
> > ---
> >  sound/pci/hda/patch_realtek.c |  105 ++++++++++++++++++++++++++++++---=
--------
> >  1 files changed, 77 insertions(+), 28 deletions(-)
> > =

> > Note: I did this patch without hardware to test on, just based on alsa-=
info.txt
> > from one machine with ALC889 plus the ALC889 datasheet available from
> > Realtek website, so this is just build tested.
> =

> Could you post that alsa-info output?  Then I can test it with
> hda-emu, too.

Ops, it's the /proc/asound/card0/codec#0 (not full alsa-info, just confused
myself) in this ticket: https://qa.mandriva.com/show_bug.cgi?id=3D45838
I have yet to check hda-emu, will test with it next time.

I did a patch for alsa 1.0.18 for the bug report, now I was converting it to
sound tree, by first adding this capture ADC+selector support and later to =
add
an additional model for acer 8930. Just didn't submit the patch with model
addition yet as it looks like the laptop has speakers for rear/clfe etc. and
I'm now waiting from feedback about this on the bug report, but for now the
patch with addition is this:

ALSA: hda - Add acer-aspire-alc889 model for ALC889 codecs

This adds a new model to handle Acer Aspire 8930, that slightly differs
from other ALC883/889 models. Currently it doesn't work as reported on
https://qa.mandriva.com/show_bug.cgi?id=3D45838

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_realtek.c |   61 +++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d81cb5e..8c0bd7e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -216,6 +216,7 @@ enum {
 	ALC883_ACER,
 	ALC883_ACER_ASPIRE,
 	ALC888_ACER_ASPIRE_4930G,
+	ALC889_ACER_ASPIRE,
 	ALC883_MEDION,
 	ALC883_MEDION_MD2,
 	ALC883_LAPTOP_EAPD,
@@ -7237,6 +7238,34 @@ static struct hda_input_mux alc883_asus_eee1601_capt=
ure_source =3D {
 	},
 };
 =

+static struct hda_input_mux alc889_acer_aspire_capture_source[3] =3D {
+	{
+		.num_items =3D 4,
+		.items =3D {
+			{ "Mic", 0x0 },
+			{ "Line", 0x02 },
+			{ "Mixer", 0x0a },
+			{ "Int DMic", 0x0b },
+		},
+	},
+	{
+		.num_items =3D 3,
+		.items =3D {
+			{ "Mic", 0x0 },
+			{ "Line", 0x02 },
+			{ "Mixer", 0x0a },
+		},
+	},
+	{
+		.num_items =3D 3,
+		.items =3D {
+			{ "Mic", 0x0 },
+			{ "Line", 0x02 },
+			{ "Mixer", 0x0a },
+		},
+	},
+};
+
 /*
  * 2ch mode
  */
@@ -8439,6 +8468,22 @@ static void alc883_eee1601_inithook(struct hda_codec=
 *codec)
 	alc883_eee1601_speaker_automute(codec);
 }
 =

+static struct hda_verb alc889_acer_aspire_verbs[] =3D {
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(5)},
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(6)},
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(7)},
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(8)},
+	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(9)},
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x15, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
+	/* This is Speaker Out, not Rear, so connect to Front */
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x24, AC_VERB_SET_CONNECT_SEL, 0x0b},
+	{ } /* end */
+};
+
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 #define alc883_loopbacks	alc880_loopbacks
 #endif
@@ -8463,6 +8508,7 @@ static const char *alc883_models[ALC883_MODEL_LAST] =
=3D {
 	[ALC883_ACER]		=3D "acer",
 	[ALC883_ACER_ASPIRE]	=3D "acer-aspire",
 	[ALC888_ACER_ASPIRE_4930G]	=3D "acer-aspire-4930g",
+	[ALC889_ACER_ASPIRE]	=3D "acer-aspire-alc889",
 	[ALC883_MEDION]		=3D "medion",
 	[ALC883_MEDION_MD2]	=3D "medion-md2",
 	[ALC883_LAPTOP_EAPD]	=3D "laptop-eapd",
@@ -8493,6 +8539,7 @@ static struct snd_pci_quirk alc883_cfg_tbl[] =3D {
 		ALC888_ACER_ASPIRE_4930G),
 	SND_PCI_QUIRK(0x1025, 0x013f, "Acer Aspire 5930G",
 		ALC888_ACER_ASPIRE_4930G),
+	SND_PCI_QUIRK(0x1025, 0x0145, "Acer Aspire 8930", ALC889_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0x015e, "Acer Aspire 6930G",
 		ALC888_ACER_ASPIRE_4930G),
 	SND_PCI_QUIRK(0x1025, 0, "Acer laptop", ALC883_ACER), /* default Acer */
@@ -8693,6 +8740,20 @@ static struct alc_config_preset alc883_presets[] =3D=
 {
 		.unsol_event =3D alc888_acer_aspire_4930g_unsol_event,
 		.init_hook =3D alc888_acer_aspire_4930g_automute,
 	},
+	[ALC889_ACER_ASPIRE] =3D {
+		.mixers =3D { alc883_acer_aspire_mixer },
+		.init_verbs =3D { alc883_init_verbs, alc880_gpio1_init_verbs,
+				alc889_acer_aspire_verbs },
+		.num_dacs =3D ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids =3D alc883_dac_nids,
+		.dig_out_nid =3D ALC883_DIGOUT_NID,
+		.num_channel_mode =3D ARRAY_SIZE(alc883_3ST_2ch_modes),
+		.channel_mode =3D alc883_3ST_2ch_modes,
+		.num_mux_defs =3D ARRAY_SIZE(alc889_acer_aspire_capture_source),
+		.input_mux =3D alc889_acer_aspire_capture_source,
+		.unsol_event =3D alc888_acer_aspire_4930g_unsol_event,
+		.init_hook =3D alc888_acer_aspire_4930g_automute,
+	},
 	[ALC883_MEDION] =3D {
 		.mixers =3D { alc883_fivestack_mixer,
 			    alc883_chmode_mixer },
-- =

1.6.1

> =

> Anyway, the patch is applied now.  Thanks!
> =

> =

> Takashi

--
[]'s
Herton
