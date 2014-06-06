From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sigmadsp: Split regmap and I2C
 support into separate modules
Date: Fri, 6 Jun 2014 14:10:37 +0100
Message-ID: <20140606131037.GP2520@sirena.org.uk>
References: <1402056557-31348-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2869863605463992525=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98867265172
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 15:11:13 +0200 (CEST)
In-Reply-To: <1402056557-31348-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--===============2869863605463992525==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IjzautVOrq+IorBk"
Content-Disposition: inline


--IjzautVOrq+IorBk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 06, 2014 at 02:09:17PM +0200, Lars-Peter Clausen wrote:
> When the SigmaDSP module is built-in, but the I2C core is build as a module
> we'll get a undefined reference:

Applied, thanks.

--IjzautVOrq+IorBk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkb3JAAoJELSic+t+oim9IUoP/jbBbmz4stFQGfBxkdNoYAra
wU+pVEgqN17rdVjSNBOHL09RlePu2spRELTRQwdxV3ZjVh3E2LTdaxA97BStGTlO
tLDfCHlGHLsjQ/QwrYaiYAXBpSHC9UC/L1FC5zXz3a97FoCASVv4P/BSsxX9Bktf
sc2Wkr/tgg2sG2DdOwCDRzsJDkZYzulunpU0WpjI//SNFzJ7IA3V6MJ9lxHFgE0d
eR3NzBH85cE5//mDelmNiOnBJ403T1brkTJUI9XfmnwILDlSW48gMGvy2/F7E5Uk
aiTtbX8g54ugdnQZkmHrCZs50SpcLRIGigchrTHT+cpLnnq9V/oU6mV/Zhk265dI
l8SBmmwPilApCAIonAE5WhkNwxmyJ2RrtF3TV/ZEZILC2iVJOiN7ZOYO9lb3Rnjs
uzpffe/rbmWLiy7TXOiVDaMy9aa3XD4r38+quUZThjGbfUoOe3Kf8SoZ5lBTyail
CHqAG9FGrgNNFkRpSSvYf5GQg0Hje2JxBot/2qCuGTcvhchteHXSIlMzV2TPbRTj
r1AeQiz7VmlVpMiskBheMAkb5XTtxsBh1hGkWpfCQjMVBuRnDQnreB74Vcg852hX
moNFzx/WzSjFpdU3JDfAlUDkUlYBInsj4tnkfvk/50juFidbZeVF2fgfthqSJ4E9
waFVcvLKo179UAK1RuJI
=Pmz2
-----END PGP SIGNATURE-----

--IjzautVOrq+IorBk--

--===============2869863605463992525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2869863605463992525==--
