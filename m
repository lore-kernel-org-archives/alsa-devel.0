From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-sgtl5000: Use
	devm_clk_get()
Date: Wed, 13 Mar 2013 10:39:08 +0000
Message-ID: <20130313103908.GF25610@opensource.wolfsonmicro.com>
References: <1363132289-15211-1-git-send-email-festevam@gmail.com>
 <1363132289-15211-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6758980449716200327=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65C9F265E04
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 11:39:10 +0100 (CET)
In-Reply-To: <1363132289-15211-2-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6758980449716200327==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2013 at 08:51:29PM -0300, Fabio Estevam wrote:

> -	data->codec_clk = clk_get(&codec_dev->dev, NULL);
> +	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
>  	if (IS_ERR(data->codec_clk)) {

This doesn't look right, we're using the CODEC device here but this is
the card driver.  That means that if we unload and reload the card the
clock will get acquired twice.  Should be mostly harmless but still it's
not good practice and would eventually run us out of memory.

Really the CODEC should be doing this but then we get into the fact that
the clock API isn't reliably available and so on...

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQFdGAAoJELSic+t+oim9H88P/R+fxHHsj+wZjNsgnaDRqkPu
lOCzSOQH0EiL8W+FK76uSyu/KwNp1iMSkpwf33QpQHIXTNaC/B6R2spfqiJP/xkF
EnKn9csYjUlCTXo4lR3qq8IR/5zgn+c3z8m/0q+/kbWaV8sXZZJJeDsnY+otA8Kd
IDyfuVEUpp0JMFVbDysYVkGWslqeCW8R3AVxiQ+0R3Ov39CjmrKM8SC8v4HgkBtK
ha089LBmcqKGV1+bEox5hZ9tt5Muc/GqqvQ3BbgNKcsr+eGU2jLJxs2o5+HrrEbj
qoHqsYp1Z33U4h1595reEv9+x3RzEXwSPseVS5EOSXcGdc44L+TUKUl0GTAghc3y
jPvXYvuPEhm+zl4ykRsESbgkUjDwKVeTKMvCTD7NUq6Ih8Wou6FfcH9yGPPeMBow
ZL89lwPMaYAEOxh0k/VvMTpUD3fmNLJ8YGR1Ae/Ee5/kL2YvDnnwjRQ/xTV06IDW
0JTxRGHlG62ahCGEFppfPUF1VjV2v+Hzr1/vu98wupuns4gsv9EkDaKb0w/NlXpo
Ux1m1MFK8NcMHkSANxxLXDAqsKP29464QHNl48cJK/fiQwcPQxJgf9SV5V+CMQZy
3b4rXPV9Zi5U8N0gXtQtrS/vi24JJenupY2TannRQ9y5PmYIpmGjf+pjhfLd5dVn
9Pox7z5a/ox52Axs5gk8
=1iSF
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--

--===============6758980449716200327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6758980449716200327==--
