From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH] ASoC: dapm: Fix/add support for stereo
	widgets
Date: Mon, 2 Jul 2012 13:27:14 +0100
Message-ID: <20120702122714.GE25093@opensource.wolfsonmicro.com>
References: <20120630182446.GA28922@opensource.wolfsonmicro.com>
	<134211720.502545.1341229602023.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8030088199432478718=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE52C244A3
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 14:27:23 +0200 (CEST)
In-Reply-To: <134211720.502545.1341229602023.JavaMail.root@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8030088199432478718==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2012 at 01:46:42PM +0200, Beno=EEt Th=E9baudeau wrote:
> This patch:
> * adds a choice in snd_soc_dapm_get_volsw_mut() for stereo between 1 and 2
>   registers, like in snd_soc_get_volsw().
> * fixes the missing stereo in other parts of dapm.
> * removes the unused saved_value from struct snd_soc_dapm_widget.

There's a couple of high level problems here. =20

One is that you've got multiple different things in a single commit
which isn't great practice for review, especially with such a vauge
changelog.

The other is that while you say that this "fixes the missing stereo in
other parts of dapm" I can't see any sign of any changes to (for
example) the path setup code which would seem to be essential for
supporting more than one channel in controls.

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8ZOOAAoJEBus8iNuMP3dvNwP/2jrPUaMV8d7jDTxWRbvsDro
UhRCRutRc/2XlVQwRiqKzcWcsIyB7docxzFMtI5lU/u8ewASAzPNSObIAjtvbB/p
BWxDqaFqSvIZX7dRadtP4Dh8bEgk4czlfN1xA/7SIKtx+JsWKvUgLaRzzHGVbzSK
h00bUHE5Ei6HC0lQpHggWnXNXm6zTku/k0vc+uSrFBcTEINttz1WonRsdibHQt4W
vcoih96cbcfyAKxVeLPAZV1HkP3UPfag5A4oxHKXYMkPiZCUaEWo74vLmLp1CEH0
xDda9HnyW5nM8nSrM5o0wbYmMPO87GFAR7KNXP7TMaQyRi3BLCoSN7ddmTFKJ5GL
IL91tQ0MS9jZx72rn/GZpPm7D8iPvgAZEGtoD+S1q7qf1Uswpxtq8mqJyZZ2Lxxq
FA4AwLa4yNZS9rca9ZD8y0qzNIY7fRhls695b2s0YF+hTKVa219tE7XPP+0imKR0
HU1lPm4X4F7DRHDGbuIEH32Qvt0E20EMrKsAInkJy/hIKExXKRUePX5RVNkfrAW8
WG77vi7sEzv7vtwmKmfmz2VL65kOq8UqZLtGV3W0hIVRwQKc2xwBqTWmLvG2paSB
TDXWN5u7GwCDfgZ3ZarCSGrMZOZBeyBrk4fquV5MkvcgRMt4Qg9crZm3t2ge4Uan
ScERqgz9Vvsq8vFPp/hs
=elQw
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--

--===============8030088199432478718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8030088199432478718==--
