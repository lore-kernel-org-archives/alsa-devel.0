From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to handle parameter variation across different
 boards but same platform
Date: Wed, 4 Jul 2012 15:27:45 +0100
Message-ID: <20120704142745.GC4111@opensource.wolfsonmicro.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
	<20120704131749.GZ4111@opensource.wolfsonmicro.com>
	<1BAFE6F6C881BF42822005164F1491C33EA35456@DBDE01.ent.ti.com>
	<20120704140118.GA4111@opensource.wolfsonmicro.com>
	<1BAFE6F6C881BF42822005164F1491C33EA35B10@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0305327468797094557=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10CBC104404
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 16:27:47 +0200 (CEST)
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA35B10@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nori,
	Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "'sudhakar.raj@ti.com" <'sudhakar.raj@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0305327468797094557==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hqsgWuDCGoNNiKsj"
Content-Disposition: inline


--hqsgWuDCGoNNiKsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2012 at 02:17:48PM +0000, Hebbar, Gururaja wrote:
> On Wed, Jul 04, 2012 at 19:31:18, Mark Brown wrote:

> > If these are totally different boards they should have different machine
> > IDs set so machine_is_() should identify.  If that isn't there then you
> > need to do something custom to your products to identify the boards
> > further.

> They are different boards with same SoC (AM33xx). So they both are true f=
or
> machine_is_am33xx().

That's not how this stuff is supposed to work - machine is the board,
you should have cpu_is_() for identifying the SoC.

> We have a means to detect the type of board but in arch/arm/mach-omap2/=
=20
> board file. However, I believe it is not recommended to call boards api
> inside drivers.

Only for generic drivers, board specific drivers are obviously board
specific.  The point is that you shouldn't make something that could run
on many boards depend on an API specific to a particular board.

--hqsgWuDCGoNNiKsj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9FLXAAoJEBus8iNuMP3dJMgP/iERZI6WmqxO69prUWIyMGFT
rjZ+UxGWri1cA6eTj+slG/DuKhHK7ICd3BNzdbn0qMEUH+YEj14qrimghNl6wm79
N+7xhJa0UW6FKJOkJGGABWRz+CUge0Tr4O4H6bQJScdK4MEnF+zfnDgSfP8N4+k1
EbHLXXhKXk8rL2bQB3DbnfYZ3GyED2R4CF/htTKxGsijuhtjBacpRQoROyUFvGlK
8vvdXjb8ffnBvo7Zfoz29Wx7F6V8EbWEaIJqI5bDgQCN+ECQibAxKUcunR2YjJIw
v5eglp+maHJWaPx7GV5o68LSbgDbogBt/jWTMLTrwSEzs9NO0jMQyLEByRrqDqm4
n/tzFpJAFOY+bPM0tDSq3MWAqvHjhhuF9uYXYbr3I0MBi6KGxdHnosB8YzR/Juv+
5OXhjDtLIMZW2m4ZENhSeEjDk+jEUlKwDkFp/QoeMBQxgmWw0w5aiRhbm6xs0fna
4DcTjTMR7BTmbOGznQrjPe7VN25L/bxFX7yRSopUAzXV8z1TAQb9khattbHMZusj
dgSbFiYoguWSYaG2Wd4tSO1eXu0i1l2OBqsDjhz19H6jGRhsl36CJMtPYucQShgI
fnhQBZ3f9e2cr84geu8jliHo/YdAd6Lo7k3aTET0JiAEbb6lSFzpxtCxVGqQfK+t
BiW1nVuxy+9xIqm0pSeh
=1yG9
-----END PGP SIGNATURE-----

--hqsgWuDCGoNNiKsj--

--===============0305327468797094557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0305327468797094557==--
