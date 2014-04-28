From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] SoC: rt5640: Add the rt5639 support to the
	OF match table
Date: Mon, 28 Apr 2014 09:48:00 +0100
Message-ID: <20140428084800.GA15125@sirena.org.uk>
References: <1398666486-28118-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0119791792652621529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B8AEC260816
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 10:48:24 +0200 (CEST)
In-Reply-To: <1398666486-28118-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0119791792652621529==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 02:28:06PM +0800, Oder Chiou wrote:

>  #if defined(CONFIG_OF)
>  static const struct of_device_id rt5640_of_match[] = {
>  	{ .compatible = "realtek,rt5640", },
> +	{ .compatible = "realtek,rt5639", },
>  	{},

Please keep the table sorted.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTXhW3AAoJELSic+t+oim9NRUQAJb6qOchqYltuYAaGtCqGxXw
F0M+hFnBUtgnYi3Y4TvLu4jXHIL1+ua/mpFkgM6p/+cS85obQZPtGIyBA4sSbHTy
KEokiNMNpBkDEoYyZYUJNCpUnrlhI7DTP2jUzHfGIhdS1UNGRm58+Fz26HddZxrL
gqMo1Vk62DWHZBAgq7l6QIPE4IuvEI5j/AyjSCznTMrjxGz4YluNK3CCxkrIi3tE
QhG0jX+fJ2zPaeBEXxbqtpmEvszAgnw7ZfDyBZBJkCur37G43k3q4/m3k2XTbhHl
yOxCc0pnOYHYSYc6+raRG4YcpUrrMpZ5YSI/GYiTyf8Bz7pdqsmUqWgVlF71MWxS
gurfW+5kudWc2/3Vci4FG4ppta43QrdrsWO9J5TX+1fEfwrRM9L3qggKXnRIEdIE
m5oPru4KFq+MeYYqDPZsTR2c2E7E4m9q+8bPq0Yx1nNCYjH7E2aZrBuVlTbDUmV+
jjO0YLrgqe2DXfvbi+lgsR2nzxA/DC0G0MknCN29JYcIvdU0iiJHor9t3FjuciUz
tA13QL8R6wdzl4fyhQS3YVf2vLiBjiZ2qiaXeh1pQ6u/nBEm09PkecVzE55mqjkf
nojgrMGtWvXPbrq6mYTfbMgMSM0S2XALwksOwlnRU8FHeFMyifDOPX5e7qV9u8uE
caBlfCsY81ixrGtA6QCi
=tlQM
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

--===============0119791792652621529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0119791792652621529==--
