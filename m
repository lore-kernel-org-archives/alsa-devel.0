From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sirf: Move the tx rx enable from
 port to codec, that will not need register sharing
Date: Fri, 4 Apr 2014 11:18:25 +0100
Message-ID: <20140404101825.GR14763@sirena.org.uk>
References: <1395301579-2960-1-git-send-email-rongjun.ying@csr.com>
 <20140321192002.GS552@sirena.org.uk>
 <CAByv0RNAG9daCBd0dVZKxJ=U34_OMBiyp5X784crwS+EthYjfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2720410427406304762=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 435A52625F3
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 12:18:40 +0200 (CEST)
In-Reply-To: <CAByv0RNAG9daCBd0dVZKxJ=U34_OMBiyp5X784crwS+EthYjfA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============2720410427406304762==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KjJb61kpjaVQeLm7"
Content-Disposition: inline


--KjJb61kpjaVQeLm7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2014 at 05:49:22PM +0800, RongJun Ying wrote:

> You have applied this patch.
> But you have not merge it into next branch.

We're in the merge window and this is new development.

--KjJb61kpjaVQeLm7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPobuAAoJELSic+t+oim92sEP/3ByzUlmFOdEOzMx6omwfOzR
YuLhWEuUZMHAxvw1e4Cj1ZSMH+paA8kdmRuUWQPupoLQ6M/CqOGmktKrjD6ziqg3
YvzDv5rykYtEUqred4UEiqkM+E/tphVGFAuST1lQynufrsizwYeUHl/KyFG/Efjj
qjJxdKMiiolw3z8yMauxuqDLMnNoq05snwzcYlEG5HrZ8giNk4vY5RfU5vb9hq+P
/Yg6qyOizHQHK7riWRkNECsqzb+UpAFyTLwW953wd4wjfvfmkeJkhNAomBjSA6eO
hJzl0Kgc0r/kFpJ3ce8uBk05yfGokBOjht8xXMXWto7mop3Ro72g6hnDG6EANPGt
yqXoQK0Ol4bZ+TYUcfKtyoX2PxPsWHv5h7SSiZaA3MvSyluBfOVR+U3cAyCnMG5f
Usmf71glSKv/20QvaQ8Aodg7W3GQ1o/+1bthyqvMdB0ahONjtQQ4wnBzPHnpI4n/
hcFR/aJV6Pq1YJdSddXRWOfEXziXN7vJ0bnewYU+a9xw2mJkJ75Zskl78QjSW16P
P2QBWq+zk+EiZf96cfkkLlyXuxTq05DivlHais6bAUPANpbu/qT/pgcBDYycBTU2
fl3+8pQoUoiX1S9s1Ie+EnVRkXxN5AxrckY0c20NY39uPuVgNOMDEJp74RlGQphl
cMdNrnpv/kmw3Y6ZP3TD
=vY7p
-----END PGP SIGNATURE-----

--KjJb61kpjaVQeLm7--

--===============2720410427406304762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2720410427406304762==--
