From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3 v3] ASoC: dwc: Unmask I2S interrupts only for enabled
 channels
Date: Tue, 5 Apr 2016 11:56:58 -0700
Message-ID: <20160405185658.GJ1924@sirena.org.uk>
References: <cover.1459875048.git.joabreu@synopsys.com>
 <409b73fe04f1bd5155a8e6be701370a4594edc52.1459875048.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1342705016=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <409b73fe04f1bd5155a8e6be701370a4594edc52.1459875048.git.joabreu@synopsys.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, CARLOS.PALMINHA@synopsys.com, perex@perex.cz, tiwai@suse.com, linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1342705016==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cN519qCC4CN1mUcX"
Content-Disposition: inline


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2016 at 06:08:02PM +0100, Jose Abreu wrote:
> There is no need to unmask all interrupts at I2S start. This
> can cause performance issues in slower platforms.
>=20
> Unmask only the interrupts for the used channels.

This appears to be completely unrelated to the other two patches in the
series.  Please don't mix unrelated changes in a single series, it
creates interdependencies that don't really exist - if you've got a
separate change or set of changes send them separately.

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXBAp5AAoJECTWi3JdVIfQpcMH/A/7xSnNYLnMkxMOya8YH1Gz
6vSyq5bp1nvapy73zsxSoclFF/0Zcec4/PTWKmziuTREEOlePBjkuKKfA3tfVfQJ
sITAa25XzTQ6VV6BR5ruLNGd3ls/PfP+vS6Jp5nCSvMaLBDUE1y0o5fGnn2fsK40
RNBLYkgEIGVANNkPlPF/s3NeVh/mxii/7P9AN5UeujMOHZR86XzEj8T12Qp5Elh+
l30Rx9mkU26dQ5oj/K8K12fYQQUnYZrpntky1TcPDtJfAvslB58a15hv/t73WcyN
xHhv2A10ZUriOZuP1tq3wWZyKw0e01EJXw+Mdok4XHsaiame6r2rXcc/2gmr/B4=
=lZWQ
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--

--===============1342705016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1342705016==--
