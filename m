From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Wed, 21 Feb 2018 13:02:41 +0000
Message-ID: <20180221130241.GI8334@sirena.org.uk>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
 <CAOMZO5C3joR2QS+yFDmQUs1Q69PfuVw8tBMNd+F+cjDnUMEPSQ@mail.gmail.com>
 <5b591fd8-d4d5-27bb-0850-a376da20d7f3@metafoo.de>
 <CAOMZO5Ai-EtFo--OYLKhsB+63u6D+Vyjx_hKVeG3EGXbHkY5jw@mail.gmail.com>
 <99ce1244-6646-6292-2c50-151819b01cfa@metafoo.de>
 <CAOMZO5CA99p+2DYrbWQnLzh5Lj8syX4j18V8R8WPV2KDZz-DVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4616681959058308180=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C0A1E2675B4
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 14:02:42 +0100 (CET)
In-Reply-To: <CAOMZO5CA99p+2DYrbWQnLzh5Lj8syX4j18V8R8WPV2KDZz-DVQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4616681959058308180==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NyChO5MpGs3JHJbz"
Content-Disposition: inline


--NyChO5MpGs3JHJbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 04:37:33PM -0300, Fabio Estevam wrote:

> Thanks for your clarification.

> What is the best way to avoid the "Failed to create
> component debugfs directory" warning?

It's a legit warning - we shouldn't really be creating two components
for the same device.  However this is a bit of a corner case as it's the
dmaengine platform driver which is kind of a virtual device, it's not
really the device that we use with DMA that's being represented but
rather the link between that and the DMA controller.

Does the below patch (completely untested) help here?  It adds a prefix
to the name for deduplication. =20

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-=
dmaengine-pcm.c
index d53786498b61..d5a6eea64036 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -431,6 +431,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	if (!pcm)
 		return -ENOMEM;
=20
+	pcm->platform.component.name_prefix =3D "dma";
 	pcm->config =3D config;
 	pcm->flags =3D flags;
=20

--NyChO5MpGs3JHJbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqNbfAACgkQJNaLcl1U
h9D2Lgf9F9ps3/Y+c0VL9SXWWcRoX68vJQD9QfhogRmqad6inG350XGETUkIrPxp
o8Ad1mqhOJ3vXbCFP25iH9ApPeCCZTbTpSZU5rpAjXAAWxXlTKsmQWFPlCk8B47V
ovGM6BrpdGvVcLnsRalIaocEMOwYE556leNZh7PZUBUvIhgXhbyoB9PegxIJLd1c
OXPbp+ftxnrjXcNfRyOWVUjTmEyiCbAiAct/KDSiI2hMb5joCnomlzwDYSgsmSzk
+ooJS3tj9t7y7XCUY/OGR5ISWkseRNhc7hlTh37rQXFQAuJ1mQPsube9lZRlrCZS
GX8QPXf2z+qIi1tzaqlf34iq0pFvcg==
=bxs7
-----END PGP SIGNATURE-----

--NyChO5MpGs3JHJbz--

--===============4616681959058308180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4616681959058308180==--
