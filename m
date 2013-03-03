From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFT] ASoC: wm8350: Use jiffies rather than
 msecs in schedule_delayed_work()
Date: Sun, 3 Mar 2013 22:47:12 +0800
Message-ID: <20130303144709.GA20331@opensource.wolfsonmicro.com>
References: <1362298850.9569.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0984234033627189647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14642261739
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 15:53:16 +0100 (CET)
In-Reply-To: <1362298850.9569.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0984234033627189647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 03, 2013 at 04:20:50PM +0800, Axel Lin wrote:
> The delay parameter of schedule_delayed_work() is number of jiffies to wait
> rather than miliseconds.

Applied, thanks.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRM2JeAAoJELSic+t+oim9vSUP/0MZ87oMl9JqjEzpX59FteIm
8tEl57qM89UZDag198wNFa5qWQe1QoRMZ7atZ39lQIrWhBIxMBnCiTs3cqWppn+r
Da/32fxG77xRwMJeGmkwBXbo6jmaeEf1j0PNKtmy2DIIHpXr5/8bfPiP3HVzeLAU
CtAcR9YDuXrhTw3TOxq9wT//DRT+19K4CN4hZ7HslNy9B+JaOAWlZtsnSSjKKbrX
V8EfwXGxlAh+ZNGD2b/9cSifYFbnbmCVz/U5c/Q0p/BKbGYh/kJOM2oTc3ZfX4rE
qh6A6O08x2LEXG1nvO1t4/pb0fpCdWQT8uMBRnwGG+YRhj+bmaEOeiD+cRSCP5xY
S2zs+cmJmChIYdLGH1hkvu44Yy4bFyM09ukEQE3Z7OF4oWSKrtE8pUNi9EhHPHCw
eQf01ok2Ig6hxkMZxjRokxYGORHj1fDPRP6dk3l412zZ1nmQF2yVIFVyv59vNbOe
VJD6Js9sKjw7uMDApaDbP6aFRd899+qwl54ENgVmXNuNdBcMkvhWuooEmqsdLOzP
3kW8ceLHdg+phWdWR0VPGUBCZsbcFVgf5hAeQTKsnPUzbrRyPgFfwoPUAir1BMWu
HgyUpfBUDwPBqBwNrae2zfVxtRLB6fI8ExO4Vhk20iGyIP6BP4YfDRXqzvexh227
u0CJnlDmbLIPPosL4Hjm
=eF90
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

--===============0984234033627189647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0984234033627189647==--
