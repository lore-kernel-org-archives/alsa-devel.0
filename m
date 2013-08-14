From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm8960: Fix shared LRCLK support
Date: Wed, 14 Aug 2013 19:22:12 +0100
Message-ID: <20130814182212.GJ2401@sirena.org.uk>
References: <1376442946-2803-2-git-send-email-mahaijuns@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P7Tqkd/m/Jnohiaz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1376442946-2803-2-git-send-email-mahaijuns@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ma Haijun <mahaijuns@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--P7Tqkd/m/Jnohiaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2013 at 09:15:39AM +0800, Ma Haijun wrote:
> Shared LRCLK initialization does not survive wm8960_reset,
> so place it after the reset.

This is a bit odd - why is it a good idea to be doing a reset and
shouldn't there be a register cache sync to restore the setting anyway?
I'm not sure this is the right fix for the prolem, it could just be
fixing one aspect of a wider issue.

--P7Tqkd/m/Jnohiaz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSC8rRAAoJELSic+t+oim9d7AQAIOAmPIcYY1dIdJU2Cm2T4Ef
vLFcFXFROEZKgYKqF+vzOID9WGtnu5Hqai0Pp77HOz1zWjGmSyTSlxivxj0l2tO7
8UiN/8A6TmnMEkNc5/JTk5qgQLhU3iEUx23FjMF4r9Vh5KnE54VOU+cFRMH95Jo2
HRtrVEvWf2P4YL2JmSkos4QzuvyIZspjE0FZ3CnPFdkLNDuTzzvM4yA5Ddx4iehh
ytPjS4QY5icOz9qVCsRYVT8R46aZmvCIvGlmvlnYJtuN2eMONgjk5QYOucb7DYDO
lh5azMBfbJ5HXV7acDCSkofuFQ11vnsVUnvoRvrv3GX8GSMhnfkXJEk5YboN1Agx
yI5nC6Vkm3fptRaNUU25M7vCpFa/Qjm3g32vXZ1+/h1hEl4y5+EogRAtEKVtUnZB
XW6q4ghf9FGuKg9u5Ygps41a+gE2ztc1v2+sC7W84hgt3Ua/51W3/XI7euYDI8q4
/Yf7OtdyWe/aXlWtTRfx+NML+YFcoNJErndKSNabHMPTcTvXeIa5ogErQz/kAlgj
SMloc8ADbIg7X1PMId3ZIxgQomgqUgUAIRRL9STaOwqMAET+CIsBZ9GbrzZVDm1i
bGh7FG5jgtKE1S3kugQNlaOz2dbbxTmWFjDZpQJaNhJ3alJZhxhqYJIVT79AKbIi
cXmqZaIG5LkvVDVpyeZg
=JfD7
-----END PGP SIGNATURE-----

--P7Tqkd/m/Jnohiaz--
