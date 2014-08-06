From: Vincent Lejeune <vljn@ovi.com>
Subject: Re: ASUS Phoebus (CMI8888) HDA Support
Date: Wed, 6 Aug 2014 10:07:49 -0700
Message-ID: <1407344869.9841.YahooMailNeo@web161503.mail.bf1.yahoo.com>
References: <1407099944.1470.YahooMailNeo@web161503.mail.bf1.yahoo.com>
 <s5h1tswwl3e.wl%tiwai@suse.de>
 <1407177031.13342.YahooMailNeo@web161506.mail.bf1.yahoo.com>
 <s5htx5s2hxd.wl%tiwai@suse.de>
 <1407181440.71480.YahooMailNeo@web161503.mail.bf1.yahoo.com>
 <s5hoavz2yuu.wl%tiwai@suse.de>
 <1407277580.23740.YahooMailNeo@web161505.mail.bf1.yahoo.com>
 <s5hd2ce2kpr.wl%tiwai@suse.de> <s5hwqal4wts.wl%tiwai@suse.de>
 <1407341159.95474.YahooMailNeo@web161501.mail.bf1.yahoo.com>
 <s5hmwbh38l5.wl%tiwai@suse.de>
Reply-To: Vincent Lejeune <vljn@ovi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm35-vm0.bullet.mail.bf1.yahoo.com
 (nm35-vm0.bullet.mail.bf1.yahoo.com [72.30.238.72])
 by alsa0.perex.cz (Postfix) with ESMTP id D7891261691
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 19:07:50 +0200 (CEST)
In-Reply-To: <s5hmwbh38l5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

It looks like GPIO mask is frozen, I don't know why :

[vlj@localhost alsa]$ hda-verb /dev/snd/hwC1D1=A0 0x1 SET_GPIO_MASK 1
nid =3D 0x1, verb =3D 0x716, param =3D 0x1
value =3D 0x0
[vlj@localhost alsa]$ hda-verb /dev/snd/hwC1D1=A0 0x1 GET_GPIO_MASK 1
nid =3D 0x1, verb =3D 0xf16, param =3D 0x1
value =3D 0x0
[vlj@localhost alsa]$ =


hwC1D1 is the phoebus=A0 according to hda-verb /dev/snd/hwC1D1=A0 0x1 PARAM=
ETERS SUBSYSTEM_ID
and it reports 8 input gpio

[vlj@localhost alsa]$ hda-verb /dev/snd/hwC1D1=A0 0x1 PARAMETERS GPIO_CAP
nid =3D 0x1, verb =3D 0xf00, param =3D 0x11
value =3D 0x80000

but with mask set to 0, I can't pass any data to them...



Le Mercredi 6 ao=FBt 2014 18h08, Takashi Iwai <tiwai@suse.de> a =E9crit :
 =


>
>
>At Wed, 6 Aug 2014 09:05:59 -0700,
>Vincent Lejeune wrote:
>> =

>> Ok thank.
>> =

>> How can I change GPIOs value ? It looks like the option is not present a=
nymore as hints string option in kernel 3.17. Looking in the realtek patch =
code suggest to use snd_hda_sequence_write in the patch_cmi8888 function.
>
>Just use hda-verb or such to manipulate GPIO bits on the fly.
>
>
>Takashi
>
>> =

>> =

>> =

>> Le Mercredi 6 ao=FBt 2014 14h39, Takashi Iwai <tiwai@suse.de> a =E9crit :
>>=A0 =

>> =

>> >
>> >
>> >At Wed, 06 Aug 2014 08:30:56 +0200,
>> >Takashi Iwai wrote:
>> >> =

>> >> At Tue, 5 Aug 2014 15:26:20 -0700,
>> >> Vincent Lejeune wrote:
>> >> > =

>> >> > With this patch, volume is still low but the error message in dmesg=
 disappeared.
>> >> > I attached an updated alsa-info.txt report. I removed the probe_mas=
k in modprobe.conf.d file so the hdmi output of my video card also appears =
now.
>> >> =

>> >> Is the volume also low from the headphone output?
>> >> There is no EAPD control found in the codec pins, so the rest
>> >> possibility is either GPIO or vendor-specific verbs.=A0 Try to adjust
>> >> each GPIO pin on/off at first.
>> >
>> >In anyway, I'm going to merge the fix patch as is.=A0 It's much better
>> >than nothing.=A0 Let's handle the too-low-volume problem separately.
>> >
>> >
>> >
>> >Takashi
>> >
>> >> =

>> >> =

>> >> Takashi
>> >> =

>> >> > =

