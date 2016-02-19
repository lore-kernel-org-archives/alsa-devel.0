From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 4/9] ASoC: hdac_hdmi: Fix to reconfigure
 registers in runtime resume
Date: Sat, 20 Feb 2016 00:55:28 +0900
Message-ID: <20160219155528.GT18327@sirena.org.uk>
References: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1455725047-7303-5-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6553206219897539037=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EE6F266DC1
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:30:31 +0100 (CET)
In-Reply-To: <1455725047-7303-5-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6553206219897539037==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rBVNTu5JXDAWzN2S"
Content-Disposition: inline


--rBVNTu5JXDAWzN2S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2016 at 09:34:02PM +0530, Subhransu S. Prusty wrote:
> The register are reset during the D3 to D0 transition. So
> reconfigure them.
>=20
> Also as all DAIs are now supported, remove the dai id check in prepare.

This looks like two unrelated changes and so should be two patches.

--rBVNTu5JXDAWzN2S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxzrwAAoJECTWi3JdVIfQ8A0H/3ZOhbe+KFr1PtMuAS9ujugK
uQ+ToPK3jZajxGnT701p2desgBgnqBQSkrPWKYXBIcseUBH06cyelfAHd8yNgRpO
4RJ+6YmDpR1L8KcbiTE2uD0Ga4I8fred2FbIHTyN+9y6M0wps4j/a3twAQRcLYmY
4SXcE+0FuB2CruiRjw7G0QslwE1jk8rv319xPM2rCpfRE7cL/NlwqUd1mDNYxWdc
ALzbi/r4Yr415dwod8yoGjjBhWV49GN0YzbkLFiWPAqbgga4FB5/LisswlTU7bzt
oLpYcG1K/yJUKLu62mGZkjLU4qocJvpqQA2a6cdMoE7d1GyyOioYCjB+BLljTvs=
=9Y6v
-----END PGP SIGNATURE-----

--rBVNTu5JXDAWzN2S--

--===============6553206219897539037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6553206219897539037==--
