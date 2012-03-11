From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mx27vis-aic32x4: Make sure we are
 running on the correct machine
Date: Sun, 11 Mar 2012 18:47:17 +0000
Message-ID: <20120311184716.GA3171@opensource.wolfsonmicro.com>
References: <1331477634-18616-1-git-send-email-festevam@gmail.com>
	<CAOMZO5BshX+2PNweT=fCaatGjs1=cwpSG6AtZazGs5LK4eEs7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5328791035000280151=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E8E9244DE
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 19:47:20 +0100 (CET)
In-Reply-To: <CAOMZO5BshX+2PNweT=fCaatGjs1=cwpSG6AtZazGs5LK4eEs7Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, javier.martin@vista-silicon.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============5328791035000280151==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 11, 2012 at 12:43:56PM -0300, Fabio Estevam wrote:

> Or maybe should I use snd_soc_register_card instead and get rid of the
> machine_is_xxx check?

Yes, please.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXPMsAAoJEBus8iNuMP3dB24P/RHIlhM85WZUeZOhrRN83OTS
BXwW7pfeLd+QlNBcaDShD6gRc21Sd6WeOvIs07pYizCqo1PXJQrqEFaQU4EUjX1T
6C/jA/uS1xaGZEcHcu0w/Sl6hMnUU0ekIt6KxL79CgC9LTrN4KB2xO1ygCMDCdD7
Y/ldGZSBhHbnsTVHxRm1SLYCB3Wnwt6vjHEO2qRHo+LhtdA1MNgaY/ZU+IUljq2L
Pv6XCGx/VC7Zo0iXq/WAbnxkcPowEmgBU9D/uqALCW6Ht/YXhPpyWkPsc5NncUkv
x2ktpmVN8WnhoBb/VFKLuAUwZaUqRP9lgLOgaDYuSlcI54jxaqgiZMqhI3K3jkQc
umdBn03lUX7Ym4XHaLeLeY9oONs2ap7LkoizdS6GIqAjaeWibRLDvsYwJxuHiEt5
4Ndqzq7hv1XUs9+2XCkJtD+/6VugTwTS4nr+6kQB6SGD+AAZ2yMJQe5/C84REA0H
nHCmPdN3CgpuVyVPmfVosQk216nf13e8fVNFX86ImawwXhcNH707B/EHEmU8LHEZ
IBV1vCHo2OPPkW/AyMtoIq23xS5UW7qjV5KuqKC17IbeEi39gT84VqZhBCmilR2E
6HN3y+M2UkrpBckL4S6QXCzq0V1wjcqhz+yzCBOdNdt4SHp1QNy87vto2SsJBlV3
OijOPmbjFcW2jueulV8k
=DFWN
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--===============5328791035000280151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5328791035000280151==--
