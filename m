From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/7] ASoC: Samsung: smdk_wm8994: Fix build
	error
Date: Wed, 22 Jan 2014 11:10:21 +0000
Message-ID: <20140122111021.GD17314@sirena.org.uk>
References: <1390371213-21643-1-git-send-email-sachin.kamat@linaro.org>
 <1390371213-21643-7-git-send-email-sachin.kamat@linaro.org>
 <s5hlhy8v703.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3432284912746848264=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24DFD261A80
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 12:11:25 +0100 (CET)
In-Reply-To: <s5hlhy8v703.wl%tiwai@suse.de>
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
Cc: Sachin Kamat <sachin.kamat@linaro.org>, sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3432284912746848264==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+1XiaZWzQ61FkPh"
Content-Disposition: inline


--k+1XiaZWzQ61FkPh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2014 at 07:57:16AM +0100, Takashi Iwai wrote:
> At Wed, 22 Jan 2014 11:43:32 +0530,
> Sachin Kamat wrote:

> > Fixes the following build error when OF is not defined:
> > sound/soc/samsung/smdk_wm8994.c:191:23: error: =E2=80=98samsung_wm8994_=
of_match=E2=80=99 undeclared (first use in this function)

> We can just remove the #ifdef CONFIG_OF, instead?
> The compiler should be clever enough to drop the actually unused
> static variables after optimization.

Yes, that's a nicer solution.

--k+1XiaZWzQ61FkPh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS36caAAoJELSic+t+oim9rDgP/iTzknO4kRlpLY9GYa60Ykof
TBCd8MHBiNnbuamRA5ItQeOiJbY+wEYLY39D24c/lU2v3Yd4MLBQcQMZpv/KTm7M
PCMVDpiOxztxdzurhYA2D/tpIYu7oBH1QC4Hjq4fSr6RR2tDcCkk9iBFnFiMCBEE
/zkVJn1lRwntOCb+vEgTOiTwftlaOzwdg7Zw4X0BfZ3lj55WAf5VLC3PJsMUJ5V2
055MTcuD7y51Wg+bxBdU38kfgFwmaytDhVZmhRA+I2MELUMPRAtMo5ZGLwnKCA2q
b+Vk58HyFKlj1/g8oqVnTF0w2FQjiQ7deyEiu7zLd4VoGpqnOyu3f7a7Z8Vo2B8X
6eIUF8Jo/tkn37reggfYNrl00+3BOfU2nE3sdG0N8xR0agzYZfYA6ZWvL3SiVcu7
rx1DVNG5RVC/BcjQjX3BZ1O6Ib6jqjk7AOXUI+xH9zskJ9OT9Yb/LSY1EBQ6x34u
T6Y3wUmV+Va077rRrBLB1XqeE/8lRBLcjCrCPczhXMXZlwIOIX6entuDMTIIQcIa
w0bHSQ29U4J8b/RePReNDadRg/6Xo8+Lm3nkW3pPGNI4j+xtRxU6k+iadx7luvKK
GnKNTVfC8SPGabHKUiglUVeDLtyY5jRakVRt2lKlDLwu0DaapMQLrxh9iURLuL4I
ml7ifaxnl+qtjqBTLUzW
=++zp
-----END PGP SIGNATURE-----

--k+1XiaZWzQ61FkPh--

--===============3432284912746848264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3432284912746848264==--