>> >> > =

>> >> > =

>> >> > =

>> >> > Le Mardi 5 ao=FBt 2014 9h25, Takashi Iwai <tiwai@suse.de> a =E9crit=
 :
>> >> >=A0 =

>> >> > =

>> >> > >
>> >> > >
>> >> > >At Mon, 4 Aug 2014 12:44:00 -0700,
>> >> > >Vincent Lejeune wrote:
>> >> > >> =

>> >> > >> Here it is.
>> >> > >
>> >> > >OK, blow is an untested fix patch, based on the latest sound git
>> >> > >tree.=A0 For applying to the older kernels, you may need some manu=
al
>> >> > >adjustment.
>> >> > >
>> >> > >
>> >> > >Takashi
>> >> > >
>> >> > >---
>> >> > >diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> >> > >index 5db1948699d8..aa302fb03fc5 100644
>> >> > >--- a/sound/pci/hda/hda_intel.c
>> >> > >+++ b/sound/pci/hda/hda_intel.c
>> >> > >@@ -265,6 +265,7 @@ enum {
>> >> > >=A0=A0=A0 AZX_DRIVER_TERA,
>> >> > >=A0=A0=A0 AZX_DRIVER_CTX,
>> >> > >=A0=A0=A0 AZX_DRIVER_CTHDA,
>> >> > >+=A0=A0=A0 AZX_DRIVER_CMEDIA,
>> >> > >=A0=A0=A0 AZX_DRIVER_GENERIC,
>> >> > >=A0=A0=A0 AZX_NUM_DRIVERS, /* keep this as last entry */
>> >> > >};
>> >> > >@@ -330,6 +331,7 @@ static char *driver_short_names[] =3D {
>> >> > >=A0=A0=A0 [AZX_DRIVER_TERA] =3D "HDA Teradici", =

>> >> > >=A0=A0=A0 [AZX_DRIVER_CTX] =3D "HDA Creative", =

>> >> > >=A0=A0=A0 [AZX_DRIVER_CTHDA] =3D "HDA Creative",
>> >> > >+=A0=A0=A0 [AZX_DRIVER_CMEDIA] =3D "HDA C-Media",
>> >> > >=A0=A0=A0 [AZX_DRIVER_GENERIC] =3D "HD-Audio Generic",
>> >> > >};
>> >> > >
>> >> > >@@ -1373,6 +1375,7 @@ static void azx_check_snoop_available(struct=
 azx *chip)
