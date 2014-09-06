From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: sst-haswell-pcm: Move controls
 and DAPM elements to component
Date: Sat, 6 Sep 2014 14:48:01 +0100
Message-ID: <20140906134801.GA2601@sirena.org.uk>
References: <1408532929-26978-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3951863550812516563=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C6DCE262634
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 15:48:32 +0200 (CEST)
In-Reply-To: <1408532929-26978-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3951863550812516563==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2014 at 01:08:45PM +0200, Lars-Peter Clausen wrote:
> The sst-haswell-pcm driver is the only one that registers controls and DAPM
> elements for a snd_soc_platform_driver. Moving them over to the component that
> is registered by the same driver make it possible to remove the
> steal_silbling_dai_hack in the core as well as the extra indirection that is
> used to register the controls and DAPM elements.

Applied all, thanks.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUCxCMAAoJECTWi3JdVIfQEZ4H/3l8cHJSU6aOvrAGlF9+AgjE
e3eNiMkBjQBNcdNu8fU4lXZeiOowkbYRrxUyogKjEP41QvgR9D8tupDcwoUFAeIl
oVaLkdsQ759v3NqGTsANgFkCqoDfVz2tUd8rdI+K98bqr0jRTv10w2WVlYgzAA9I
mGUGqDmm51zj10fsxcIWKLRj2Bubzi+qilpx5QYsZhUyvStK4HQMVuSzShzkP1Yu
Dz1mxlxYu1kOB0qRVLP7gP9Xrph5/rHJBoS1fxijbUj4v39427u/dZJ5VjUwBLm+
Qbcu7vrNOt8VaCNM+Fse9Frxymf3AlHDaWx0J3PVjcVb66rsGy93I2U/aTuqWGQ=
=4KGi
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

--===============3951863550812516563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3951863550812516563==--
