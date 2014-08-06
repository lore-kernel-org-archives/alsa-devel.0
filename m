From: Vincent Lejeune <vljn@ovi.com>
Subject: Re: ASUS Phoebus (CMI8888) HDA Support
Date: Wed, 6 Aug 2014 09:05:59 -0700
Message-ID: <1407341159.95474.YahooMailNeo@web161501.mail.bf1.yahoo.com>
References: <1407099944.1470.YahooMailNeo@web161503.mail.bf1.yahoo.com>
 <s5h1tswwl3e.wl%tiwai@suse.de>
 <1407177031.13342.YahooMailNeo@web161506.mail.bf1.yahoo.com>
 <s5htx5s2hxd.wl%tiwai@suse.de>
 <1407181440.71480.YahooMailNeo@web161503.mail.bf1.yahoo.com>
 <s5hoavz2yuu.wl%tiwai@suse.de>
 <1407277580.23740.YahooMailNeo@web161505.mail.bf1.yahoo.com>
 <s5hd2ce2kpr.wl%tiwai@suse.de> <s5hwqal4wts.wl%tiwai@suse.de>
Reply-To: Vincent Lejeune <vljn@ovi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm4.bullet.mail.bf1.yahoo.com (nm4.bullet.mail.bf1.yahoo.com
 [98.139.212.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 835E72615F3
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 18:06:01 +0200 (CEST)
In-Reply-To: <s5hwqal4wts.wl%tiwai@suse.de>
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

Ok thank.

How can I change GPIOs value ? It looks like the option is not present anym=
ore as hints string option in kernel 3.17. Looking in the realtek patch cod=
e suggest to use snd_hda_sequence_write in the patch_cmi8888 function.



Le Mercredi 6 ao=FBt 2014 14h39, Takashi Iwai <tiwai@suse.de> a =E9crit :
 =


>
>
>At Wed, 06 Aug 2014 08:30:56 +0200,
>Takashi Iwai wrote:
>> =

>> At Tue, 5 Aug 2014 15:26:20 -0700,
>> Vincent Lejeune wrote:
>> > =

>> > With this patch, volume is still low but the error message in dmesg di=
sappeared.
>> > I attached an updated alsa-info.txt report. I removed the probe_mask i=
n modprobe.conf.d file so the hdmi output of my video card also appears now.
>> =

>> Is the volume also low from the headphone output?
>> There is no EAPD control found in the codec pins, so the rest
>> possibility is either GPIO or vendor-specific verbs.=A0 Try to adjust
>> each GPIO pin on/off at first.
>
>In anyway, I'm going to merge the fix patch as is.=A0 It's much better
>than nothing.=A0 Let's handle the too-low-volume problem separately.
>
>
>
>Takashi
>
>> =

>> =

>> Takashi
>> =

>> > =

>> > =

>> > =

>> > =

>> > Le Mardi 5 ao=FBt 2014 9h25, Takashi Iwai <tiwai@suse.de> a =E9crit :
>> >=A0 =

>> > =

>> > >
>> > >
>> > >At Mon, 4 Aug 2014 12:44:00 -0700,
>> > >Vincent Lejeune wrote:
>> > >> =

>> > >> Here it is.
>> > >
>> > >OK, blow is an untested fix patch, based on the latest sound git
>> > >tree.=A0 For applying to the older kernels, you may need some manual
>> > >adjustment.
>> > >
>> > >
>> > >Takashi
>> > >
>> > >---
>> > >diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> > >index 5db1948699d8..aa302fb03fc5 100644
>> > >--- a/sound/pci/hda/hda_intel.c
>> > >+++ b/sound/pci/hda/hda_intel.c
>> > >@@ -265,6 +265,7 @@ enum {
>> > >=A0=A0=A0 AZX_DRIVER_TERA,
>> > >=A0=A0=A0 AZX_DRIVER_CTX,
>> > >=A0=A0=A0 AZX_DRIVER_CTHDA,
>> > >+=A0=A0=A0 AZX_DRIVER_CMEDIA,
>> > >=A0=A0=A0 AZX_DRIVER_GENERIC,
>> > >=A0=A0=A0 AZX_NUM_DRIVERS, /* keep this as last entry */
>> > >};
>> > >@@ -330,6 +331,7 @@ static char *driver_short_names[] =3D {
>> > >=A0=A0=A0 [AZX_DRIVER_TERA] =3D "HDA Teradici", =

>> > >=A0=A0=A0 [AZX_DRIVER_CTX] =3D "HDA Creative", =

>> > >=A0=A0=A0 [AZX_DRIVER_CTHDA] =3D "HDA Creative",
>> > >+=A0=A0=A0 [AZX_DRIVER_CMEDIA] =3D "HDA C-Media",
>> > >=A0=A0=A0 [AZX_DRIVER_GENERIC] =3D "HD-Audio Generic",
>> > >};
>> > >
>> > >@@ -1373,6 +1375,7 @@ static void azx_check_snoop_available(struct az=
x *chip)
>> > >=A0=A0=A0 =A0=A0=A0 snoop =3D false;
>> > >=A0=A0=A0 =A0=A0=A0 break;
>> > >=A0=A0=A0 case AZX_DRIVER_CTHDA:
>> > >+=A0=A0=A0 case AZX_DRIVER_CMEDIA:
>> > >=A0=A0=A0 =A0=A0=A0 snoop =3D false;
>> > >=A0=A0=A0 =A0=A0=A0 break;
>> > >=A0=A0=A0 }
>> > >@@ -2154,6 +2157,10 @@ static const struct pci_device_id azx_ids[] =
=3D {
>> > >=A0=A0=A0 =A0 .driver_data =3D AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKARO=
UND |
>> > >=A0=A0=A0 =A0 AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_POSFIX_LPIB },
>> > >#endif
>> > >+=A0=A0=A0 /* CM8888 */
>> > >+=A0=A0=A0 { PCI_DEVICE(0x13f6, 0x5011),
>> > >+=A0=A0=A0 =A0 .driver_data =3D AZX_DRIVER_CMEDIA |
>> > >+=A0=A0=A0 =A0 AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB },
>> > >=A0=A0=A0 /* Vortex86MX */
>> > >=A0=A0=A0 { PCI_DEVICE(0x17f3, 0x3010), .driver_data =3D AZX_DRIVER_G=
ENERIC },
>> > >=A0=A0=A0 /* VMware HDAudio */
>> > >diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedi=
a.c
>> > >index ed3d133ffbb6..3ed5d5613bc1 100644
>> > >--- a/sound/pci/hda/patch_cmedia.c
>> > >+++ b/sound/pci/hda/patch_cmedia.c
>> > >@@ -75,15 +75,62 @@ static int patch_cmi9880(struct hda_codec *codec)
>> > >=A0=A0=A0 return err;
>> > >}
>> > >
>> > >+static int patch_cmi8888(struct hda_codec *codec)
>> > >+{
>> > >+=A0=A0=A0 struct cmi_spec *spec;
>> > >+=A0=A0=A0 struct auto_pin_cfg *cfg;
>> > >+=A0=A0=A0 int err;
>> > >+
>> > >+=A0=A0=A0 spec =3D kzalloc(sizeof(*spec), GFP_KERNEL);
>> > >+=A0=A0=A0 if (!spec)
>> > >+=A0=A0=A0 =A0=A0=A0 return -ENOMEM;
>> > >+
>> > >+=A0=A0=A0 codec->spec =3D spec;
>> > >+=A0=A0=A0 cfg =3D &spec->gen.autocfg;
>> > >+=A0=A0=A0 snd_hda_gen_spec_init(&spec->gen);
>> > >+
>> > >+=A0=A0=A0 /* mask NID 0x10 from the playback volume selection;
>> > >+=A0=A0=A0=A0 * it's a headphone boost volume handled manually below
>> > >+=A0=A0=A0=A0 */
>> > >+=A0=A0=A0 spec->gen.out_vol_mask =3D (1ULL << 0x10);
>> > >+
>> > >+=A0=A0=A0 err =3D snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
>> > >+=A0=A0=A0 if (err < 0)
>> > >+=A0=A0=A0 =A0=A0=A0 goto error;
>> > >+=A0=A0=A0 err =3D snd_hda_gen_parse_auto_config(codec, cfg);
>> > >+=A0=A0=A0 if (err < 0)
>> > >+=A0=A0=A0 =A0=A0=A0 goto error;
>> > >+
>> > >+=A0=A0=A0 if (get_defcfg_device(snd_hda_codec_get_pincfg(codec, 0x10=
)) =3D=3D
>> > >+=A0=A0=A0 =A0 =A0 AC_JACK_HP_OUT) {
>> > >+=A0=A0=A0 =A0=A0=A0 static const struct snd_kcontrol_new amp_kctl =
=3D
>> > >+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 HDA_CODEC_VOLUME("Headphone Amp Playba=
ck Volume",
>> > >+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 0x10, 0, HDA_OU=
TPUT);
>> > >+=A0=A0=A0 =A0=A0=A0 if (!snd_hda_gen_add_kctl(&spec->gen, NULL, &amp=
_kctl)) {
>> > >+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 err =3D -ENOMEM;
>> > >+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 goto error;
>> > >+=A0=A0=A0 =A0=A0=A0 }
>> > >+=A0=A0=A0 }
>> > >+
>> > >+=A0=A0=A0 codec->patch_ops =3D cmi_auto_patch_ops;
>> > >+=A0=A0=A0 return 0;
>> > >+
>> > >+ error:
>> > >+=A0=A0=A0 snd_hda_gen_free(codec);
>> > >+=A0=A0=A0 return err;
>> > >+}
>> > >+
>> > >/*
>> > >=A0 * patch entries
>> > >=A0 */
>> > >static const struct hda_codec_preset snd_hda_preset_cmedia[] =3D {
>> > >+=A0=A0=A0 { .id =3D 0x13f68888, .name =3D "CMI8888", .patch =3D patc=
h_cmi8888 },
>> > >=A0=A0=A0 { .id =3D 0x13f69880, .name =3D "CMI9880", .patch =3D patch=
_cmi9880 },
>> > >=A0 =A0=A0=A0 { .id =3D 0x434d4980, .name =3D "CMI9880", .patch =3D p=
atch_cmi9880 },
>> > >=A0=A0=A0 {} /* terminator */
>> > >};
>> > >
>> > >+MODULE_ALIAS("snd-hda-codec-id:13f68888");
>> > >MODULE_ALIAS("snd-hda-codec-id:13f69880");
>> > >MODULE_ALIAS("snd-hda-codec-id:434d4980");
>> > >
>> > >
>> > >_______________________________________________
>> > >Alsa-devel mailing list
>> > >Alsa-devel@alsa-project.org
>> > >http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> > >
>> > >
>> > >
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@alsa-project.org
>http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>
