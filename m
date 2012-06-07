From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dpcm: Fix dpcm_get_be() to check
	that DAI is BE.
Date: Fri, 8 Jun 2012 06:57:19 +0800
Message-ID: <20120607225718.GE14525@opensource.wolfsonmicro.com>
References: <1338920819-5246-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8328231486418984563=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 176D01045D2
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 02:53:32 +0200 (CEST)
In-Reply-To: <1338920819-5246-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8328231486418984563==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 05, 2012 at 07:26:59PM +0100, Liam Girdwood wrote:
> Make sure that the dpcm_get_be() only returns BE DAI links.

Applied, thanks.

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0THFAAoJEBus8iNuMP3d8IAP/32VouiZsKdYjnEoFSav/JVV
SEifecWrWmhvntB3cgklXHO6xB5NifMi/kZCoZbjajSlKcGpQ2jjp3g66rLbqaq1
0Hf8tuZ+zAZUlPr/10PB7lfjLA6A9WqJSRGbFAUHGDnAkrePU3omIVKrkkD+9Bj4
kFJD/iP/5NT76VjF8zc7E1vza+5kjzO1nXFh/RfYgpwInLVvokykkmIU2GgvQBDj
+Im4UQLR2rGXzE6MqYMPBr+H0/nqGUueUr8BN00WJgHYCaXROJ4KhcK2KwtuvB/E
Z2HSORBRiIfxdgzr1gvXMO60UWbHsq8bIaHhfR3zvWdMQfOKQ1X5gasmRCuXxSju
lDdVPtZHOForJ6mre3BdUGI7QRJI5r2tFDou/d9SD0F2UuiDZHJ3UUkP9NXGTzSp
ciOlvqmFB3ainRM24QjsKQKSqp0mFMAuAUmiG8130L6DNkQ46M1ZgWKyPDY4JnO5
kTq7kZfMirx/UHjpRQg4TzNPtuDy1wUGVH0WF4TjC/1wRi6TDx49+gC6raWXCefG
QxZBIra898LHMwjUxZMAV/u6rfeyhBUK8N7BzKx3OmyGNRa4BiXebcxn9GDRQLD2
O/YSDcuHVEz5gDTV3uKgBLiIoYkkpyd3yDA8fup788FdbzInZHrNr83vzRU5VYkI
45hJvRvrmzGBOtmt/7mp
=pqFW
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--

--===============8328231486418984563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8328231486418984563==--
