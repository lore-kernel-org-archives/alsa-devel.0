From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: fix interrupt fails and
 unstable after resume
Date: Tue, 15 Mar 2016 09:27:35 +0000
Message-ID: <20160315092735.GI2566@sirena.org.uk>
References: <1456686105-6885-1-git-send-email-KCHSU0@nuvoton.com>
 <20160301032623.GH18327@sirena.org.uk>
 <56E1105E.8010604@nuvoton.com> <56E7BF5F.5000103@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2891166232726806464=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (unknown [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 75FE1261298
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:27:56 +0100 (CET)
In-Reply-To: <56E7BF5F.5000103@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2891166232726806464==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v2/QI0iRXglpx0hK"
Content-Disposition: inline


--v2/QI0iRXglpx0hK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2016 at 03:53:03PM +0800, John Hsu wrote:
> On 3/10/2016 2:12 PM, John Hsu wrote:

> >A part of suspend and resume action moves to set bias function,
> >nau8825_set_bias_level.
> >We make register cache dirty in bias off; and make register cache sync
> >after resume in bias standby.

> Just confirm it. Could you accept the explain about the register cache sy=
nc?
> We need to change it or not? Very appreciate.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  Sending content
free pings just adds to the mail volume (if they are seen at all) and if=20
something has gone wrong you'll have to resend the patches anyway.

--v2/QI0iRXglpx0hK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW59WGAAoJECTWi3JdVIfQI8YH/i2EhmPkiqhvC4mg2IZ8YOHQ
2q6YSXrPiQBf6HgrF6Az9DDL/V7imdphPMD1BPKkkjQ2CxxVjNLdivsmwyU4XW9I
P94OryiSmqrgnhJercUZzV2ChDUP2UYTnq4rXoWCJahwjVWzUMXOToWbW4BR20dn
hsg/fzr6h0PH7h/qJwxrJa6ufCgSioGPrL3dIT7+3NwfLF7qHq4wr0daxW8XEK7P
Rnj13CF8xWG/dgSofkVVKX4iAymZj50ot2p1t9LUUhgceCIhRso5Q0qDHtV7KsCo
+ZKUpJq+47ZMAVYljGI++bBfcktk9fF2ndDwqF4cxHaAQr4sDSpsmGucjbwgmXw=
=ppAD
-----END PGP SIGNATURE-----

--v2/QI0iRXglpx0hK--

--===============2891166232726806464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2891166232726806464==--
