From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/8] ASoC: simple-card: simplify code
Date: Wed, 22 Jan 2014 19:25:56 +0000
Message-ID: <20140122192556.GW17314@sirena.org.uk>
References: <20140115113551.0eb13409@armhf>
 <20140115165141.3ab93dc1@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6942808707384562694=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DAF4261609
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 20:26:06 +0100 (CET)
In-Reply-To: <20140115165141.3ab93dc1@armhf>
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6942808707384562694==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LGYlOP0sYR/qQmXe"
Content-Disposition: inline


--LGYlOP0sYR/qQmXe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2014 at 04:51:41PM +0100, Jean-Francois Moine wrote:
> The OF pointers are put in the stack and then copied to the card
> descriptor.
> Put them directly at their right place.

Applied, thanks.

--LGYlOP0sYR/qQmXe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4BtBAAoJELSic+t+oim9nPUP/RSAZmjxhL/Gu0uife9qVGX5
QjkqcsKUo/27AgtA3/8fQOYSqqhZ5uqVhImTqC7rhxmU5BZhv8Z+q61/QlUXPG70
LSoNJuNCZqDIp+nX2N3Kfv78mpgx+OfvsMgcnBBGXIEpPGZkOhN/D7c2+sr5VKCE
+wseHYQSzxJ7+STRziSCmzoY3hQ83j+5W8k9cL+wtsEUvsadPgd4BsvjivMMlp5u
h9DWlLFBnaxeXBXsNvI52DLtzKIa/UvMWNID1THS96KXlZ7qGcf8hPIDC7N3aRDr
RHTCVyTFhcly32ckw2Z+6Y5Tl0fsUbx/iYTpjNSFkhYayFPSC99sbntIH9MzxoJi
Pezv2WP+X2/yTJTacW6mhGrL5BotMpuHemrj7AxDGJD4ehOTL+PKAil6pOHT7gIB
zpHzj+95i4d5G9IWZZdrVXnzaaZ1JKKXvzdDIknWJ+AMAhMb7Dac7Yt8k4b8Pl9S
G3lCESb/fSsLbFB970bOf9NZk5lNt+wGxhyciguAawC5GvjNnOYr6/XoYOgNGQ9m
uiuBJtfAtaMd233DtxVdLtEmz5KhTgUUltUnoFerKYRPeq/QRBCyReB+t8LCDeoz
wh92rX5GWaXyxkBYx6/4GLs05d9w0UkNCT7caUJl2nP76CZ69BfY9jhNXawPNIC9
JY3U92nBEfBhbKXQe26a
=x3jM
-----END PGP SIGNATURE-----

--LGYlOP0sYR/qQmXe--

--===============6942808707384562694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6942808707384562694==--
