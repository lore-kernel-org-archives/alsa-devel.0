From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v3 7/7] ASoC: hdmi-codec: Add ELD control
Date: Tue, 19 Jan 2016 18:32:11 +0000
Message-ID: <20160119183211.GT6588@sirena.org.uk>
References: <1452613096-8116-1-git-send-email-p.zabel@pengutronix.de>
 <1452613096-8116-8-git-send-email-p.zabel@pengutronix.de>
 <569E2545.9010602@ti.com> <s5h8u3ldbb4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2303923592559672665=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 207A2260544
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 19:32:25 +0100 (CET)
In-Reply-To: <s5h8u3ldbb4.wl-tiwai@suse.de>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--===============2303923592559672665==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="imfu1ARW87HJT4Qa"
Content-Disposition: inline


--imfu1ARW87HJT4Qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2016 at 01:05:19PM +0100, Takashi Iwai wrote:
> Jyri Sarha wrote:

> > but=20
> > shouldn't there be something about it shown under /proc/asound/card0/,=
=20
> > or am I mistaken.

> It's specific to driver.  HD-audio has one, but it doesn't show the
> whole ELD but only parsed contents.

Seems like it might be worth standardising at least some aspects of
that?

--imfu1ARW87HJT4Qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWnoEqAAoJECTWi3JdVIfQorkH/2iYDyWwvhDMxcIN9ma7u++2
N+YhDQ1XnjwuWJPY8H/83H5FLrWfb3z4dOJVn7gPhroXV6p1Uv2e2cxhbNYLWfpd
Bk0Vsft2R5VRWEjd3OL9ju02ednxo9TW1fkuZmVFYoFiMhmHP4DQlwsmQM2tiKKO
W94n0/OBIze16fQhLVcYghqNRKbChrvttq/ZayMzNwfBJT/9obG9+g6W5Q7HiIej
64PgXjFCiqtsPYVzwykLyzgJ2UIbu+YB7JGdlhhb9ZezqxfeMzQd1t29epPSYdlo
ZCGLJQBpWF6SjJFUybtQ8QKvQwwaYTe6rpIRc9f3ff9AAcf6yaLwyfZjhzVFxYM=
=LFsN
-----END PGP SIGNATURE-----

--imfu1ARW87HJT4Qa--

--===============2303923592559672665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2303923592559672665==--
