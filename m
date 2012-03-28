From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sgtl5000: fix power on/off of MIC
	bias
Date: Wed, 28 Mar 2012 15:36:50 +0100
Message-ID: <20120328143649.GU3232@opensource.wolfsonmicro.com>
References: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
	<7FE21149F4667147B645348EC605788514EDFF@039-SN2MPN1-011.039d.mgd.msft.net>
	<20120328141812.GB3254@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3886727107293502807=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 02EC02417D
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 16:36:53 +0200 (CEST)
In-Reply-To: <20120328141812.GB3254@S2101-09.ap.freescale.net>
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
Cc: "Zeng@alsa-project.org" <Zeng@alsa-project.org>, Xu Lionel-R63889 <R63889@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zhaoming <zengzm.kernel@gmail.com>, Dong Aisheng-B29396 <B29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============3886727107293502807==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpljlC28XhFjURzf"
Content-Disposition: inline


--IpljlC28XhFjURzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 28, 2012 at 10:18:14PM +0800, Shawn Guo wrote:
> On Wed, Mar 28, 2012 at 09:52:15AM +0000, Dong Aisheng-B29396 wrote:

> > IIRC for line-in record, it may also need VAG_POWER up.
> > Then only enable VAG_POWER for mic_bias_event may not be sufficient.
> > Will verify it latter when I'm free.

> This patch only fixes MIC.  I think you can submit another patch after
> you confirm LINE-IN has the same issue.

I think this is a sensible approach, two patches fixing two issues seems
reasonable (and I'd not expect line input to need the mic bias itself).

--IpljlC28XhFjURzf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcyH3AAoJEBus8iNuMP3dtIcP/1pNydcYujeRvkW/6KUugigj
Q8JcKTFf2u9vTo7Ae9V/H+9jrxoRijkK4zciJHqV0ByKQFus0DZT+0uRchrBa4wr
ZslSiTTS3uosj9cjNtQaloAF/0/tK44Jcj9F1qVJTrzQph2/Ynlc1Ds1/uPxdNKG
7yQ07TUQswBTyJCc2xK0mtxLILbBB287epoc0Cse4DQ8o7/RlUB0qkINvcHe45HM
1HqrwMYeIIEiOIXktVPX102zSmjS5PsZADSs80u8ybT2M92WgogB79MaaADjB++m
rE7bHWmt8K93k71vEWYeX/89rw5Mu0eA8Y3rqmDH6242GvO0d9/WzwRy9FRY4x4B
7koMxrN/yZCFw1BUkqVQTr9MIKAhDBrgiEH2ZOEqRZX1EDfhlloY+4CN9v1YG33m
fs+EBT//MnbDgakYfhyzIJL3jkJ6cKdj7tXH0HylS3mh0NgfWGKsyF+Un7DVLbJE
AXC9fibTkAGV+b13CX0gRyfGmL0Oy2PlQsUPWsS4QwGFhgy+swZs/sultLmLKi1z
sycED8HVAL9FNGoOmbuwqqD3hkI4PtkkXfvT7QygpbCCHi0QRoPVjc+/ZqDXXhi8
vobSoZTN4WoCeopafhixdYvKiiaRPfe70WRcuW1bu0e445JH4gP5b/yf70ONRKvY
ZhPs5aOUTulQH8naoiKf
=iFop
-----END PGP SIGNATURE-----

--IpljlC28XhFjURzf--

--===============3886727107293502807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3886727107293502807==--
