From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: enable ssi clock in probe
	function
Date: Thu, 29 Mar 2012 12:29:49 +0100
Message-ID: <20120329112949.GM3668@opensource.wolfsonmicro.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3431910330160071492=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42763104405
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 13:29:52 +0200 (CEST)
In-Reply-To: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3431910330160071492==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rpGc+ACYPE+RMC+Z"
Content-Disposition: inline


--rpGc+ACYPE+RMC+Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2012 at 10:53:41AM +0800, Shawn Guo wrote:
> For power saving, most IMX platform initilization code turns off
> modules' clock, and expects driver turn on clock as needed.

Applied, thanks (though checking return codes would be nice). =20

Ideally you'd be able to enable the clocks only when needed at runtime
though the power savings would doubtless be very small, pm_runtime
callbacks might be helpful.  Having the clocks present on PowerPC (even
if just dummy) so we don't have the conditional code would also be nice.

--rpGc+ACYPE+RMC+Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdEebAAoJEBus8iNuMP3dvw4P/3wJGOxmHdchMuIx/zqGHWTy
TNeDjGwGDFccNM1nxUaPvPMsQYHrgneqroCoI891D1Hd0HekE0NlFI1N0UC5rHAy
rsUiCMUhkWajjrqClX6tz+kimE06qQVKyjSVJNkmMIBail3yZBF1lh+jAGAS+fFp
NqRFyJyZ0T4NWuBqhaonffolx3xgwAVPtXW08GZzpA+qie/x+NHTvIq9l/xWVpDe
CJVpNoL/Rmj/LC1XyXJGTJK6duq86B/Zao0KYAI9LMS604neaf3vjAHMht/mgX2D
Liv001y4lcUNt1X6YD3EpAf3lvyaNzObGZknhuPEZFCahdcr3PviIC8wOgIxjzeL
/cq6AURkNhFxSzQ/Et/cH9KtaY1rIVfTtufi3phR7e3tXI3n9tL5YkJ0L2n6DL5w
pw3AjGWniD5E/lzvWaV5GMn4EMIC4G6sX+Uga6YlDhPQg50sCpbYKMbl5xUAEa5E
ezQ5cjZ6cGJGoFARi8NAv1mtUAEsn4F8HxGykJ3u4rYbLy9MRbjpSbz1HVeaiovS
hIweDydOOM2YJw26j6h/1rYac1QMWgUM08qMqq3UfKVp93U/JM3PNDODO7iWTF3g
fkb6yFL7PgcleZYN+daaYPmqeMQ9kR8wouFZN20pfBmLH37mFP0s0k0bI1t16MHF
cTQEpeeLsaGOb/RMjULv
=uOi7
-----END PGP SIGNATURE-----

--rpGc+ACYPE+RMC+Z--

--===============3431910330160071492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3431910330160071492==--
