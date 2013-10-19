From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx: Open code dma channel request
Date: Sat, 19 Oct 2013 21:30:15 +0100
Message-ID: <20131019203015.GI2443@sirena.org.uk>
References: <1382212933-15641-1-git-send-email-broonie@kernel.org>
 <5262EB47.7000302@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4176649704362663946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FE64262625
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 22:30:18 +0200 (CEST)
In-Reply-To: <5262EB47.7000302@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linaro-kernel@lists.linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4176649704362663946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OL77D1xY4Kgu2EHc"
Content-Disposition: inline


--OL77D1xY4Kgu2EHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 19, 2013 at 10:27:51PM +0200, Lars-Peter Clausen wrote:

> Since the driver is already using the generic struct adding this to
> the other patch makes more sense to me:

You're quite right, to be honest I didn't even look at what the data was
- I was just doing a mechanical conversion to let me get on with the
Samsung driver.

--OL77D1xY4Kgu2EHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYuvUAAoJELSic+t+oim9dYkQAJPucD540atw0WtHMmWXZzeb
QOO08WYrm99lCV5RQ94u79csAoC7okAX1IxkVusA/+VDMYjU8lRTLS20eVQt393H
vvh40K7k0KYAnYVKyhHo+mM4lriv+O7nkiFpmm9d/t0Fc+u4gJn7mTLzSg4fGmzs
WtsQJeiG/aNrUBRlHHCJUpe8WCTo174yLYW7epjm5W+2P6ESOKKeA++8i3i33zZk
eUyvPVkXKWkc5jNSF0A/df1sx2X0OlfYUnwXTOTELq3fhR2pctZBiVmNI5Bet88e
NDMb+iiNLKB5ILr0m5Hfiezk24AIODLAbP/o18jkBUp3nE3w5hCeVsJe22ORtWct
wqZWaOuFz/ebyyn5MGKc25uEADddB1YQgzsU/jZq1Drw4HTKnoAKTZGjuyL4nwn4
KkGbI3noK5z3IYWU1rVya355GLBWJnpqOE8Ra44+I+cQNwPuqrFZ3Ww1VOJyxsVL
rHdSKg49Ej1y6clkpwfy2JcNs9vBKyPP5hyz2RsbaKxgwYQmm+ZGYQOCajfEYVLO
HUxsYGmgKMc/xEPB0qx3OTPcqs69CXxI19AlZDjS+vhQZW9wd98T2/FNnU+rWOny
sQ9LRtILQI7ZTWfvBowbarzYH9YawxKepZ6Il5BQ3C4nWls/uT6t1vE9AJl8/bmb
UdtIshmuK4+5U4REyoVA
=stCV
-----END PGP SIGNATURE-----

--OL77D1xY4Kgu2EHc--

--===============4176649704362663946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4176649704362663946==--
