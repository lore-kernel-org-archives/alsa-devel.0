From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: mxs: use devm_clk_get for
	mxs_saif_probe
Date: Thu, 10 May 2012 10:30:33 +0100
Message-ID: <20120510093032.GI3908@opensource.wolfsonmicro.com>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
	<1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
	<20120510091332.GF3908@opensource.wolfsonmicro.com>
	<CAAQ0ZWRtwwpToK9J5EbJvRrKnzGn6SrkDgNumat1b3vAS4ytUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5192132816742060887=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8368010BA3C
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 11:30:35 +0200 (CEST)
In-Reply-To: <CAAQ0ZWRtwwpToK9J5EbJvRrKnzGn6SrkDgNumat1b3vAS4ytUw@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5192132816742060887==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YhFoJY/gx7awiIuK"
Content-Disposition: inline


--YhFoJY/gx7awiIuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2012 at 05:17:27PM +0800, Shawn Guo wrote:
> On 10 May 2012 17:13, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Please stop submitting devm_clk_get() changes until it's in mainline, as
> > I've said with all the similar changs this can't be applied until that
> > API can be merged up into ASoC.

> Russell's clkdev branch will show up in arm-soc as a dependency
> branch.  So if you are ok with the series go through arm-soc, we will
> be fine.

Well, if Russell's happy with that being merged into other trees I could
just pull it into ASoC?  Or we could just wait, or if this is really
separate to everything else why not just apply it on the clkdev branch
rather than worrying about some complicated arrangement?

This is just a trivial cleanup to use new APIs...

--YhFoJY/gx7awiIuK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPq4qvAAoJEBus8iNuMP3dKvoP/i/JzFh4gvCgMLHlryVOLEoC
oJvTSdXYEjIDmmM9QFn/6p2GJjLCqvGurEKt7sNzUUPh8EM9RK/BV0+MiGdB3H2F
fZePLw2bFG1TzMfXkvCd8afV3KtYPMbA2f0in8aOrOHPhwangMaxQn0Zv3O1YDdA
fCzLckibNqrJRsN0hJC6nEECNbhSxYXopZDZMCE6RwAqJnxZPZyNZ82KenUKOk7Y
T0bTyBnQcnIPuChih6FoB/gkXwOwfRjBfwgG0HfhnWRq07HiTQmvTC1uq5sa+pm9
7R5Y5zkiA5sdp9XISIp3uob60FWHCi5V4hDjTh39J/PVPdmc0tjqwqh/AqXgXDPN
qD8EeeA9J3Fd11mhCE8ek9d+UV3PEsnDbSC/9G5a3P4tVdWLjpinO0MsJL6uPQEK
ofVvZlh5lcAjig8ikdONNmWzRroU9IrDfC6GAgSeiJvdciR4f+1i9Gqjq9ZPVHE6
wG4Y6vIqWBZuwUvMaMEZUXoV1Ky6m31XLP4CTX6Wsv1tz2Z2Vq/KgRrwK1zWRRRn
VBFBkoJMkh23XYHgbIJMI4X0yFBi1mQRe2CLkRkzthJJXYQUaXpHA1XeIA83DGeO
K9BJjtGHRXB47+2Hnn30sDahMo5Gr/qDbTax5qUtLCgIB9Z+1iCTdpGNacYVn/qx
nijVkI9TdX/prGoah2hq
=ntvT
-----END PGP SIGNATURE-----

--YhFoJY/gx7awiIuK--

--===============5192132816742060887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5192132816742060887==--
