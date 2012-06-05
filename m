From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use
	devm_clk_get
Date: Tue, 5 Jun 2012 11:20:40 +0100
Message-ID: <20120605102040.GL23408@opensource.wolfsonmicro.com>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
	<20120605064714.GL30400@pengutronix.de>
	<20120605100316.GG23408@opensource.wolfsonmicro.com>
	<20120605100851.GI8262@n2100.arm.linux.org.uk>
	<20120605101413.GJ23408@opensource.wolfsonmicro.com>
	<20120605101558.GJ8262@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6852685116982958675=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E7F691042C7
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 12:20:42 +0200 (CEST)
In-Reply-To: <20120605101558.GJ8262@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, Sascha Hauer <s.hauer@pengutronix.de>, Richard Zhao <richard.zhao@freescale.com>, kernel@pengutronix.de, dong.aisheng@linaro.org, timur@freescale.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6852685116982958675==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 05, 2012 at 11:15:59AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 05, 2012 at 11:14:13AM +0100, Mark Brown wrote:

> > That'd work too, of course (providing everyone has been implementing
> > clk_put()).  Though getting everyone on the same page with the clock API
> > seems much more worthwhile if we can do it.

> Why wouldn't clk_put() be implemented?  Drivers call it just like clk_get().

Lazy people who can't be bothered, especially on platforms that do
things like just return a pointer to a statically allocated clock or
never really expect their drivers to be unloaded.  Hopefully everyone
filled in the blank but I've just got a general pessimism about relying
on things like that.

> The devm*() stuff should just be a layer on top of clk_get()/clk_put() and
> nothing more.

It is, yes.

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzd1yAAoJEBus8iNuMP3dfT8P/iCKUT0vNzuTlvx/gupD4sL0
KyKdADVX1EW3eI9tMo7BhGZsVynHiCGgxuLk9Ity/la55OU7IAV3X4wzJ7aqwhq1
t57B64+m5DCHGBTOqt3il/OviboT1j+FbfKVGuBd+OgHq2rZqeVIRmMHJ/KiyZPj
h30HuhJsb2pjvj2pDuuGQz/LnbuELhbZt4E9NfSYg1zzltNl+NSEE1NlWhyp+Kd0
NUSKelsB2UckR70+f3xEanfmPXBWyKrbE76fScvUvHTP+S9VDMTMInS/zxRTyGxM
KhFY4pjiy8QwqWnHa+IjDqdzc7pCPAOsmMzU4jVsnZFkyuwz8+u7jPLpKhOmpAs3
w4qlYpP7RNW/4JGpSoxWZTEW4EgUsvveYwlwv+w6aNl/U5brInrXQCK3R4d94/hh
vxlACRSjNvVklQ5b1e+g08vNRiwAuhipZY1O95zmQ66ybVOeJ8FnHTlw5XZUKByo
s2Hwwd65r6z01QgWyLegzZ7gfo8ZO0fAN/0Uq0Q3h/SKtmabjgLw4cqU85a191P4
awMsOJay68GRjFRs/a4bdAheldc5A73RscKPk7mEcWxAUTVQbY3dHbnltYTaCu+p
ttyDuTomQkdqZMDXsfkLCg8Xev84BPsgWQZvLt5VolPVKjUn1q+DC6seXHe0U3Cl
CiubAQdKLCVQQhrHf9W8
=zAWQ
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--

--===============6852685116982958675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6852685116982958675==--
