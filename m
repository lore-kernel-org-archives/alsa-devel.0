From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Wed, 4 Feb 2009 15:40:45 -0200
Message-ID: <200902041540.46137.herton@mandriva.com.br>
References: <4983FE7A.1040201@wanadoo.fr> <4989C9E6.7070902@wanadoo.fr>
	<s5h1vue86ys.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eMdiJ2nCGCFUghi"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 8463D1038DA
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 18:40:35 +0100 (CET)
In-Reply-To: <s5h1vue86ys.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, tim.barnette@gmail.com, Jean-Pierre =?iso-8859-1?q?Andr=E9?= <jean-pierre.andre@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_eMdiJ2nCGCFUghi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Em Quarta-feira 04 Fevereiro 2009, =E0s 15:09:15, Takashi Iwai escreveu:
> At Wed, 04 Feb 2009 18:01:26 +0100,
>
> Jean-Pierre Andr=E9 wrote:
> > Hi Herton,
> >
> > I have identified why applying your patch broke the sound worse on my
> > computer, by reverting each individual modification until the sound
> > comes back. It has not brought overall improvements for me, but this
> > might help you getting it right.
>
> Oh well.
>
> Herton, could you rebase the patch against the latest sound tree?
> The patch rejects awfully, so hard to test...

I've done now the rebased/splitted patches, was slow at verifying/reviewing=
=20
things but I think it's now good. In my previous patch to me I saw that was=
=20
doing some uneeded things, also was better to reuse patch_stac92hd71bxx=20
instead of splitting 4port/5port support/differences away. I removed the pi=
n=20
configs for HP models too, it may be wrong/uneeded or cause problems like i=
n=20
this case. Find attached now three patches with splitted fixes/enhancements=
,=20
but nothing that will help with the problem here unfortunately, I thought t=
he=20
previous patch with pin configs could help.

>
> > On my computer, the main problem is an IRQ one, which I knew you did
> > not address, but I still wanted to know if something would improve
> > (see below)
>
> You can pass enable_msi=3D1 option instead of patching hda_intel.c.
> If it doesn't solve the IRQ problem, it must be in a pretty deep level.
>
> > This was tested on a HP dv4-1115ef, with a sound device identified as :
> >
> > Codec: IDT 92HD71B7X
> > Codec: Generic 10de ID 3
>
> Hm, you didn't set CONFIG_SND_HDA_CODEC_NVHDMI=3Dy?
>
>
> Takashi

=2D-
[]'s
Herton

--Boundary-00=_eMdiJ2nCGCFUghi
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-ALSA-hda-Additional-pin-nids-for-STAC92HD71Bx-and.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Additional-pin-nids-for-STAC92HD71Bx-and.patch"

=46rom 1f0c1417a9acaffe9567b3f454ccd1395f978d8b Mon Sep 17 00:00:00 2001
=46rom: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Date: Wed, 4 Feb 2009 11:23:19 -0500
Subject: [PATCH 1/3] ALSA: hda - Additional pin nids for STAC92HD71Bx and S=
TAC92HD75Bx codecs

Current code for STAC92HD71Bx and STAC92HD75Bx doesn't consider pin
complexes 0x20 and 0x27. Also for 4 port models, nids 0x0e and 0x0f
are vendor reserved. This commit changes code so it'll consider the
additional pin complexes for models that have it, and avoid reserved
nids to be touched on 4 port models.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
=2D--
 sound/pci/hda/patch_sigmatel.c |   59 +++++++++++++++++++++++++++++-------=
=2D---
 1 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index a7df81e..58c9ff9 100644
=2D-- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -481,10 +481,17 @@ static hda_nid_t stac92hd83xxx_pin_nids[14] =3D {
 	0x0f, 0x10, 0x11, 0x12, 0x13,
 	0x1d, 0x1e, 0x1f, 0x20
 };
