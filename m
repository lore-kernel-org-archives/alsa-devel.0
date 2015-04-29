From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/12] trivial: ASoC: adau1977: fix typo
 s/Substraction/Subtraction/
Date: Wed, 29 Apr 2015 11:23:49 +0100
Message-ID: <20150429102349.GA22845@sirena.org.uk>
References: <1430219491-5076-1-git-send-email-ao2@ao2.it>
 <1430219491-5076-6-git-send-email-ao2@ao2.it>
 <20150428160023.GW22845@sirena.org.uk>
 <20150428232758.28e194be2c9a3d61be23f4bc@ao2.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6161364123276953053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B2F152604BD
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 12:24:03 +0200 (CEST)
In-Reply-To: <20150428232758.28e194be2c9a3d61be23f4bc@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@ao2.it>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jiri Kosina <trivial@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============6161364123276953053==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D7RUby1oeXo9YskT"
Content-Disposition: inline


--D7RUby1oeXo9YskT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2015 at 11:27:58PM +0200, Antonio Ospite wrote:

> I tried to follow the subject style for the subsystem, but then I
> prefixed it with "trivial" to highlight that I was sending an aggregate
> set of unrelated patches to trivial@kernel.org, that's also why I didn't
> want to CC everyone on every patch: to reduce noise.

That's not really helpful - it means that the patch is more likely to be
missed and that the patch sticks out in the changelog.

> Maybe involving trivial@kernel.org for changes which apply to a
> _specific_ subsystem is not necessary at all, next time I will just
> aggregate by subsystem.

That's generally better, the expectation should be that maintainers are
going to apply even trivial patches and it does make life easier if
things go that way (less chance of conflicting changes for example).

--D7RUby1oeXo9YskT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQLE1AAoJECTWi3JdVIfQZ0UH/Aw26lNeoOqU6o9GC+FJPzhZ
wVKfoQaEZ0lbZ6NGkvWfyyoulLClZ3BjPCMbL7+e9b5jYbTMvBRK/Nc4kCXOsHL0
bfyzeynh/TU6Fwnql4japcrBMeIHbEJy2V+zlfnrrtEUPB51r49TNSlMtaYRgZQ1
WUt6ragb9FQRvFeGkkpS1GfJi+NgQIArj5hy0f5r8ySrfAxr1skGZ7eVd1Z0++cN
uOQ5FDiVnofJkefIeXOqMLHoMQUekJi+bLxFYkEysuHxA49wjNIn/RVt7Z8wrca7
VUTRLmPAvFVH7Eq9R+MK5B44b5RFC8/yGQnkdrVR+n3IR59yn+yKveTJBXsgbrw=
=Ksks
-----END PGP SIGNATURE-----

--D7RUby1oeXo9YskT--

--===============6161364123276953053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6161364123276953053==--
