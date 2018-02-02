From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for
	AK5558 ADC driver
Date: Sat, 3 Feb 2018 00:11:02 +0100
Message-ID: <20180202231102.GA2705@sirena.org.uk>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
 <1517588406-3295-2-git-send-email-daniel.baluta@nxp.com>
 <CAHp75VfyVfGdCfjV_iaXFcRcanbgwFSgJRfu8eojdbMONMUOaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4622694087868168852=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EB3D2267044
 for <alsa-devel@alsa-project.org>; Sat,  3 Feb 2018 00:11:05 +0100 (CET)
In-Reply-To: <CAHp75VfyVfGdCfjV_iaXFcRcanbgwFSgJRfu8eojdbMONMUOaQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, wakasugi.jb@om.asahi-kasei.co.jp, Cosmin Samoila <cosmin.samoila@nxp.com>, Daniel Baluta <daniel.baluta@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Mihai Serban <mihai.serban@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Mihai Serban <mihai.serban@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4622694087868168852==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 09:33:18PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 2, 2018 at 6:20 PM, Daniel Baluta <daniel.baluta@nxp.com> wro=
te:

> > +static int ak5558_set_dai_mute(struct snd_soc_dai *dai, int mute)
> > +{
> > +       struct snd_soc_codec *codec =3D dai->codec;
> > +       struct ak5558_priv *ak5558 =3D snd_soc_codec_get_drvdata(codec);
>=20
> > +       int ndt =3D 0;
>=20
> It might be even
>=20
>       int ndt =3D max(ak5558->fs ? 583000 / ak5558->fs : 5, 5);

Please don't encourage people to use the ternery operator like that, it
does nothing for legibility not to write out the conditionals.

> > +static const struct i2c_device_id ak5558_i2c_id[] =3D {
> > +       { "ak5558", 0 },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ak5558_i2c_id);

> I dunno if it's really helpful to have. Though it's up to Mark and you.

I don't care either way.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp07+wACgkQJNaLcl1U
h9BHPAf/ULNE/TgqMjU6OG0niwehPfex4/rWAdnXSuCTnMwNjAxLykg5za+EIoZL
svckNQsXK/isMwPkN9y5C1Y3Rj0lzHwrUS1r8TLlBGIfHrptjdE/DsTuEsSoN6Rg
U399B7xrn/mmbilMPrKCFfw/4W+HWam7zTzx0ZeusQniLQV9OVt7lUY4WWAGGk1g
fHFPOllskPqZ+ssxsZxQZZkEo3GLYDREcJxLD4EI0QZnSF7sLvFrDHKMezvw0svN
U6K13e5Qz5JMhDodebCmxc6W61b9eB8YX1xOtsWIcxn1/ay0Pfaii0Yej487bxqH
gtWrH+pg7Osgv+RrzicaFQHK6jgNcg==
=YBel
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--===============4622694087868168852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4622694087868168852==--
