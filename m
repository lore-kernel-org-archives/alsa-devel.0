From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx/mxs: remove redundant SND_PCM
	selection
Date: Mon, 20 Feb 2012 07:46:31 -0800
Message-ID: <20120220154628.GC3258@opensource.wolfsonmicro.com>
References: <1329721524-28394-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5158256388654125317=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A67E524375
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 16:46:38 +0100 (CET)
In-Reply-To: <1329721524-28394-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5158256388654125317==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2012 at 03:05:24PM +0800, Shawn Guo wrote:
> SND_PCM is already selected by SND_SOC, there is no need for
> SND_IMX_SOC and SND_MXS_SOC to select it again.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPQmq6AAoJEBus8iNuMP3dfVsP/1hXAk9flN+BmIEyIgJLVKCs
rNAeawiPez/f654b02aW8k86xstZhdjo7rZYDtiexQZ34H3wVAohSTMjsvBn62Zz
0EDss94szOqhgQm99PJ92uo293WKg0jhhspmFoVQRnNEg7TKDAsr4cCHieFzaIpa
IvNZT8eHZGERQx9+06MjTZaE1g9ua8R9yDp4KA7G9N99s0t51UvkRAjCRArla09U
IyRTwISpDQwWswLhy2RexAPNi2xNeV88ozpfMMzQ5pt0Um3zgq5aeUeZMtSS9Tqx
huSq23Umd5Yz4avM5lnee2aCW8CnN38+gATa2o5F1wT3gqM8HNXhIztQLFRM8TGr
I6JyNxMqizUSBtLkwnqgGxe2NotGeomXTKDy0ppAGmE4m0kbdgyp4Q5nv8vxoWUq
i7t3Tu1gy3XKA8PqdlFSjz8cd47Tk8sWQBYhJDm8d2jRgBIpM08XIKSXZOXMpSq6
nrgAN+mdUB9Me/4EU3pOCvD8fLchFaMUK9eo0SvGiRK3PTjP257qAF9JP3Wrz8ik
92HNEbAHmntUjnT4nmGE/yuW3KMer5iULGucr53usyTLp0EzF88RmlGjot2hML3n
bbdAMOPAyEhJqHA04go/tEJH3lBz8x2K7yXFPOT6Gm/H2jSxTFkPrU3NzbOlDVE4
z1au+G0/AwoWw0aLST7U
=YvrB
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--

--===============5158256388654125317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5158256388654125317==--
