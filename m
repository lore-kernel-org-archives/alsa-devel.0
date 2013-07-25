From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8994: Add clock bindings to the
	device tree
Date: Thu, 25 Jul 2013 18:56:42 +0100
Message-ID: <20130725175642.GJ9858@sirena.org.uk>
References: <1374762668-5037-1-git-send-email-broonie@kernel.org>
 <20130725154627.GA22291@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4775567771556050662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1900726084C
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 19:56:57 +0200 (CEST)
In-Reply-To: <20130725154627.GA22291@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: alsa-devel@alsa-project.org


--===============4775567771556050662==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RBYxkammHF1d4YNT"
Content-Disposition: inline


--RBYxkammHF1d4YNT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 04:46:27PM +0100, Mark Rutland wrote:

> Do these two clock inputs exist for all of wm1811, wm8994, and wm8958?

Yes.

> If I've read the context correctly, these are optional. Does this mean
> that if not listed that an OS can assume they are already configured and
> active? It would be nice to document that.

The clocks are both optional but even if they were assumed to be present
they aren't usable without knowing the rate which can vary widely.  It
is possible that the system may be able to infer their presence and
rates from other information such as the audio system integration
compatible string but that's out of scope for this and doesn't seem like
a particularly good idea to encorage anyway.

--RBYxkammHF1d4YNT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8WbWAAoJELSic+t+oim9WeUP/1ZFCpEbAufNgGHf5565/PUg
AfdBgJRnEaEHTh3d5LKHV/0tj3xUG1uVSgK1cD+bBsKRMQbKb+E9hffaRuVGTuDy
Yvicah1uPTDId+Wv6GMlkE4rDwsmOASRnlt6e85eC2qayyTDACoDL7NkwqOY1wUe
MS6NHNVS2EelxXNvXgk+IXHRGoAtxx3ULGyOz7k7S/jGCgn3+/f0Hxn3QKAPD4YU
J8Fdab04Okm+LmOMKKXKINDPxD7s9PlKF5DNLNGE2sxl7NCKOCfVExrQnTIimOw0
EWYKQeuBHZB1No2XLhgN0ntSEgGXAG0BDhMPLZ9a/IwajYgGAsDbi/Z8VbQdIQoG
p4rvY3koItNqsPE0qlvX5vCkdoqmb1nxhKpVk2VWBVBMWb6dE0dEjf9Wo8Y1iNrg
AR+rzgXYrJyQIrdcHAgUPIJnczwZqPkL+kM1hF30DQzSnvMeYS2Q3z3S9+ZLFAh7
EiIVa7hy+b/+ZcnQRBba6abWMxv882LVsEEpRrCKo1efV/YtXB9WcUlDXYZCqdCg
xJqYi5/qlmAXazYoxRWGjRwYwqikIC+QFScqqofvVuArctGOVEbzCozl7UTQYIiO
TagR6peZt4LCxn+Km/qExdhPzCFSZn1OejvMBjiJrNrC3D/IpyB6gLE7ucYa+8ya
WeV/Cj3R0aMeLNzzpwVQ
=T5Gq
-----END PGP SIGNATURE-----

--RBYxkammHF1d4YNT--

--===============4775567771556050662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4775567771556050662==--
