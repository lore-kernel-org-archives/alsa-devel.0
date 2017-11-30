From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND 1/2] ASoC: Intel: kbl: Remove option
 of choosing CH count based on pdata
Date: Thu, 30 Nov 2017 11:15:11 +0000
Message-ID: <20171130111511.up2f2te5mc3orkit@sirena.org.uk>
References: <1510740463-21655-1-git-send-email-naveen.m@intel.com>
 <1510740463-21655-2-git-send-email-naveen.m@intel.com>
 <20171129123314.4x4giq4hk2ew2zol@sirena.org.uk>
 <20171130040204.GK32417@localhost>
 <20171130061443.GA31069@nm-B85M-D3Hnaveen.m@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8777204051288281382=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3110F2674D1
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 12:15:20 +0100 (CET)
In-Reply-To: <20171130061443.GA31069@nm-B85M-D3Hnaveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen M <naveen.m@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8777204051288281382==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x5ruhut7rmailsxk"
Content-Disposition: inline


--x5ruhut7rmailsxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 11:44:43AM +0530, Naveen M wrote:

> Regarding the Query:
> As Vinod mentioned, I'm working on Chrome OS user-space stack that uses
> customized audio server "CRAS".
> These patches are verified on a board that has only 2 dmics.
>=20
> Giving the control to CRAS, enables to select the desired dmic using
> channel-map configuration in user-space.
> Ex:Rear/Front mic selection for World & Front facing camera scenario=20

People do run non-ChromeOS installs on their Chromebooks so we can't
just assume that there's nobody out there with a regular distro on this
hardware - a user like this reported the problems with the ABI for
topology files breaking for example.

--x5ruhut7rmailsxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlof6D4ACgkQJNaLcl1U
h9Ab1Af/WYTlfWdDASFZRbbnQqz5EH5Y+tQrLFdsA/1HyRuqv6l7/arLzvfUHC1b
dntDpGtkUm8uFeYZR+/3Fe2M1NxUiwTacyPg1TirX8eEPv+v0VhBQLnK/lI0Twxx
MgsLyHFR+l7jXMdihS/8oksw2Rb5q+u6kfaVsYJyZu0Tcf/gcoMnP7pWoiS+cpnN
wnP4qTAeamcSWFLWinUhZaTamlSaV6evoQy8Wkmjc713UCQMrmOZScMzjJwPTq0P
/T9R27SXXeWSG+FOxNObqHO7B83LwBagzPy+6xxI/X7u3+xfe4ucuQ0pU0cx2n+h
AfpyqqzCbtzY96lFdpHg0nXvwGqsbg==
=dULD
-----END PGP SIGNATURE-----

--x5ruhut7rmailsxk--

--===============8777204051288281382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8777204051288281382==--
