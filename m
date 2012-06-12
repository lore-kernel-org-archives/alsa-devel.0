From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] mfd/ab8500: Move platform-data for
 ab8500-codec into mfd-driver
Date: Tue, 12 Jun 2012 11:48:02 +0800
Message-ID: <20120612034753.GA4139@opensource.wolfsonmicro.com>
References: <1339070446-15186-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4988380965049325191=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C2CA24392
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2012 05:48:26 +0200 (CEST)
In-Reply-To: <1339070446-15186-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4988380965049325191==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 07, 2012 at 02:00:46PM +0200, Ola Lilja wrote:
> The platform-data used by the Ux500 ASoC-driver is moved from the
> machine-driver context into the codec-driver context. This means
> adding the platform-data for 'ab8500-codec' into the main AB8500
> platform-data.

Applied, thanks - it's needed to fix the build so I'm just applying
before acks.

This should really have been sent to Samuel as well...

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1rupAAoJEBus8iNuMP3dbEwQAJ0LeJ+yNNIucE5MP36HG9Zo
Lqb0lXx57O9+tF90fc3H5JJqiwI8pKq6YTtZUnYi7R7rDVtTRTTamJ0++DcsbOwq
E1s21ykM+ZNCte9qowIBAUVD/Kozn2BtbCx03+EsJ/uoKOakNsOdqPFv8iv2WYNo
4SYIctMZVUTd6ndzBJFRo/EUI1eurL5MihlvU1z2fRc0pSoTiKgweREHY9lxDHOn
VVpAnVPhq5hndeZbssoArslC6iO3Hpvwl+X07qak5WK69UBD+5LZx0V3y9bpVmcu
5JI+rsUU7VUjcIcHlxwpUYB+NvIKT6tec+/CoHcY2Uh1zOEyu7Of0YVTY3L21h2M
Vdd5HNgPxqlh/HD2RVcbrCzLJ7toWpTETH9jvCe8AsEd2pS8fRnTjKirZvoX6EFr
wJzpgxLAFT+59yjGoZNTmvHJir0orhNnihhxQoWaY3eu7Y/zHYuprVky3bR3Rk27
RI3lwtoAVLAUlQZ2VxIVqphNjLKfQLj6oOEJbO0tBt0cwehmN+fNtKy6kw6aegLb
TEImchknfOtCZ82494R2uEKfYxzweL0Nbv5vMW+Zoa1IIVfjmODXJWmLogbBfZ96
swiHsxW7kyDXTUi1UQq8lPZdNmOv7vdXTtF6sW3q5Qobdxo/ybIyJvd9hW3ukSyY
GhAmoD3upKRx1Ry25k3a
=CrsX
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

--===============4988380965049325191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4988380965049325191==--
