From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: byt-rt5640: Fix
 snd_soc_dapm_ignore_suspend() calls
Date: Mon, 5 Jan 2015 20:13:19 +0000
Message-ID: <20150105201319.GM2634@sirena.org.uk>
References: <1420107825-28506-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5877749987273797953=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D54F260652
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 21:13:36 +0100 (CET)
In-Reply-To: <1420107825-28506-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5877749987273797953==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tnj+unmjHTqEM5y0"
Content-Disposition: inline


--Tnj+unmjHTqEM5y0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 01, 2015 at 11:23:44AM +0100, Lars-Peter Clausen wrote:
> To work properly snd_soc_dapm_ignore_suspend() needs to be called on
> endpoint widgets. In this case those are the board level Speaker and
> Headphone widgets and not the CODEC output widgets that are connected to
> them.

Applied both, thanks.

--Tnj+unmjHTqEM5y0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqvBeAAoJECTWi3JdVIfQv/EH/2+AznaRBlQ4fJ/ByeYlHdAl
uDP6crGYvgBet++aVqWHIHTY0/PSLooZ2LRZ4g0VZgRc4wUC6gBCFYHybupOB9R5
YljguHSlnm4WNL7fo+R2g0N/nNDZsGKbH5QAskdK1H9CDYvE1chU09KeK+rFWgXU
UsJ8nYJ7bGMZ59kDl9rkF8Xr/CiZn7dHpaZCzUZGieShCzpLv9pzJ5t0Z0DXDLLG
limoJaq/fJe121zi441pLHHRfnM/D2jyV9b8a0n408NlktoXN+XX9nz54dTyBR8D
GdvQ3l7N4t2KoJwZXLumKY6lo86b+s45QNsdf3xvyoxHyHuPWiBftfNZHmBjRMY=
=D5DI
-----END PGP SIGNATURE-----

--Tnj+unmjHTqEM5y0--

--===============5877749987273797953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5877749987273797953==--
