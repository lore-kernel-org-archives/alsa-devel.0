From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: add RT286 CODEC driver
Date: Fri, 7 Feb 2014 12:51:03 +0000
Message-ID: <20140207125103.GJ32298@sirena.org.uk>
References: <1386727090-15543-1-git-send-email-bardliao@realtek.com>
 <20131218192040.GN31886@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D702946A@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3889825590600339424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0965E26507D
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 13:52:14 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D702946A@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, "leon@leon.nu" <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org


--===============3889825590600339424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="95sqq/H8MHju+kJM"
Content-Disposition: inline


--95sqq/H8MHju+kJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2014 at 07:27:44AM +0000, Bard Liao wrote:

> > > +	if (rt286->pdata.irq_en)
> > > +		rt286_index_update_bits(codec,
> > > +			NODE_ID_VENDOR_REGISTERS, 0x33, 0x0002, 0x0002);

> > Why would the system ever want to supply an interrupt and not use it?

> The codec support a configurable irq pin which can be disable or enable.
> Some customers may not use it.
> So, I add a flag in platform data to configure it.

Should it not be possible to do this based on if an interrupt is
specified - why is a separate configuration option needed for this
when the user also needs to specify if an interrupt is used and which
interrupt is used?

> > > +static int rt286_hp_event(struct snd_soc_dapm_widget *w,
> > > +			   struct snd_kcontrol *kcontrol, int event) {
> > > +	struct snd_soc_codec *codec =3D w->codec;
> > > +	unsigned int val;
> > > +
> > > +	switch (event) {
> > > +	case SND_SOC_DAPM_POST_PMU:
> > > +		val =3D snd_soc_read(codec, NODE_ID_HP_OUT) & 0x8080;
> > > +		switch (val) {
> > > +		case 0x0:
> > > +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> > > +				NODE_ID_HP_OUT, 0xb000);
> > > +			break;
> > > +		case 0x8000:
> > > +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> > > +				NODE_ID_HP_OUT, 0x9000);
> > > +			break;
> > > +		case 0x0080:
> > > +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> > > +				NODE_ID_HP_OUT, 0xa000);
> > > +			break;
> > > +		}
> >=20
> > This is rather unclear.  What is it doing?
>=20
> SOC_DOUBLE_EXT("Headphone Playback Switch", NODE_ID_HP_OUT,
> 			   15, 8, 1, 1, rt286_playback_switch_get,
> 			   rt286_playback_switch_put),
> We use NODE_ID_HP_OUT bit 15, 8 to store the mute/unmute status for headp=
hone L/R channel.
> rt286_hp_event will mute both channels when power down.
> And it will read the status from RT286_HP_OUT to unmute the corresponding=
 channel(s) when power on.

So how does the mute control work when the headphone is powered up then?
You may be looking for a SOC_DAPM_SINGLE_AUTODISABLE() control here, I
think that's what you're implementing here.

--95sqq/H8MHju+kJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9Na0AAoJELSic+t+oim95YsP/2TFgk1kiysP27O4HMlFVdn/
ogFkTYtDCMnfKuuS3KrC87h71ohwB17SzyyLoFag1ygRg/KtvSQIayTWn6ysW5i5
9AhTYbfnM1cvprANXi61OSx+Ozsx8QIboc9cw/EtMGZGCf3FTUXG4tv8GfHMAJkM
dPTMf/VzzW9ZbAjr2cFTrbcl67BxhrSN7xTgjNKO1EdQux0UbLXghqg+A5N0K6Rs
hNFY/8+Rob32M+RDvjixkywXzZvspKpf8atyDEkkE6q/KJ0ix8dOcEBJ4Y7to03t
iH+69JiZsOi7jMQtP8xn46NPWx1mq8OjXF37IFEIH5/rT5bP1s0P7Vq26FBFHGQf
nKC0u8GeJzRhXgdYuzX0yz9K80fFLEhoPGrfT0PeXlpvDV/bUhj/B6uYAN5jyAA5
9puj714UY51qgZsI5Wv5nLFkY59CDlLyq+pYdtPF7Gz/w5L/+9/lCfxGX6rqNOE4
+DyfXWEhzXYfnBtrIBybEwLwpaQ1jozhIe5+Bsi6y50RNJe5Dt2kRM3udKsrXhf2
3La3Aigeb398zV3SdBk8MgX6P1gQZ7bKHwVYjgR7YDHosesOuJ5VEdvsqjHu99p/
2R+xIB+WH2gRmYGU73rC+pmNO6m1A4txYojquTrHzdj/A9oqvMaCsm64cXLR1W+k
S1F1tmAN2WEMn5BmAws2
=EDgS
-----END PGP SIGNATURE-----

--95sqq/H8MHju+kJM--

--===============3889825590600339424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3889825590600339424==--
