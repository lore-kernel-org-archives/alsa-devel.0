From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: wm8960: Fix PLL register writes
Date: Sun, 18 Aug 2013 16:37:21 +0100
Message-ID: <20130818153721.GY30073@sirena.org.uk>
References: <1376674588-14454-1-git-send-email-mike.dyer@md-soft.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0534749770138162941=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F18122608D1
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 17:37:23 +0200 (CEST)
In-Reply-To: <1376674588-14454-1-git-send-email-mike.dyer@md-soft.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Dyer <mike.dyer@md-soft.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0534749770138162941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w+MAdceOglSEzbpc"
Content-Disposition: inline


--w+MAdceOglSEzbpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2013 at 06:36:28PM +0100, Mike Dyer wrote:
> Bit 9 of PLL2,3 and 4 is reserved as '0'. The 24bit fractional part should be split across each register in 8bit chunks.

Applied, thanks.  Please remember to word wrap your commit messages
within paragraphs.

--w+MAdceOglSEzbpc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSEOouAAoJELSic+t+oim9wnEP+wf6uCG0vjLxzy5hUbzoRSkx
OAfL6QfkvLdNWRkg7Dym8+izxmIw2Nvz7lpN1j/t6CCvtyy4LF/gKpKYrwJw0ClL
RnPIC6ir+ORZAOeXkBgAV+EE7D9xfcST+Awtzc7pgw2jNtE4kO/HRKNzKk43nNFm
QVqwXseDYdsreBixBLe6E56zrOX5CQApsBdI72IyyVpVom7KqAaqz5T2EBAnj5vZ
jN3IFo2tApOd/r8ePUxoC8+DgwcJCmAdqhMbhU5alDQkBfHXpptAi9LSXzN3RLa6
UnGaeFkNMxu8aVBWb3YIfI/s5fwDiBEspjMfB4TFp0wpmVjpbS/irjniqL+eFIeD
XwQ6dgOVLAjTEumHRV8SbEAD/g1A+2IOIegQnYfEmyh9znqr8eu2xjnt8mwEu+44
GhpzWhtIGOPz/r35vxjt8sOD7YeJIA/0jMo5yf0nv8wSAaKfMFzDjCz7aCJ6Jg/V
QRL0KSh99JmUinNBeb6Apg7VIETXCN+2gSFwQHmsNH/fMgAOXEkO66CF7SGWifLB
sDaEN0zDugbKV73wDy9t5sAGlf32KJBxvN2gVIffeTKycijjhN1OZL2tw7EfbIKg
DSMCKNGYqZMbReRXrXKRIWDstlu5kjhZue+wTGWcvYISNBio0plE1i+HGK08gAY+
ueyBvtiyT0MMOEbRP3pF
=CGNg
-----END PGP SIGNATURE-----

--w+MAdceOglSEzbpc--

--===============0534749770138162941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0534749770138162941==--
