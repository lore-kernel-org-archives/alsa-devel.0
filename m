From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
 machine kcontrols.
Date: Mon, 6 Feb 2012 15:17:38 +0000
Message-ID: <20120206151737.GK3070@opensource.wolfsonmicro.com>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
	<20120203204640.GD23505@opensource.wolfsonmicro.com>
	<1328524623.6799.9.camel@odin>
	<20120206110939.GC3070@opensource.wolfsonmicro.com>
	<1328531118.6799.13.camel@odin>
	<20120206132746.GH3070@opensource.wolfsonmicro.com>
	<1328537786.6799.16.camel@odin>
	<20120206142559.GJ3070@opensource.wolfsonmicro.com>
	<1328541116.26182.99.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3782985814107835072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F1F14103B57
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 16:17:39 +0100 (CET)
In-Reply-To: <1328541116.26182.99.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3782985814107835072==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvuyDaC2GNSBQusT"
Content-Disposition: inline


--GvuyDaC2GNSBQusT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 08:41:56PM +0530, Vinod Koul wrote:

> Hopefully I got the context right :)
> So a machine driver should not add codec_controls but do a
> card_controls, right?

Yes, or rather if the machine driver is peering into the CODEC internals
at all something went wrong.

--GvuyDaC2GNSBQusT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL+2OAAoJEBus8iNuMP3d/T8P/1nJomHhqkJAEHieOVpyo3p2
r+IAKJxYdL+QMvazxsYTW3N0DuPH53SenFuvxCuJSwztq8ysfNU1f2XcXjcnUZDt
HcIo3MuZnG6LkL1pLfztVCsXcTWJohry9D2eKo00M779BrFRlWJe83ZTwEFw71pc
3aDSsJRIyVfF/3s67FNAuUJ/iZVF7dbjBDUQw/Dj+Fu2DHoEcsLHRqN5M6KOShau
F9wKz3p218U6kYT0IqKted1Tje80Gr/qaIjoGVSNXkacVylB5oELyER0gO4f6FK5
+ZCJBXc0dIjm5clS88n3akhx9KgU8j7pUR8NNVWVCXEnODmOzKcusA3sDCKN+tj8
tkF6FD6tjDrUXwEwqr3ZIBsudHtQxOhssy+4/YNUbNyL8mxRUejOXz/Mw0Yinq6Q
NaBLFGhBEAAGlSufBXqDKropP/zUQtwt+lSESkErx32Bd5y7wZBzyJtFh7rTCk8X
0fmKC36VzhA/20Hi6NyeBbp3Bi9cHBjZ1gXSlzvrtGwhGexRlR3CNw0J1jdxCgHJ
a89m5OKBOsm1CjqyRCFH/TJs8xUBZKehR2ziTyh3VardOfyQnFiIGTYUOHqS2PTk
xyVhJC4nbWXx2wvyhpUf6Bq82x1jsi3etkHIBjrV+PDRUmVel+ql5lVf2jSqF7GZ
4w4a9/CYZkdcuRqH+QQU
=Rprj
-----END PGP SIGNATURE-----

--GvuyDaC2GNSBQusT--

--===============3782985814107835072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3782985814107835072==--
