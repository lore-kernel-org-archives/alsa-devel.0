From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: Add support jack
 detection via codec
Date: Mon, 25 Apr 2016 13:55:04 +0100
Message-ID: <20160425125504.GL3217@sirena.org.uk>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-3-git-send-email-zhengxing@rock-chips.com>
 <20160421141921.GA25900@rob-hp-laptop>
 <57197BBA.50304@rock-chips.com>
 <20160422092250.GA3217@sirena.org.uk>
 <3C927D46-BC52-4B5C-B5B4-CCBA3AAE6F87@xenotropic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0679803396192724603=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19522261AFF
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 14:55:33 +0200 (CEST)
In-Reply-To: <3C927D46-BC52-4B5C-B5B4-CCBA3AAE6F87@xenotropic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeremy McDermond <mcdermj@xenotropic.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, Xing Zheng <zhengxing@rock-chips.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Takashi Iwai <tiwai@suse.com>, sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org, jay.xu@rock-chips.com, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jyri Sarha <jsarha@ti.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org, Adam.Thomson@diasemi.com, Kumar Gala <galak@codeaurora.org>, Jun Nie <jun.nie@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0679803396192724603==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8Km4OLyaxUtVIPha"
Content-Disposition: inline


--8Km4OLyaxUtVIPha
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 09:37:39AM -0700, Jeremy McDermond wrote:

> components fairly well.  I=E2=80=99m just trying to wrap my head around
> where this all would fit in.  Should the codec driver just register
> a bunch of clock components in its initialization somewhere?
> I=E2=80=99m thinking that it can=E2=80=99t have its own CCF driver separa=
te from
> the codec driver because you won=E2=80=99t have proper access to the
> registers over I2C or SPI.  I don=E2=80=99t find a lot of examples in the
> codec drivers, and there aren=E2=80=99t very many other drivers in the tr=
ee
> that seem to register clocks with CCF that I can find.

If the clock code is worth splitting off into a separate driver that's
what drivers/mfd is for.

--8Km4OLyaxUtVIPha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXHhOmAAoJECTWi3JdVIfQAcAH/j75szg8/VKCpHvhAc75ilq2
ibJGnlJtBW0OtsmPem0rSXULDqk1vQQbjzHPO4eTNPZEpy7PLYC0YQ85sjqtQ0AQ
Yk5cdckj8qyxRXEdPjre0896xz88N71kZ5q+ANxA+SYjyeSI2ztVV+hEH8w0t9J2
4bbZYK3LMFYXlDrff/HrNvLqAH9hNRSoNKefQthsC3V9HxNid4YRnojERhOnTEUi
taUey6o6ecnKjNcQ0QcbWUiFCdFGHmoREOFRaJP12LDCYe4AWeIuetGNVf0wWhXD
9ygY3OLuGKgT6UqNShSqHT0Gp4aI5FgXEIJSp2OYjDIiErmFAGxb0YsjjlLR5VE=
=clqe
-----END PGP SIGNATURE-----

--8Km4OLyaxUtVIPha--

--===============0679803396192724603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0679803396192724603==--
