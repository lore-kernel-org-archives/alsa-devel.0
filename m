From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: alc5632: add an of_match table
Date: Tue, 1 Apr 2014 12:40:15 +0100
Message-ID: <20140401114015.GN2269@sirena.org.uk>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1157129853916028532=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0374C2652AC
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 13:40:23 +0200 (CEST)
In-Reply-To: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1157129853916028532==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="59V5pGBotOHHLP27"
Content-Disposition: inline


--59V5pGBotOHHLP27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 12:38:16PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Add a device tree match table. This serves to make the driver's support
> of device tree more explicit. Perhaps the fallback for DT matching to
> using the i2c_device_id table will go away one day, since it fails in
> face of devices from different vendors with the same name.

Applied, thanks.

--59V5pGBotOHHLP27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOqWcAAoJELSic+t+oim9rBYP/jHNMRwxNPkc+wWJ9GgA8B8Y
Cy0safxnyTgF0FtyfWdr7/R56jkjwCRnefT29WrJ5J5DpUJXq++kf9sX2arVtWTP
82Y97tz4kbYHdY3iBbPRhaf9DtkrtUrD6bG9m+NSyBfqYRnd74LMfAKSItI1USlp
QmKB3Q3J2j4BoBivsBR9j+/Wqay7m1trvw7NfH7fZLM0LEITWYJFLSCleBFkA+3G
m51hLOC8+prbmMwSfJDGGIR0ydAtEJ9AcXSanR/YR7OLyWLC9KkDvKg/BdTCevJh
TFsDmMvfi+U+qwfvxjhjjl2s2B1RsrjkPONjT4G5WAj1Rm42xTTz1AZ9kYSg+ICE
1ma1cpbKoUBaHENYi7wqlwBfCefteEdggEZqjN9ICoLKWjfWkZ6WZo8iH6C0meTD
oMTXt4OI1nnRe7sjq2Sr2bPLm7g+/imZrQGdEQbUTUD4ehQySuQPjOCElzs8ztpe
i3tEAOPtl/cbyugv7ec4vZmgUWYSJKgsLZRo58UU8UXizs/4B4McbA6hMmUu2nwi
sISTL3/RLrZelvwYmCsPKvNJ3KKxCgdm+X+UZktq8Ugx2HqiqiHhBdpZAOxb5r3Q
aEHzBdfKst3wwDzpYuBIq+jtTTq+a3n/hm3tANu0ITdMGk03Qb+u/mkQp3+7RyUZ
WsM87MxHufq3aFb68G18
=bMaU
-----END PGP SIGNATURE-----

--59V5pGBotOHHLP27--

--===============1157129853916028532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1157129853916028532==--
