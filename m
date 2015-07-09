From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 4/6] ASoC: Intel: Add helper to update
 register bits with attr RWC
Date: Thu, 9 Jul 2015 10:14:12 +0530
Message-ID: <20150709044412.GI836@localhost>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-5-git-send-email-vinod.koul@intel.com>
 <20150708184723.GC11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2960719964855574012=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A66C3265CA8
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 06:42:32 +0200 (CEST)
In-Reply-To: <20150708184723.GC11162@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2960719964855574012==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iAL9S67WQOXgEPD9"
Content-Disposition: inline


--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 07:47:23PM +0100, Mark Brown wrote:
> On Fri, Jul 03, 2015 at 04:04:05PM +0530, Vinod Koul wrote:
> > From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
> >=20
> > For SKL IPC, we have some register bits with attribute RWC. So we need =
to
> > force update them. Add helper to force update this type of registers bi=
ts.
>=20
> This doesn't apply, the header already exists.=20
I did rebase this on v4.2-rc1 before sending, will check on your next

--=20
~Vinod

--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnfwcAAoJEHwUBw8lI4NH1CgP/j3ypectcP7LGDkVLHc/bJcl
kxf0gjGuHbiQ/6m1DarZQWKdspm4WFrwCAAfjjmTHwWn6at7JYaYiiUMM4h97JbO
Z/Xf0ladSftcYBasFkxWO5AIvsCiBTywjLiGPeC9JWArCYeN9Ou9W+5bMuZ/9LV9
9pVqjBrgKN/a26PPS22oU32XGscqkiJwNFZkrUqrIv9y5qiOjmvl17wmZwpRkRaS
GbyTtVCiF9n93WwczAZN3uiovAvMce9X093TOSX9/Jf9If09IpMZn5MwY9yOEAJR
CvO9I2t9LXGHM/79JDQK1ZihgT1Y9tlDGvS0g1fZ+FJUgsrBKDd+WakYEsA14l6x
rA9BZ6rolzAtXUTLdwJ+1C33pc3MDJSHL0o6GODcSFHvPYPYuA6SdQjNi2meUQoB
xg+RMuGZpCNWhwYy4lXTgsCNLZ8oxHU+eHLrZnd5vWWKBSId4u3OGLEm5yjNOOTm
c1stVPuQVLD9k+HMyystg5oMhD+Eacvn2crBy3MfKZySlD+10h/ZnU+58GdAzPGY
bZEvCkv1MblfEpMSBXly0C8rHlTcUzQkk7DfsoNse/2VSlE9CJ1RWaWnic5v/rnV
YOClqnmArcSgNQiRkmDW08mHDQqJ+W9XTp/FPIY88VtdEzqMFdKmE9W4oUFtRV0/
PRwDgJ5R3N7NbO6XzWnD
=FM+s
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--

--===============2960719964855574012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2960719964855574012==--
