From: Adam Richter <adam_richter2004@yahoo.com>
Subject: Re: Possible fix for snd-hda-intel model=no-jd failing
	since ~linux-3.9-rc1
Date: Thu, 11 Sep 2014 21:30:25 -0700
Message-ID: <1410496225.69683.YahooMailBasic@web160606.mail.bf1.yahoo.com>
References: <s5hiokuxw7u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm1-vm1.bullet.mail.bf1.yahoo.com
 (nm1-vm1.bullet.mail.bf1.yahoo.com [98.139.213.163])
 by alsa0.perex.cz (Postfix) with ESMTP id B2773265171
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 06:30:26 +0200 (CEST)
In-Reply-To: <s5hiokuxw7u.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi.

I confirm that your patch, quoted below, eliminated the symptom.

Please feel free to ask me to test other patches related to this problem.

Also, by the way, it appears that linux-3.17-rc4's Intel "high defintiion a=
udio" driver, regardless of whether this patch is applied, no longer shows =
Linux input subsystem devices for analog audio jack sense, although it does=
 provide such a device for HDMI jack sense.  If that's a bug, it's complete=
ly separate, but I mention it here in case it's relevant to integrating a f=
ix to this issue.

Thanks to you and David for your prompt and careful attention this bug once=
 I brought it to this mailing list.

Adam Richter


 At Thu, 11 Sep 2014 12:07:43 +0200,
 Takashi Iwai wrote:
 =

 > --
 > diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmat=
el.c
 > index f26ec04a29b5..526b5d39a2cb 100644
 > --- a/sound/pci/hda/patch_sigmatel.c
 > +++ b/sound/pci/hda/patch_sigmatel.c
 > @@ -565,8 +565,8 @@ static void stac_init_power_map(struct hda_codec *co=
dec)
 >=A0 =A0=A0=A0 =A0=A0=A0 if (snd_hda_jack_tbl_get(codec, nid))
 >=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 continue;
 >=A0 =A0=A0=A0 =A0=A0=A0 if (def_conf =3D=3D AC_JACK_PORT_COMPLEX &&
 > -=A0=A0=A0 =A0=A0=A0 =A0  !(spec->vref_mute_led_nid =3D=3D nid ||
 > -=A0=A0=A0 =A0=A0=A0 =A0  =A0 is_jack_detectable(codec, nid))) {
 > +=A0=A0=A0 =A0=A0=A0 =A0 spec->vref_mute_led_nid !=3D nid &&
 > +=A0=A0=A0 =A0=A0=A0 =A0 is_jack_detectable(codec, nid)) {
 >=A0 =A0=A0=A0 =A0=A0=A0 snd_hda_jack_detect_enable_callback(codec, nid,
 >=A0 =A0=A0=A0 =A0=A0=A0 STAC_PWR_EVENT,
 >=A0 =A0=A0=A0 =A0=A0=A0 jack_update_power);
 > @@ -4272,11 +4272,17 @@ static int
 stac_parse_auto_config(struct hda_codec *codec)
 >=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return err;
 >=A0 =A0=A0=A0 }
 >=A0 =

 > -=A0=A0=A0 stac_init_power_map(codec);
 > -
 >=A0 =A0=A0=A0 return 0;
 >=A0 }
 >=A0 =

 > +static int stac_build_controls(struct hda_codec *codec)
 > +{
 > +=A0=A0=A0 int err =3D
 snd_hda_gen_build_controls(codec);
 > +=A0=A0=A0 if (err < 0)
 > +=A0=A0=A0 =A0=A0=A0 return err;
 > +=A0=A0=A0 stac_init_power_map(codec);
 > +=A0=A0=A0 return 0;
 > +}
 >=A0 =

 >=A0 static int stac_init(struct hda_codec *codec)
 >=A0 {
 > @@ -4388,7 +4394,7 @@ static int stac_suspend(struct hda_codec *codec)
 >=A0 #endif /* CONFIG_PM */
 >=A0 =

 >=A0 static const struct hda_codec_ops stac_patch_ops =3D {
 > -=A0=A0=A0 .build_controls =3D snd_hda_gen_build_controls,
 > +=A0=A0=A0 .build_controls =3D stac_build_controls,
 >=A0 =A0=A0=A0 .build_pcms =3D snd_hda_gen_build_pcms,
 >=A0 =A0=A0=A0 .init =3D stac_init,
 >=A0 =A0=A0=A0 .free =3D stac_free,
 =
