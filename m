From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 26/27] sound/soc/txx9: don't check resource
 with devm_ioremap_resource
Date: Wed, 24 Jul 2013 15:37:48 +0100
Message-ID: <20130724143748.GI9858@sirena.org.uk>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
 <1374602524-3398-27-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4514712179953589350=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B4A2F265369
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 16:37:52 +0200 (CEST)
In-Reply-To: <1374602524-3398-27-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4514712179953589350==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UHwWMNIfNKl+QsP"
Content-Disposition: inline


--1UHwWMNIfNKl+QsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 08:01:59PM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

Applied, thanks.

--1UHwWMNIfNKl+QsP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7+a5AAoJELSic+t+oim9EBoP/RO/Xe3zdOCuTi6k6fy0wev9
MvJdJ18KXnYF5kPVPqno2+sZY1JGa0tTpaV/FCd5SFOwiuz2JuYofaZR7NOPmHTS
a4s7vW02GgB10V7RNqhZWP4rfbUzMl3V+AiBvR90m75mcBU5WAGNh87dnJymPdLZ
Tux60MkFuanMG9EJClfXz1vewblLg4NHDwbP6BGk/HD50wPAzpMY2YUvqZZHLSnm
B1Ee0H699EYUNUb3L4weYDJvuvvEt2izJqwNzUcdM18rxut3ZVGmSazRai1r3lyc
7XcYk33jPmetgx2yewB+q+6mHctCgRi7MVv7i8Imo6z66i5qAwGavzfJvXrmxbcL
ATkFv4juyjnBqYsrS8AXls+NG7vrh5nBi1mNoDK/qkLjHDHnhRCyYHIJThSIH0jn
oDh3bS1+bbDlO0ptMiyVZa989iWMj4IfQiBZ/xAm8NgUA+u5XCH6hOlYFyvZmll3
u+zEMzrXLG2nE4dFkswC5WsQ2jNjxGGng/sVfJhqIQoiFSNbvD2noHBN3LMHqfNX
J7EZ/DjWNW84T3OQFkdRlwnqCunhresQIrdNO8In5l65f25wAPvUF16PpQ0wicI6
EDULeVNV7e0ThSzOn7ptUeO04hrQUZQ34YOLXY5qRzliRr4hdQ0XpwSDXPM037rC
0eMdBOGbrJsuKc7mhptu
=18Ln
-----END PGP SIGNATURE-----

--1UHwWMNIfNKl+QsP--

--===============4514712179953589350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4514712179953589350==--
