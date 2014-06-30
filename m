From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic3x: Correct S24_3LE
	support
Date: Mon, 30 Jun 2014 15:52:47 +0100
Message-ID: <20140630145247.GA23300@sirena.org.uk>
References: <1403759216-14427-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2874621752069841351=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3854C261A1A
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 16:53:04 +0200 (CEST)
In-Reply-To: <1403759216-14427-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2874621752069841351==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V99Hi3aLIRgASqpV"
Content-Disposition: inline


--V99Hi3aLIRgASqpV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2014 at 08:06:55AM +0300, Peter Ujfalusi wrote:
> Correct the hw_params callback to configure the codec correctly in case of
> S24_3LE format since in case of S24_3LE the codec has been configured to
> 16bit format mode.
> S24_LE is not defined as supported format for the codec.

Applied both, thanks.

--V99Hi3aLIRgASqpV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsXm8AAoJELSic+t+oim9rlUQAIdw6N+84SJj4DznZSbGUGY/
NQyDiievLfGTKa1FU64YQtGn1DNRan7Aj2lDehgXQ4uTQOjyNDANStSyFgoeSPcs
ipbXLt05binU/5yY7G7IOTk2t1Ygxdfapht6Wi+5VejbXqbLjJbirHRl7mWHi213
IcVOVdnILjYANXOZiRdoPcKsdmjsELSbTl8AD7CfuOdPJe2wGbEhPitr3z2gBTTV
1DrNH+qqYqhqqdiYiFf+4WhQWd+RuppvzfhqUC0z9JNB/LqrAdrWHV96mqAM2kbh
6ag2L9v7FSFoD6sAe+OUwOdbQ+nJ1NXnA3XrfSe/KeZwECAqvDRxcJElYn7KHreH
UpEcN6s8/ILs4atoQa/eKoP0CyOfaKVTYv3BBKBpyBQI5Q0i0VMbJL9vjUG7F+hA
Y8KhZdPKyXE7YUzpHWRWIQn1avRT6gepmz3u+yVOdVy4mnlj4xbedUJruecB3Wif
yusuPtxJoVrToJwSxUZ/c9fRBCTfAWW/VU1yTyD4gQOVBrjhlfdMv8JfTkSDNFK6
YS7km/GiNob61kIKwEuZk3HkMqR2fCvsfUJDjWE2fe9y9m8G48VFfXPgoz6DH6GA
ebBllBNq42rq5kAZBgdz5Hke2tjj8kYuTdJNYpGyxX5uWUOXKQWWCa2IZeDTJfJ1
QXt8Pd2CQhTy3DZn1DVr
=EUEd
-----END PGP SIGNATURE-----

--V99Hi3aLIRgASqpV--

--===============2874621752069841351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2874621752069841351==--
