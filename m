From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm_adsp: fix possible memory leak in
 wm_adsp_load_coeff()
Date: Tue, 12 Mar 2013 18:42:26 +0000
Message-ID: <20130312184225.GL19942@opensource.wolfsonmicro.com>
References: <CAPgLHd9K-jMNYXY=sTkANCfzk_fCAF8arZUZHJmvBRAnCx1SUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6164222362892756846=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90026265DF9
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 19:42:27 +0100 (CET)
In-Reply-To: <CAPgLHd9K-jMNYXY=sTkANCfzk_fCAF8arZUZHJmvBRAnCx1SUw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, yongjun_wei@trendmicro.com.cn
List-Id: alsa-devel@alsa-project.org


--===============6164222362892756846==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qyHYMwAXsHLOQihY"
Content-Disposition: inline


--qyHYMwAXsHLOQihY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2013 at 12:23:15AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> 'file' is malloced in wm_adsp_load_coeff() and should be freed
> before leaving from the error handling cases, otherwise it will cause
> memory leak.

Applied, thanks.

--qyHYMwAXsHLOQihY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3cDAAoJELSic+t+oim98uUQAJAI2mUlJEXS4YjS6GrGS7Um
RRv8fhhg15WtpnedJsr34VfUuhUwid4YY/K9h56MUcNPqtc3JN/lqw/RJ4XIgHa1
ojuT/pc/JXaCllh3Ya0pwVv/+DNyWePtW26OFC7IJebRSuKOhTM1lae39TrrRu2A
eYedpCEU7FUWx0Z8CshXQjY9TehvTLs273HDrnoHzMoUaTbLauTNUfLvpdT4jB+8
SwVu9ncAQbYOdaSq1H9qZadmUN0v2kjnYaWS5GCDdIYjn1i4XrzmFfceLr9t/erT
Zcxvc1vLjGfNmMeWRqIIQp7TTv4gUkQl4Cy2rf3MjpTZXPL4rEwGxKCWFe+60akh
qtevNBPpo7mcmk85XHbSK5aoHP11SeTYe7/3XYpPNB4ruSyn9Fvcou095qDUkZ5L
vPFsF7AMJxAPMa7bJR3VO6Ix0xvpydn/CBRJp54MibK/raJAfTccYLILTuENzeW2
wbUELCCahG/pAfabOA9ApqPOPAFT12l3wcbmv1jrDX9sBCn7e2sv1oKpM/ndkHUD
pRDrpXdSTeITWBWAEzrgp88RkJvuakS6v1WNDnVY9YFRyg2KrqZj8o/H3pmfgJGt
cd1cQ//6Mop3JS3HxesHCyUAiiJVFm21Z4YRq5CDtBQBn01hLCyH/ED7Qw2Lwz1l
VIFKfxFDeIR1X2SIPwTE
=mYyn
-----END PGP SIGNATURE-----

--qyHYMwAXsHLOQihY--

--===============6164222362892756846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6164222362892756846==--
