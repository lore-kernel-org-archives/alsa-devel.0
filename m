From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
	after reset
Date: Fri, 10 May 2013 21:56:16 +0100
Message-ID: <20130510205616.GU3200@sirena.org.uk>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
 <518C4A8E.6020501@boundarydevices.com>
 <CAOMZO5AoWqhSdH5WVu=TFgejis=8mWNGYyHneRc5idwCd8RZWA@mail.gmail.com>
 <518D4660.9070202@boundarydevices.com>
 <518D4781.30507@boundarydevices.com>
 <CAOMZO5Dj83WqD2tQBQDBz9FzvLQGyuv-4yvb4gwL=rRq6DxPuw@mail.gmail.com>
 <CAOMZO5BQv-AwzXfYC0y+OvKNMHtkFOosPUGAWNBQizd9A+zk8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6116794913407188148=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FA372616A6
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 22:56:34 +0200 (CEST)
In-Reply-To: <CAOMZO5BQv-AwzXfYC0y+OvKNMHtkFOosPUGAWNBQizd9A+zk8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org


--===============6116794913407188148==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KxKI/R+N9hudrWbn"
Content-Disposition: inline


--KxKI/R+N9hudrWbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2013 at 04:39:32PM -0300, Fabio Estevam wrote:
> On Fri, May 10, 2013 at 4:18 PM, Fabio Estevam <festevam@gmail.com> wrote:

> > Sure. That's why I placed the ID reading after turning on the regulators :-)

> Ops, actually I did not. Will fix it.

I'll wait for a new version.

--KxKI/R+N9hudrWbn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjV7tAAoJELSic+t+oim9CRQQAI07D2hu0Sk7igtfhnpxOP4G
nOcUcOjurgTxKXw9bb+9Ky7rG7Nvc1vL/G4dwh8h8FMrlH8zlazx0eCc2n51nb9z
0oC4O0QqInY/MLvRBwJ8txnrWQDikmSplxQkyHZrS+40KjeaAGBy5io6Ai2T8pcA
H8G5/PD7s6aG16Uwmci8AUdExz7YVOhstc8mjD67e4Nk0dwf15ekP8CGWJ+cOFpH
5o1Db1OZX378XdyKNpshPmoFTuUjlR4njvVUNr1g0HErZrIg8R0VEZKgN/m8NoCC
vQpHdn5nsoJXvM8trCDCBrgaDzOZpvTbpAUDMYscAmRBI6fef+NqOeuen92whLIv
jlOQJmGXWdG1f0Od9W4QIE1eTC/wPPtJQf2+q/A+DwJ3OjWvOv4B+J6ZBXMrpVWq
+Bnj7N9k1MHwBPE1Ibhv+7NiUxEbeUUM21fOZz1+rXdpt6k/GAYodfH2GPjDZNwI
6YG8mHBq+3vd0P0KuBUmGTgTgxr/CM6WoYKWi8cj4AUGYudKZAnN9gvOSXe3BceG
hn7eegS3aHVA8VEbTtdqVoek7TtpcdmP4fU87t7bbiWOJdmXSXeY2HihCJi+IarG
y9my54x1L+zEcFoN9NyVRkdqLs3Ql9eDwTSrmXOmzdZIXu1JfgOc1qm7rWXC103o
wdgSPRNPamZiBV32JnXv
=yfmY
-----END PGP SIGNATURE-----

--KxKI/R+N9hudrWbn--

--===============6116794913407188148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6116794913407188148==--