=2Dstatic hda_nid_t stac92hd71bxx_pin_nids[11] =3D {
+
+#define STAC92HD71BXX_NUM_PINS 13
+static hda_nid_t stac92hd71bxx_pin_nids_4port[STAC92HD71BXX_NUM_PINS] =3D {
+	0x0a, 0x0b, 0x0c, 0x0d, 0x00,
+	0x00, 0x14, 0x18, 0x19, 0x1e,
+	0x1f, 0x20, 0x27
+};
+static hda_nid_t stac92hd71bxx_pin_nids_6port[STAC92HD71BXX_NUM_PINS] =3D {
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x14, 0x18, 0x19, 0x1e,
=2D	0x1f,
+	0x1f, 0x20, 0x27
 };
=20
 static hda_nid_t stac927x_pin_nids[14] =3D {
@@ -1745,28 +1752,32 @@ static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[]=
 =3D {
 	{} /* terminator */
 };
=20
=2Dstatic unsigned int ref92hd71bxx_pin_configs[11] =3D {
+static unsigned int ref92hd71bxx_pin_configs[STAC92HD71BXX_NUM_PINS] =3D {
 	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
 	0x0181302e, 0x01014010, 0x01019020, 0x90a000f0,
=2D	0x90a000f0, 0x01452050, 0x01452050,
+	0x90a000f0, 0x01452050, 0x01452050, 0x00000000,
+	0x00000000
 };
=20
=2Dstatic unsigned int dell_m4_1_pin_configs[11] =3D {
+static unsigned int dell_m4_1_pin_configs[STAC92HD71BXX_NUM_PINS] =3D {
 	0x0421101f, 0x04a11221, 0x40f000f0, 0x90170110,
 	0x23a1902e, 0x23014250, 0x40f000f0, 0x90a000f0,
=2D	0x40f000f0, 0x4f0000f0, 0x4f0000f0,
+	0x40f000f0, 0x4f0000f0, 0x4f0000f0, 0x00000000,
+	0x00000000
 };
=20
=2Dstatic unsigned int dell_m4_2_pin_configs[11] =3D {
+static unsigned int dell_m4_2_pin_configs[STAC92HD71BXX_NUM_PINS] =3D {
 	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
 	0x23a1902e, 0x23014250, 0x40f000f0, 0x40f000f0,
=2D	0x40f000f0, 0x044413b0, 0x044413b0,
+	0x40f000f0, 0x044413b0, 0x044413b0, 0x00000000,
+	0x00000000
 };
=20
=2Dstatic unsigned int dell_m4_3_pin_configs[11] =3D {
+static unsigned int dell_m4_3_pin_configs[STAC92HD71BXX_NUM_PINS] =3D {
 	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
 	0x40f000f0, 0x40f000f0, 0x40f000f0, 0x90a000f0,
=2D	0x40f000f0, 0x044413b0, 0x044413b0,
+	0x40f000f0, 0x044413b0, 0x044413b0, 0x00000000,
+	0x00000000
 };
=20
 static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] =3D {
@@ -2311,7 +2322,9 @@ static int stac92xx_save_bios_config_regs(struct hda_=
codec *codec)
 	for (i =3D 0; i < spec->num_pins; i++) {
 		hda_nid_t nid =3D spec->pin_nids[i];
 		unsigned int pin_cfg;
=2D	=09
+
+		if (!nid)
+			continue;
 		pin_cfg =3D snd_hda_codec_read(codec, nid, 0,=20
 			AC_VERB_GET_CONFIG_DEFAULT, 0x00);=09
 		snd_printdd(KERN_INFO "hda_codec: pin nid %2.2x bios pin config %8.8x\n",
@@ -2354,8 +2367,9 @@ static void stac92xx_set_config_regs(struct hda_codec=
 *codec)
  		return;
=20
 	for (i =3D 0; i < spec->num_pins; i++)
=2D		stac92xx_set_config_reg(codec, spec->pin_nids[i],
=2D					spec->pin_configs[i]);
+		if (spec->pin_nids[i] && spec->pin_configs[i])
+			stac92xx_set_config_reg(codec, spec->pin_nids[i],
+						spec->pin_configs[i]);
 }
=20
 static int stac_save_pin_cfgs(struct hda_codec *codec, unsigned int *pins)
@@ -4952,9 +4966,21 @@ static int patch_stac92hd71bxx(struct hda_codec *cod=
ec)
=20
 	codec->spec =3D spec;
 	codec->patch_ops =3D stac92xx_patch_ops;
=2D	spec->num_pins =3D ARRAY_SIZE(stac92hd71bxx_pin_nids);
+	spec->num_pins =3D STAC92HD71BXX_NUM_PINS;
+	switch (codec->vendor_id) {
+	case 0x111d76b6:
+	case 0x111d76b7:
+		spec->pin_nids =3D stac92hd71bxx_pin_nids_4port;
+		break;
+	case 0x111d7603:
+	case 0x111d7608:
+		/* On 92HD75Bx 0x27 isn't a pin nid */
+		spec->num_pins--;
+		/* fallthrough */
+	default:
+		spec->pin_nids =3D stac92hd71bxx_pin_nids_6port;
+	}
 	spec->num_pwrs =3D ARRAY_SIZE(stac92hd71bxx_pwr_nids);
=2D	spec->pin_nids =3D stac92hd71bxx_pin_nids;
 	memcpy(&spec->private_dimux, &stac92hd71bxx_dmux,
 			sizeof(stac92hd71bxx_dmux));
 	spec->board_config =3D snd_hda_check_board_config(codec,
@@ -5018,7 +5044,8 @@ again:
 		/* disable VSW */
 		spec->init =3D &stac92hd71bxx_analog_core_init[HD_DISABLE_PORTF];
 		unmute_init++;
=2D		stac_change_pin_config(codec, 0xf, 0x40f000f0);
+		stac_change_pin_config(codec, 0x0f, 0x40f000f0);
+		stac_change_pin_config(codec, 0x19, 0x40f000f3);
 		break;
 	case 0x111d7603: /* 6 Port with Analog Mixer */
 		if ((codec->revision_id & 0xf) =3D=3D 1)
=2D-=20
1.6.1.2


--Boundary-00=_eMdiJ2nCGCFUghi
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-ALSA-hda-Dynamic-detection-of-dmics-dmuxes-smuxes.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-ALSA-hda-Dynamic-detection-of-dmics-dmuxes-smuxes.patch"

=46rom d4e2417aa7ec8f7022143d04566ecf7f1e3d3553 Mon Sep 17 00:00:00 2001
=46rom: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Date: Wed, 4 Feb 2009 11:34:22 -0500
Subject: [PATCH 2/3] ALSA: hda - Dynamic detection of dmics/dmuxes/smuxes i=
n stac92hd71bxx

Detect the number of connected ports and number of smuxes dynamically,
looking at pin configs, using new introduced functions
stac92hd71bxx_connected_ports and stac92hd71bxx_connected_smuxes. Also
use proper input mux configuration for 4port and 5port models.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
=2D--
 sound/pci/hda/patch_sigmatel.c |   99 +++++++++++++++++++++++++++++++++++-=
=2D---
 1 files changed, 87 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 58c9ff9..c36c1c0 100644
=2D-- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4944,7 +4944,16 @@ again:
 	return 0;
 }
=20
=2Dstatic struct hda_input_mux stac92hd71bxx_dmux =3D {
+static struct hda_input_mux stac92hd71bxx_dmux_nomixer =3D {
+	.num_items =3D 3,
+	.items =3D {
+		{ "Analog Inputs", 0x00 },
+		{ "Digital Mic 1", 0x02 },
+		{ "Digital Mic 2", 0x03 },
+	}
+};
+
+static struct hda_input_mux stac92hd71bxx_dmux_amixer =3D {
 	.num_items =3D 4,
 	.items =3D {
 		{ "Analog Inputs", 0x00 },
@@ -4954,11 +4963,57 @@ static struct hda_input_mux stac92hd71bxx_dmux =3D {
 	}
 };
=20
+static int stac92hd71bxx_connected_ports(struct hda_codec *codec,
+					 hda_nid_t *nids, int num_nids)
+{
+	struct sigmatel_spec *spec =3D codec->spec;
+	int idx, num;
+	unsigned int def_conf;
+
+	for (num =3D 0; num < num_nids; num++) {
+		for (idx =3D 0; idx < spec->num_pins; idx++)
+			if (spec->pin_nids[idx] =3D=3D nids[num])
+				break;
+		if (idx >=3D spec->num_pins)
+			break;
+		def_conf =3D get_defcfg_connect(spec->pin_configs[idx]);
+		if (def_conf =3D=3D AC_JACK_PORT_NONE)
+			break;
+	}
+	return num;
+}
+
+static int stac92hd71bxx_connected_smuxes(struct hda_codec *codec,
+					  hda_nid_t dig0pin)
+{
+	struct sigmatel_spec *spec =3D codec->spec;
+	int idx;
+
+	for (idx =3D 0; idx < spec->num_pins; idx++)
+		if (spec->pin_nids[idx] =3D=3D dig0pin)
+			break;
+	if ((idx + 2) >=3D spec->num_pins)
+		return 0;
+
+	/* dig1pin case */
+	if (get_defcfg_connect(spec->pin_configs[idx+1]) !=3D AC_JACK_PORT_NONE)
+		return 2;
+
+	/* dig0pin + dig2pin case */
+	if (get_defcfg_connect(spec->pin_configs[idx+2]) !=3D AC_JACK_PORT_NONE)
+		return 2;
+	if (get_defcfg_connect(spec->pin_configs[idx]) !=3D AC_JACK_PORT_NONE)
+		return 1;
+	else
+		return 0;
+}
+
 static int patch_stac92hd71bxx(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
 	struct hda_verb *unmute_init =3D stac92hd71bxx_unmute_core_init;
 	int err =3D 0;
+	unsigned int ndmic_nids =3D 0;
=20
 	spec  =3D kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec =3D=3D NULL)
@@ -4981,8 +5036,6 @@ static int patch_stac92hd71bxx(struct hda_codec *code=
c)
 		spec->pin_nids =3D stac92hd71bxx_pin_nids_6port;
 	}
 	spec->num_pwrs =3D ARRAY_SIZE(stac92hd71bxx_pwr_nids);
=2D	memcpy(&spec->private_dimux, &stac92hd71bxx_dmux,
=2D			sizeof(stac92hd71bxx_dmux));
 	spec->board_config =3D snd_hda_check_board_config(codec,
 							STAC_92HD71BXX_MODELS,
 							stac92hd71bxx_models,
@@ -5007,16 +5060,32 @@ again:
 		spec->gpio_data =3D 0x01;
 	}
=20
+	spec->dmic_nids =3D stac92hd71bxx_dmic_nids;
+	spec->dmux_nids =3D stac92hd71bxx_dmux_nids;
+
 	switch (codec->vendor_id) {
 	case 0x111d76b6: /* 4 Port without Analog Mixer */
 	case 0x111d76b7:
 	case 0x111d76b4: /* 6 Port without Analog Mixer */
 	case 0x111d76b5:
+		memcpy(&spec->private_dimux, &stac92hd71bxx_dmux_nomixer,
+		       sizeof(stac92hd71bxx_dmux_nomixer));
 		spec->mixer =3D stac92hd71bxx_mixer;
 		spec->init =3D stac92hd71bxx_core_init;
 		codec->slave_dig_outs =3D stac92hd71bxx_slave_dig_outs;
+		spec->num_dmics =3D stac92hd71bxx_connected_ports(codec,
+					stac92hd71bxx_dmic_nids,
+					STAC92HD71BXX_NUM_DMICS);
+		if (spec->num_dmics) {
+			spec->num_dmuxes =3D ARRAY_SIZE(stac92hd71bxx_dmux_nids);
+			spec->dinput_mux =3D &spec->private_dimux;
+			ndmic_nids =3D ARRAY_SIZE(stac92hd71bxx_dmic_nids) - 1;
+		}
 		break;
 	case 0x111d7608: /* 5 Port with Analog Mixer */
+		memcpy(&spec->private_dimux, &stac92hd71bxx_dmux_amixer,
+		       sizeof(stac92hd71bxx_dmux_amixer));
+		spec->private_dimux.num_items--;
 		switch (spec->board_config) {
 		case STAC_HP_M4:
 			/* Enable VREF power saving on GPIO1 detect */
@@ -5046,6 +5115,12 @@ again:
 		unmute_init++;
 		stac_change_pin_config(codec, 0x0f, 0x40f000f0);
 		stac_change_pin_config(codec, 0x19, 0x40f000f3);
+		stac92hd71bxx_dmic_nids[STAC92HD71BXX_NUM_DMICS - 1] =3D 0;
+		spec->num_dmics =3D stac92hd71bxx_connected_ports(codec,
+					stac92hd71bxx_dmic_nids,
+					STAC92HD71BXX_NUM_DMICS - 1);
+		spec->num_dmuxes =3D ARRAY_SIZE(stac92hd71bxx_dmux_nids);
+		ndmic_nids =3D ARRAY_SIZE(stac92hd71bxx_dmic_nids) - 2;
 		break;
 	case 0x111d7603: /* 6 Port with Analog Mixer */
 		if ((codec->revision_id & 0xf) =3D=3D 1)
@@ -5055,10 +5130,17 @@ again:
 		spec->num_pwrs =3D 0;
 		/* fallthru */
 	default:
+		memcpy(&spec->private_dimux, &stac92hd71bxx_dmux_amixer,
+		       sizeof(stac92hd71bxx_dmux_amixer));
 		spec->dinput_mux =3D &spec->private_dimux;
 		spec->mixer =3D stac92hd71bxx_analog_mixer;
 		spec->init =3D stac92hd71bxx_analog_core_init;
 		codec->slave_dig_outs =3D stac92hd71bxx_slave_dig_outs;
+		spec->num_dmics =3D stac92hd71bxx_connected_ports(codec,
+					stac92hd71bxx_dmic_nids,
+					STAC92HD71BXX_NUM_DMICS);
+		spec->num_dmuxes =3D ARRAY_SIZE(stac92hd71bxx_dmux_nids);
+		ndmic_nids =3D ARRAY_SIZE(stac92hd71bxx_dmic_nids) - 1;
 	}
=20
 	if (get_wcaps(codec, 0xa) & AC_WCAP_IN_AMP)
@@ -5071,13 +5153,12 @@ again:
 	spec->digbeep_nid =3D 0x26;
 	spec->mux_nids =3D stac92hd71bxx_mux_nids;
 	spec->adc_nids =3D stac92hd71bxx_adc_nids;
=2D	spec->dmic_nids =3D stac92hd71bxx_dmic_nids;
=2D	spec->dmux_nids =3D stac92hd71bxx_dmux_nids;
 	spec->smux_nids =3D stac92hd71bxx_smux_nids;
 	spec->pwr_nids =3D stac92hd71bxx_pwr_nids;
=20
 	spec->num_muxes =3D ARRAY_SIZE(stac92hd71bxx_mux_nids);
 	spec->num_adcs =3D ARRAY_SIZE(stac92hd71bxx_adc_nids);
+	spec->num_smuxes =3D stac92hd71bxx_connected_smuxes(codec, 0x1e);
=20
 	switch (spec->board_config) {
 	case STAC_HP_M4:
@@ -5097,17 +5178,11 @@ again:
 		spec->num_smuxes =3D 0;
 		spec->num_dmuxes =3D 0;
 		break;
=2D	default:
=2D		spec->num_dmics =3D STAC92HD71BXX_NUM_DMICS;
=2D		spec->num_smuxes =3D ARRAY_SIZE(stac92hd71bxx_smux_nids);
=2D		spec->num_dmuxes =3D ARRAY_SIZE(stac92hd71bxx_dmux_nids);
 	};
=20
 	spec->multiout.dac_nids =3D spec->dac_nids;
 	if (spec->dinput_mux)
=2D		spec->private_dimux.num_items +=3D
=2D			spec->num_dmics -
=2D				(ARRAY_SIZE(stac92hd71bxx_dmic_nids) - 1);
+		spec->private_dimux.num_items +=3D spec->num_dmics - ndmic_nids;
=20
 	err =3D stac92xx_parse_auto_config(codec, 0x21, 0x23);
 	if (!err) {
=2D-=20
1.6.1.2


--Boundary-00=_eMdiJ2nCGCFUghi
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0003-ALSA-hda-Don-t-call-stac92xx_parse_auto_config-wi.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0003-ALSA-hda-Don-t-call-stac92xx_parse_auto_config-wi.patch"

=46rom b5f5f197575db773651d8e101dff15dc9cff8484 Mon Sep 17 00:00:00 2001
=46rom: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Date: Wed, 4 Feb 2009 11:37:27 -0500
Subject: [PATCH 3/3] ALSA: hda - Don't call stac92xx_parse_auto_config with=
 wrong dig_in

Don't use uneeded/wrong third parameter for stac92xx_parse_auto_config
in patch_stac92hd71bxx (no SPDIF in).

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
=2D--
 sound/pci/hda/patch_sigmatel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index c36c1c0..0b00110 100644
=2D-- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -5184,7 +5184,7 @@ again:
 	if (spec->dinput_mux)
 		spec->private_dimux.num_items +=3D spec->num_dmics - ndmic_nids;
=20
=2D	err =3D stac92xx_parse_auto_config(codec, 0x21, 0x23);
+	err =3D stac92xx_parse_auto_config(codec, 0x21, 0);
 	if (!err) {
 		if (spec->board_config < 0) {
 			printk(KERN_WARNING "hda_codec: No auto-config is "
=2D-=20
1.6.1.2


--Boundary-00=_eMdiJ2nCGCFUghi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_eMdiJ2nCGCFUghi--
