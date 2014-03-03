From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] ASoC: pxa: e740_wm9705: Convert to
 table based DAPM setup
Date: Mon, 3 Mar 2014 10:04:54 +0800
Message-ID: <20140303020454.GV2411@sirena.org.uk>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
 <1393685300-5307-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6224265952295673854=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E31412654D4
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 04:35:31 +0100 (CET)
In-Reply-To: <1393685300-5307-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6224265952295673854==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dIV3CY5swYZsO92m"
Content-Disposition: inline


--dIV3CY5swYZsO92m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 03:48:14PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes. This on one hand
> makes the code a bit cleaner and on the other hand the board level DAPM elements
> get registered in the card's DAPM context rather than in the CODEC's DAPM
> context.

Applied, thanks.

--dIV3CY5swYZsO92m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE+NCAAoJELSic+t+oim9VvUP/2ll4xajGktyW1/A4jHzF1r6
4zs1GDV2aL5/W0pmHYuaPR8YnoZh/fDhISK3xpP+K+ADLkvcFVw4HzJ0NN9l991i
X5vLC9jAUYe/hMyhU+y/LIURQh5IwyBhuL2xzG+LZUadY43lJeo6vN7MZ1j3kZVv
e3O6AfsTNsIcO4FdwmtVyDrplTiO8CSVMCDiXepk2MNgfiIpoHZZm6Bs6s68jrcL
k8idNlTxBnHkZH4W6o2aTYa534c6ZbdxSpd7rtng+mcep33/qE3B+wvzf3i/Lr27
EQYPWdPglXY0Y1y/iJu+Qz7yT2dz9MruBF6fLyWc/8MjeowdCzfZ02fGIis5M+kB
mypm8dcy5AYa8TmUC1l8TGdTPQNe5cRBmFdKBgeXU0K2Lz2wAQ/npkIKB3d0KrHb
FsABLMWOh9ZQnXaqUP6bCqR3SdQQR5H78TRsUnTxdj3yXcuIWrydozCoxyFj38WT
PRQ/pP9fYPhcRE1nyQ1HW7+MUfkJjJMMtUf7vLGDvmPb6uPrgLSoyIz5gcjbexDd
CSDm/YjY7IGQE6ZO1UHDuwzQfft6uwgJDKZX6MtLcUOV61nv2BG45xURn91EJnwX
bZArdclB02u1o2hKEdsfpU3RfKgd/RJkSZIf8MqMCmNdhgoWu/0TkiHfoDXzqok7
oS1kS0t4xhMZm1JEjlZX
=NulR
-----END PGP SIGNATURE-----

--dIV3CY5swYZsO92m--

--===============6224265952295673854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6224265952295673854==--
