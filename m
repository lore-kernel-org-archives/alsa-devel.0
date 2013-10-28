From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: DAPM: Fix use after free in
	error path
Date: Mon, 28 Oct 2013 09:35:21 -0700
Message-ID: <20131028163521.GF13643@sirena.org.uk>
References: <1382966510-13075-1-git-send-email-tiwai@suse.de>
 <1382966510-13075-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5810934051709630352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 184F92616A6
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 17:35:38 +0100 (CET)
In-Reply-To: <1382966510-13075-3-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5810934051709630352==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2013 at 02:21:47PM +0100, Takashi Iwai wrote:
> The error message in dapm_create_or_share_mixmux_kcontrol() refers to
> the string "name", which may be "long_name" that has been already
> freed.  Delay the release of long_name to the place just before return.

Applied, thanks.  Please use "dapm" not "DAPM" in the subject.

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbpJGAAoJELSic+t+oim9OwIP/3Nj/DdOlUp9CJNn/6B546/f
LzAr8vjrT/lAu6zupGz3xQc0r5MGBYc9lFd+geupiAGNHlwrOHqg6hkO65oo7EjV
pVAVY81LsY5zALFyuIHZrsqzFu5w9CVBxOv2vczGYbCxcaNMtN72jASBna5y/zrT
kURAKps3ABhRk4LqfVF7sRhxgF9xcvlApaLspw6hlnB3rdcKmVY+5GQyY2INaq7r
lo3hd64++HVsvSTVQBnLcNZwZPiDTxbCRlPLzG0rlS3ix2h2duJKygiLiLnyoCRI
ugk7nVYr2kzwym32zDjRnALB93PWhMP/SUGS2DLnXgx64+W115FdXCMweNsHe7hH
Zc5uZeVjMr5NCAUtarxO+Ts9wzxu1gPDhMXNWNPU3zyunQNjEaDEodEzWQTt9fRU
YXbz2Ml9TWw4rOo4HewWxa7BRLvNsqqfzNZUFIdWJOlW7AuzflBnXytbvOE1vvE3
ik8A/dhIlRm3Y7tgCNHdT8WQSwoLx3N28D+Co76XLCxu6uTLakR/OenleQZXLEAx
khbsQLNCT951VpW6lPxeIDWoOvqPRR3K/Xb8mGYSDoHHxpBpumkjlug7ftUFByJ3
wx/MQaESEpixlro7gIvb1MkVlDSEoOvPDgH849lMOvbKv8tlKFHdPgRbyqlCgzU1
kLtQ6NMFaAoruOG0SvkF
=xjP4
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--

--===============5810934051709630352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5810934051709630352==--
