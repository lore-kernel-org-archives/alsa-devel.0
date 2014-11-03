From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add Merrifield machine driver
Date: Mon, 3 Nov 2014 10:31:58 +0530
Message-ID: <20141103050158.GL28745@intel.com>
References: <1414750298-23287-1-git-send-email-vinod.koul@intel.com>
 <20141031171127.GG18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7036652017862298436=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 62FA7260459
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 06:43:56 +0100 (CET)
In-Reply-To: <20141031171127.GG18557@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7036652017862298436==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Content-Disposition: inline


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 05:11:27PM +0000, Mark Brown wrote:
> On Fri, Oct 31, 2014 at 03:41:38PM +0530, Vinod Koul wrote:
>=20
> > @@ -26,6 +26,7 @@ snd-soc-sst-haswell-objs :=3D haswell.o
> >  snd-soc-sst-byt-rt5640-mach-objs :=3D byt-rt5640.o
> >  snd-soc-sst-byt-max98090-mach-objs :=3D byt-max98090.o
> >  snd-soc-sst-broadwell-objs :=3D broadwell.o
> > +snd-merr-dpcm-wm8958-objs :=3D merr_dpcm_wm8958.o
>=20
> Notice the difference in naming style for the module here...
shouldnt be, will amke it consistent

>=20
> > +	switch (level) {
> > +	case SND_SOC_BIAS_STANDBY:
> > +		/*
> > +		 * We are in standby down so */
> > +		/* Switch to 32KHz MCLK2 input clock for codec
> > +		 */
>=20
> Interesting coding style!
mea culpa, looks like fixing this cause issue :(
>=20
> > +static const struct wm8958_micd_rate micdet_rates[] =3D {
> > +	{ 32768,       true,  1, 4 },
> > +	{ 32768,       false, 1, 1 },
> > +	{ 44100 * 256, true,  7, 10 },
> > +	{ 44100 * 256, false, 7, 10 },
> > +};
>=20
> This isn't referenced anywhere.
Yup, this should come in subsequent jack detect patch not here
>=20
> > +static int mrfld_8958_init(struct snd_soc_pcm_runtime *runtime)
> > +{
> > +	int ret;
> > +	struct snd_soc_card *card =3D runtime->card;
> > +	struct mrfld_8958_mc_private *ctx =3D snd_soc_card_get_drvdata(card);
> > +	struct snd_soc_dai *aif1_dai =3D card->rtd[CODEC_BE].codec_dai;
> > +	struct snd_soc_codec *codec =3D aif1_dai->codec;
> > +
> > +	if (!aif1_dai)
> > +		return -ENODEV;
> > +
> > +	ret =3D snd_soc_dai_set_tdm_slot(aif1_dai, 0xf0, 0xf0, 4, 24);
> > +	if (ret < 0) {
> > +		dev_err(card->dev, "can't set codec pcm format %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	card->dapm.idle_bias_off =3D true;
> > +
> > +	if (!codec) {
> > +		dev_err(card->dev, "%s: we didnt find the codec pointer!\n", __func_=
_);
> > +		return 0;
> > +	}
>=20
> This should be an error if it's even worth checking for (which it
> shouldn't be).
yes..

>=20
> > +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_1, KEY_MEDIA);
> > +	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_0, KEY_MEDIA);
>=20
> Two buttons both reporting the same key?  Might be worth a comment.
Okay loooking back I am not sure why we added two here, let me check and
clean this up.

>=20
> > +	ret_val =3D snd_soc_register_card(&snd_soc_card_mrfld);
>=20
> devm_snd_soc_register_card() and you can loose the remove function.
Sure

--=20
~Vinod


--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUVwxGAAoJEHwUBw8lI4NHFskP/jq9hXCTAd6T/l4h3G8ALcpD
s8TjB4+RKcqsVvYi+DY/KKxqlV5+otHcX7kB5s7PGkUht8Ay9M+9bdE4g6gwQRbN
BknYcvLtjmwT1SwSxd2q2KcO7cONamuuznizYE8DzkW9bJaLIvS3a2DaAaCmeeEN
IMF40FTSiNXBnJe+pDTbeDaclJuRbUCQ/2mADmWNyKRMnHcmcEH8WXo4LV9CFkoe
VSPNElpMpzvuBDyd/tG00H4EGTfHYX1KuoLQA4J2LNT9NgpgADRSSs55XMlAqnlT
6hmp/5Nq+V1NxQwv3os7U3kCyRJB22YACT7ZF+z6hhKy6ExfwDi3sMWmN155HtPq
qbkF6m4hm/0adauwNY/YP7GBmAnqLz8edmPp5/P0DKH0vFUQoBDajeo8WG/aHzqU
+vbcBqTOl2TNFPHTZuGYZc42ldGOGIptTSdlzGFt4nk/x+L7hOcYKMNQ4e5jEQOa
A4JdzrbyBjAnVK7xKuI8lk1OSmJ72cQOKRCRKHYVQs3zkDAl8wOqecz6ubF9UYcA
sJW1Prn+4pVmZCUBwYcuDn6CHgHFOAoiXsO3cyrz7JP6sAHxP85BNrEcr+RIvYZ9
pIwc0lTGtg3HO3Z+xC0Cz8AxpF5UcUvRXiW1fg5gYox4sZ6jIvooLGUqRu0zjbOi
RClG7AADHbSmhfklEVEq
=jvfR
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--

--===============7036652017862298436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7036652017862298436==--
