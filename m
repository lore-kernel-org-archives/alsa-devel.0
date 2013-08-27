From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: Move call to
 snd_soc_dapm_new_widgets() after snd_soc_dapm_auto_nc_codec_pins()
Date: Tue, 27 Aug 2013 15:41:27 +0100
Message-ID: <20130827144127.GS10783@sirena.org.uk>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
 <1377611461-3638-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3978627798757128775=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E4F82652B9
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:41:50 +0200 (CEST)
In-Reply-To: <1377611461-3638-7-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3978627798757128775==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="szdyR02yM8NCQUEm"
Content-Disposition: inline


--szdyR02yM8NCQUEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 03:51:00PM +0200, Lars-Peter Clausen wrote:
> Call snd_soc_dapm_new_widgets() before the auto non-connected pins have been
> marked as not connected will power the system under the assumption that those
> pins are connected. Once the pins have been marked as disconnected the system
> there will be an additional power run. This can cause unnecessary power
> transitions. Calling snd_soc_dapm_new_widgets() only after the pins have been
> marked as non-connected avoids this.

Applied, thanks.

--szdyR02yM8NCQUEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHLqUAAoJELSic+t+oim9JUsP/0xoSRXeGOIOs24E5XNGdbUi
/0WWcOYIDE2Z9KqppjgV8t+IyknWrv34A34Tkgx3YcCVmAl0Di8ch/k/rjHgWCPd
xybsJr1Y3WhrOOlsKHnGP3H3a5CRvQHjn2Fhxnah/1VbOOSmt266DAnWAwuOBRrZ
sn+NFYXY+wKERsGKzmK9Mnk3ru68KamJKdCMK9sfheT5sRoyVXV55TUiQr6jSvh3
goXVsEruyaDtnNr6Tx2Kh69Eh4ndMbIchG3Q4sp5HKaazB+ajVldxWOAcpEpoOjA
NdxQbghLF1B+ELtewLT1FvxHzyWcu6+br4bguYsWGfTJDd6UE5N7MFNuQIIpAJBX
mP0ydBN5Q+LhwnHJuXjbe6+zHRGyddtBRH0mHMOsAwPl9OjyGHUBzs86eMVRcpLd
Pu0Uew4VVpYZzOL1JRbnbSF6T1fweZoZ+AnY8IC5pMaz9IkzuusoyXp7VesufJ44
lkZYLU6AR2AyHBifGeVO+tUyi2MjlcioB4HCOJBHfMySJZI2CGJCJGA7DPsOjELX
IKJjynYLCdfP+uNhbryDqSeOlWmAQXmSSbHtj+/ygjYr9hmK1au+rXouEo9fiMyl
28TSa/Pl+iS++XiQKDrsnSMF305xjDmNdCyab6wHprs+07BqHf30+X7RZKltET4z
Sv+q1e+sQ8GAyUE846+F
=/LNp
-----END PGP SIGNATURE-----

--szdyR02yM8NCQUEm--

--===============3978627798757128775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3978627798757128775==--
