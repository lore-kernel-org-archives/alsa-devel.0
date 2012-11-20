From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: dapm: Standardise ASoC DAPM
	messages
Date: Tue, 20 Nov 2012 09:31:09 +0900
Message-ID: <20121120003108.GB4483@opensource.wolfsonmicro.com>
References: <1353335955-5249-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6927641092354124744=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A804262624
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 01:31:17 +0100 (CET)
In-Reply-To: <1353335955-5249-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6927641092354124744==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2012 at 02:39:12PM +0000, Liam Girdwood wrote:
> Currently ASoC has a mixture of message prefixes e.g. "ASoC", "asoc"
> or none and message types e.g. pr_debug or dev_dbg.
>=20
> Make sure all ASoC core messages use the same "ASoC" prefix and
> convert any component device specific messages to use dev_dbg
> instead of pr_debug.

So, the reason we used to have the prefixes was that we didn't have dev_
versions of the macros - I'd been going the other way and stripping out
the prefixes for ASoC: because they seemed noisy and out of line with
most other subsystems which either use dev_ or put a prefix in but not
both.

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqs8ZAAoJELSic+t+oim9Rt0P/2C3NBMDto+RFXP8hmxCUsgp
qdo7eMXRsPqY2p+qCda5tDoPz4k2mDf6e3pGIWr94ia0zVWXtFe/1BuCvSuewZn4
6wyu2WC5+T1G975N6LmbFA+wLgh3qksvwGHhcnW47BUMvcFJHM5c3s4M5XCAr20E
AJtmTiDLQ6JjrmAOBMDt1X/IzqDWFlurVP/Xsd5dBG4Kpf7qn6Wlr8uPO6b6lUJb
IPva2Lh/ZPPT6WhmONpR62XHhP/e6EHgb/+03aPxueFlcLqsZ0FRNAJSK9elEUZG
iqpemCI0XhcDGL2FqPz5zYynuKt+mnLGjRU8g1tnCUTYiN2cQJlwMX56ekLb6LoC
MHgOMoKZ+OC6FefLRSUgiiADQdkpRCIO1IqtHMunLEFQI5+GbMYoO8ie85dkjcpJ
/gnwdKKGFasA4eWZJvDri9/B/xIiugcvqsxLOjMuFDpBGKYmr6kOgMYVBhsX6scz
Y87Wn8+xSECeTRUM4aWRgY5s++6aMeA+Cnu/IWjRNjYmq9+E4VF9uhilFJSY0mnb
TC6BUWXKL8p9JZiD1cYRdE6fkzLv+qcSjPUpiTAB12whRnXlbc77BfVYvyyZlzoU
seEm+oXluEpQ8UAqoQnk0GhX2a1SHKF0ROFGFP870Z4gDeBkMjeJZkg6QUXQKXLu
kPoi1aN67B7kYdd8OjO/
=k386
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

--===============6927641092354124744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6927641092354124744==--
