From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: dmaengine: Remove unnecessary
 snd_pcm_lib_preallocate_free_for_all()
Date: Mon, 5 Jan 2015 21:30:34 +0000
Message-ID: <20150105213034.GT2634@sirena.org.uk>
References: <1420203373-1844-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3039878550618959864=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A5C62605A3
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 22:31:04 +0100 (CET)
In-Reply-To: <1420203373-1844-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org


--===============3039878550618959864==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="su+CkryO4QJrkqP3"
Content-Disposition: inline


--su+CkryO4QJrkqP3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 02, 2015 at 01:56:07PM +0100, Lars-Peter Clausen wrote:
> The ALSA core takes care that all preallocated memory is freed when the PCM
> itself is freed. There is no need to do this manually in the driver.
> Similarly there is also no need to do it on the pcm_new() error path as the
> PCM will be freed if a error is returned.

Applied all, thanks.

--su+CkryO4QJrkqP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqwJ5AAoJECTWi3JdVIfQxJ0H/RYb3A5mxEpM4VUUAau6QZqa
jflPd9h45T7+X3ARxBlA9qjCAjswCXL4EJPFmXjj+9WkvOqOReqziajDN+gcqnr/
1cUMZb1OidqWZ7LXtZwQ9zAUgk0lHVv+gj8RJjez+Mc3c7u8A5bKLEyy54X/P1de
eMM9+ulZGDyrradyyxjyuEsTRlTIfKNNIZ8YqY+VtlUXh3ol5TK8iHbxiYG06sgs
gM2hAWpP9E46g2hO036XiSAuR+1UGMlmtS18DS0u495mUZGnU+W7Ue9xiQvPuIEr
Q3lzNAR3fAQMV9B9QMyqTDFuBiX4ZlllrqxS5yg9cao+RBisnso8M+JTzuCh7t0=
=3GXH
-----END PGP SIGNATURE-----

--su+CkryO4QJrkqP3--

--===============3039878550618959864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3039878550618959864==--