>> >> > >=A0=A0=A0 =A0=A0=A0 snoop =3D false;
>> >> > >=A0=A0=A0 =A0=A0=A0 break;
>> >> > >=A0=A0=A0 case AZX_DRIVER_CTHDA:
>> >> > >+=A0=A0=A0 case AZX_DRIVER_CMEDIA:
>> >> > >=A0=A0=A0 =A0=A0=A0 snoop =3D false;
>> >> > >=A0=A0=A0 =A0=A0=A0 break;
>> >> > >=A0=A0=A0 }
>> >> > >@@ -2154,6 +2157,10 @@ static const struct pci_device_id azx_ids[]=
 =3D {
>> >> > >=A0=A0=A0 =A0 .driver_data =3D AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORK=
AROUND |
>> >> > >=A0=A0=A0 =A0 AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_POSFIX_LPIB },
>> >> > >#endif
>> >> > >+=A0=A0=A0 /* CM8888 */
>> >> > >+=A0=A0=A0 { PCI_DEVICE(0x13f6, 0x5011),
>> >> > >+=A0=A0=A0 =A0 .driver_data =3D AZX_DRIVER_CMEDIA |
>> >> > >+=A0=A0=A0 =A0 AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB },
>> >> > >=A0=A0=A0 /* Vortex86MX */
>> >> > >=A0=A0=A0 { PCI_DEVICE(0x17f3, 0x3010), .driver_data =3D AZX_DRIVE=
R_GENERIC },
>> >> > >=A0=A0=A0 /* VMware HDAudio */
>> >> > >diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cm=
edia.c
>> >> > >index ed3d133ffbb6..3ed5d5613bc1 100644
>> >> > >--- a/sound/pci/hda/patch_cmedia.c
>> >> > >+++ b/sound/pci/hda/patch_cmedia.c
>> >> > >@@ -75,15 +75,62 @@ static int patch_cmi9880(struct hda_codec *cod=
ec)
>> >> > >=A0=A0=A0 return err;
>> >> > >}
>> >> > >
>> >> > >+static int patch_cmi8888(struct hda_codec *codec)
>> >> > >+{
>> >> > >+=A0=A0=A0 struct cmi_spec *spec;
>> >> > >+=A0=A0=A0 struct auto_pin_cfg *cfg;
>> >> > >+=A0=A0=A0 int err;
>> >> > >+
>> >> > >+=A0=A0=A0 spec =3D kzalloc(sizeof(*spec), GFP_KERNEL);
>> >> > >+=A0=A0=A0 if (!spec)
>> >> > >+=A0=A0=A0 =A0=A0=A0 return -ENOMEM;
>> >> > >+
>> >> > >+=A0=A0=A0 codec->spec =3D spec;
>> >> > >+=A0=A0=A0 cfg =3D &spec->gen.autocfg;
>> >> > >+=A0=A0=A0 snd_hda_gen_spec_init(&spec->gen);
>> >> > >+
>> >> > >+=A0=A0=A0 /* mask NID 0x10 from the playback volume selection;
>> >> > >+=A0=A0=A0=A0 * it's a headphone boost volume handled manually bel=
ow
>> >> > >+=A0=A0=A0=A0 */
>> >> > >+=A0=A0=A0 spec->gen.out_vol_mask =3D (1ULL << 0x10);
>> >> > >+
>> >> > >+=A0=A0=A0 err =3D snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
>> >> > >+=A0=A0=A0 if (err < 0)
>> >> > >+=A0=A0=A0 =A0=A0=A0 goto error;
>> >> > >+=A0=A0=A0 err =3D snd_hda_gen_parse_auto_config(codec, cfg);
>> >> > >+=A0=A0=A0 if (err < 0)
>> >> > >+=A0=A0=A0 =A0=A0=A0 goto error;
>> >> > >+
>> >> > >+=A0=A0=A0 if (get_defcfg_device(snd_hda_codec_get_pincfg(codec, 0=
x10)) =3D=3D
>> >> > >+=A0=A0=A0 =A0 =A0 AC_JACK_HP_OUT) {
>> >> > >+=A0=A0=A0 =A0=A0=A0 static const struct snd_kcontrol_new amp_kctl=
 =3D
>> >> > >+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 HDA_CODEC_VOLUME("Headphone Amp Pla=
yback Volume",
>> >> > >+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 0x10, 0, HDA=
_OUTPUT);
>> >> > >+=A0=A0=A0 =A0=A0=A0 if (!snd_hda_gen_add_kctl(&spec->gen, NULL, &=
amp_kctl)) {
>> >> > >+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 err =3D -ENOMEM;
>> >> > >+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 goto error;
>> >> > >+=A0=A0=A0 =A0=A0=A0 }
>> >> > >+=A0=A0=A0 }
>> >> > >+
>> >> > >+=A0=A0=A0 codec->patch_ops =3D cmi_auto_patch_ops;
>> >> > >+=A0=A0=A0 return 0;
>> >> > >+
>> >> > >+ error:
>> >> > >+=A0=A0=A0 snd_hda_gen_free(codec);
>> >> > >+=A0=A0=A0 return err;
>> >> > >+}
>> >> > >+
>> >> > >/*
>> >> > >=A0 * patch entries
>> >> > >=A0 */
>> >> > >static const struct hda_codec_preset snd_hda_preset_cmedia[] =3D {
>> >> > >+=A0=A0=A0 { .id =3D 0x13f68888, .name =3D "CMI8888", .patch =3D p=
atch_cmi8888 },
>> >> > >=A0=A0=A0 { .id =3D 0x13f69880, .name =3D "CMI9880", .patch =3D pa=
tch_cmi9880 },
>> >> > >=A0 =A0=A0=A0 { .id =3D 0x434d4980, .name =3D "CMI9880", .patch =
=3D patch_cmi9880 },
>> >> > >=A0=A0=A0 {} /* terminator */
>> >> > >};
>> >> > >
>> >> > >+MODULE_ALIAS("snd-hda-codec-id:13f68888");
>> >> > >MODULE_ALIAS("snd-hda-codec-id:13f69880");
>> >> > >MODULE_ALIAS("snd-hda-codec-id:434d4980");
>> >> > >
>> >> > >
>> >> > >_______________________________________________
>> >> > >Alsa-devel mailing list
>> >> > >Alsa-devel@alsa-project.org
>> >> > >http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >> > >
>> >> > >
>> >> > >
>> >_______________________________________________
>> >Alsa-devel mailing list
>> >Alsa-devel@alsa-project.org
>> >http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >
>> >
>> >
>> [2=A0 <text/html; iso-8859-1 (quoted-printable)>]
>
>> =

>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@alsa-project.org
>http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>
