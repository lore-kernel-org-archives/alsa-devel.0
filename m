From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-hdmi-codec: make the driver
 common for other SoCs
Date: Tue, 4 Jun 2013 18:44:10 +0100
Message-ID: <20130604174410.GR31367@sirena.org.uk>
References: <1368684487-8890-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6874998245736076631=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FC3726518A
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 19:44:15 +0200 (CEST)
In-Reply-To: <1368684487-8890-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, lgirdwood@gmail.com, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6874998245736076631==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zqu75NDXmDJGUu04"
Content-Disposition: inline


--Zqu75NDXmDJGUu04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2013 at 02:08:07PM +0800, Barry Song wrote:
> to support HDMI on CSR SiRFprimaII and atlasVI, we need one more HDMI pseudo
> codec, rather than add a new driver, we can make omap HDMI codec common for
> other SoCs as well. then the omap-hdmi codec becomes a generic HDMI pseudo-
> codec as HDMI audio features depend on HDMI specification not on SoCs.

Applied, thanks.

--Zqu75NDXmDJGUu04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRridnAAoJELSic+t+oim9bMAP/jjQfMYkIPlj3j06puWtWdgC
hdc+HgD1amTQ9AXm0wOrMIkI7HBsOo+bNh6uzMWV6qpNNZOuUeuwDSzZeuZ96TFY
Sxz5Otgkjy9WLZX3W1CR8SZQ1q2EApvKdxgFdDE7cEjxPHRGO+LlOO3hMYaht3mU
mVs3l9cuLn5rNnKlRTFvz+y5LkdqD9YRsslbsPmhyjrMG0/ItcfcFqlMGj/s3ezx
B0P1VZMluVgXijNsntqM/jeQl3ShwkF6I8sAY7NfdbkapO3PH+skAvrM5RCl4/bF
ZPkl5yvRYEbwR123Bjn7ukv4TSy/Xg81iab4nyn4w58WG5k/iS/Fh8B8/GlDLiVY
iFG8uUUkF1gC/EjblNWRVbbYYdVN7QEBE3FJdOXq9dYjkCOhiCbNJhR5ghAYfhG8
ezM36RQNLTkbOosuUdsTElMPbJC+SnQ4E768Y1Wa/wBWhuaNdOGYdkmaRysQh7va
cYx8NjoDRHLHnYCgxSwt72mOgob/JzSTAkNHwRT5b7MqruSfA+IZqsJ+3TLDCBUt
X9Sd7D5PLBoCUuOJ3ZOi6b0OAR/eIQxwOBNFMtHgsBjW0AFnd/v6wouJphTsd7Xc
by5ifEcBElR86nKqDdG2LdF0kZG1Wuh+CXkLeNFtKornaT8LPn3ZHJ7ea3FpwoWR
/nd6Utnlc3hluPOuypZu
=MGkV
-----END PGP SIGNATURE-----

--Zqu75NDXmDJGUu04--

--===============6874998245736076631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6874998245736076631==--
