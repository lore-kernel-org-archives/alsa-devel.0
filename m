From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 7/9] sound:asoc: Add support for SPEAr
 ASoC machine driver.
Date: Wed, 27 Jun 2012 12:12:38 +0100
Message-ID: <20120627111238.GD308@opensource.wolfsonmicro.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<6eb72cea276e7dc191713cff9e4a0ce8ed6b2faf.1340273261.git.rajeev-dlh.kumar@st.com>
	<20120623110113.GU4037@opensource.wolfsonmicro.com>
	<4FE83D3E.1070900@st.com> <4FEA8DF0.70107@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0638493453661255807=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 309CF103EE1
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 13:12:40 +0200 (CEST)
In-Reply-To: <4FEA8DF0.70107@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============0638493453661255807==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 10:07:04AM +0530, Rajeev kumar wrote:
> Hello Mark,
>=20
> On 6/25/2012 3:58 PM, Rajeev kumar wrote:
> >>I'd expect to see an of_match_table in the device too given that you're
> >>parsing OF compatible data.  Given how simple this is I wonder if you
> >>can instead add DT support to the simple-card driver which Morimoto-san
> >>recently contributed rather than adding a new driver?

> This will completely eliminate m/c driver. Am I correct ?

Well, it'll mean that you don't need to write a custom one.

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6uqFAAoJEBus8iNuMP3ddGIQAIPiiUHoHeoikiz4SvQl4yKv
1GjRZJHCRvNFAB4hbDi9qvAyi+7LxERl+O0Xg5I2VWzie7Vbi7izWVKGRcgggtao
RdcRQEbMNfTQS5fx4BkAHVUmbGRYU5Ogb4IwLOAwR1C0+vNfHPVmMs94gwQ57Ct4
HV6Dm5yos8Fr7DXrPVub/AJe6Zp7P8tgNcyr6MXc9Fit/5vBKPd6ieGKqCM/Witn
eW70+X/jCg7pANKSZuQFfB76vkrcnRftw78QPK3GjFHHxRAMT9qldwxl9K43tkaR
01tBOBLXODx0BIc0rkOb0/Edh6RV4v2o6vNlRXGQAwrsV+lYkoNkHkWrIcq6Fs1B
CeN7kaq9FGXiWg9/2nRUxOLfaI67IA/Z3Q5RHMdCjLgFCEBwIFitF9j/VoUct8vR
Rb/G8CWNYZCdD9bwlrgQt9vHW2vNfvcrfXzoQbFpdWS1STK6EzfB37fWlXxp9KcZ
V7Fi/2FJ5roz2YMTDYJKc7xkg/6IKeoCtZBMxyLvv4r8UQjtfN7mr7aDLrz7+lJ7
IHhURtUXNdHFSQG8r7YUEinMou5Rzj81mPo4XuFNdk2f1dlC4rhyo0BK5mIPJwdp
/HwzhR5yqkHy6YVpGvwhalZ7y/VlGyLqDF45r6snIH3lfJzNuS3+Qnq77laJqRa7
91/NwomHPJykKhom+19H
=Rh2r
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--

--===============0638493453661255807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0638493453661255807==--
