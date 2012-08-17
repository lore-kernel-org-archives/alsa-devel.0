From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC/ARM: Davinci: McASP: split asp
 header into platform and audio specific
Date: Fri, 17 Aug 2012 23:33:58 +0100
Message-ID: <20120817223358.GI18871@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-2-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6036691496517588447=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1CA5E26618E
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2012 00:04:14 +0200 (CEST)
In-Reply-To: <1344948125-5649-2-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, peter.ujfalusi@ti.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6036691496517588447==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2012 at 06:12:01PM +0530, Hebbar, Gururaja wrote:
> Davinci McASP header & driver are shared by few OMAP platforms (like
> TI81xx, AM335x). Splitting asp header into Davinci platform specific
> header and Audio specific header helps to share them across platforms.

This doesn't apply against v3.6-rc2, I suspect there's overlapping
changes in arch/arm.  I was just going to apply it on a separate branch
to allow cross-tree merge if there's overlap with architecture work.
Can you please check and resend?

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLsbLAAoJEFJkBDiqVpZ4BTAQAL8lrbACn/xsjQy3xN7ZL/ob
DnLxrglHr7ibX/x/9v2CCp0KkKR3m2d1SB8reYKUy0wOj+h8XlgK0buMmmxDAu/s
8WEL94umfsmL2xxeRLXNGoxFi7kGFtGug7/67qEkKzmnxV/E5G3hQ3Fy9UQ328zw
I/h/qPcWRiUmpzWhANDx6QSrYx9JXm6DJTXgsJfjPDIzbuO0/ZM0+GU0I6cv7nK/
V53ITwNitckSlcWzYf4IrhDXacx1tBye2dCMhc4qGJiwavaGE7B279nvA8gcJKE4
fu8TcFSZudr1s6oA7oZCY6GA9rXrww0d70+YS9R8n7z7+cRHz3OutgQabZqToFYz
iXaEDEQE2Tbe4qSKQR8DuEpZHov5EiVvoanWDd4Ri6UYMh1g9N7jD9JoP3nWlH+/
yrQJgSzlVMS78B9grj90AxUHiSlinPkcHFQy6HcZsXq1n8koOvV01BGvIphATggG
Iq0w13ydClmiOpwcCijBUIe/dDvCxXt7qtpi9hgDlBRcYvcCKUROgIT2ZRe9SjXX
yd3isW2ZFSQXvyYAlxc7qQXdo2IWDADYarL9FbpU6Z8mQfwMI25P9SHHuaMhh/S6
bQ6aEtHMxsebKMJplC0klSiVtQ9wYb8yEOarbEMGoaoAo7jxo7w7LMjcNq4I+eel
E8vPmcJqx6QlB3ywDmwi
=/b5S
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--

--===============6036691496517588447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6036691496517588447==--
