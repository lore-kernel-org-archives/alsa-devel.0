From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/4] ASoC: simple-card: Add DT
 documentation for multi-DAI links
Date: Tue, 18 Mar 2014 10:41:59 +0000
Message-ID: <20140318104159.GF11706@sirena.org.uk>
References: <cover.1394883134.git.moinejf@free.fr>
 <d054780a0edf4b2338a52e48bff9144e19aa614f.1394883134.git.moinejf@free.fr>
 <20140317164339.GR11706@sirena.org.uk>
 <20140318091728.1d2240ca@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6369137305049575965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD01A261ACE
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 11:42:05 +0100 (CET)
In-Reply-To: <20140318091728.1d2240ca@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6369137305049575965==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MZQ2DoTi1EizrxJt"
Content-Disposition: inline


--MZQ2DoTi1EizrxJt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 09:17:28AM +0100, Jean-Francois Moine wrote:

> The 2nd syntax is simpler and clearer, but the properties of the CPU
> DAI and of the CODEC DAI are the same in the container (format, clock
> and PCM slots). Is this a problem?

Yes, things like clocks might be different.  We need a way to specify
DAI specific properties.

> BTW, there is a 'dai_fmt' in the DAI link, but this format is not used
> in the simple-card. Why?

Could you be more specific please?  If you mean the dai_fmt feature of
the generic dai_link struct then because of the confusion about what
the DAI formats mean which you'll have seen on the list.

--MZQ2DoTi1EizrxJt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKCL0AAoJELSic+t+oim9M9cP/1CXPHzDtDYkZAMh6E3JSpuV
u8dazvw2YmRyXYu9B7LSFdpSz9Rb+vi0zM7cwmWAvGjZNvvyKbV4lEliWiYzKh7f
pctkya3dYjn2wB1791Z2/CqMQ5NNyRK7Lf1D07uD34/B0A4Dcew7LxhI7uifd28q
mFl9IbWQ7IK6rSpwMxfiQQj8H0P3FnkwfrJVZRSUxTDxpwSIXyPXAQm9jKebpwpl
pGIZWd6khDLv/L3AlEHpw/2Nv38FvnALYCvVpqHwnHkWmqokP3Lv0dTD9JWTukHn
VyKfO2b6IfM3nAHCTJpK/HsO7QG76O0euf0Cg7KS5wdFT2Yc0FZdH0qSJZva+UIv
b75paYe3atp+Fs2yf1VD/tlxp64nMxdXPUTt2jUz8TAQKlM+s6jl9pdf5wdl75IY
eblnyQYG9TXUjz7U19A9r9yu6cGQOuY1OO2bkKnuPi1cqy72fVwRIF+myPYZ7TmZ
UqCJ2vrpyGfoqe/TuZjOFwS4TqeSoFgKDbb+iYZKqAqILG1q4LlaCsVcHa5IYikl
7pDPnydTqt2UDixIMBf3iw4X/1fRiW473Vga6um4TOcEEfwXo8KxjPhfSm/wG1aL
cgAGtxWAnyaJ3I0xnP26GqnsJDtsUXkQ+rI+ZjjkzJPCQ6H2+smb8Pt9LGfmAjfL
BwN+6BlI+RASVHpBBi+l
=ZG4j
-----END PGP SIGNATURE-----

--MZQ2DoTi1EizrxJt--

--===============6369137305049575965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6369137305049575965==--
