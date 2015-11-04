From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: rsnd: call
 clk_prepare()/clk_enable() for AUDIO_CLKx
Date: Wed, 4 Nov 2015 14:49:30 +0000
Message-ID: <20151104144930.GL1717@sirena.org.uk>
References: <87io5iw47y.wl%kuninori.morimoto.gx@renesas.com>
 <87h9l2w46o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0947624362096765331=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98D652657CA
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:49:41 +0100 (CET)
In-Reply-To: <87h9l2w46o.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0947624362096765331==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FxavXfDenm+F7xE/"
Content-Disposition: inline


--FxavXfDenm+F7xE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2015 at 08:42:53AM +0000, Kuninori Morimoto wrote:

> ADG can output AUDIO_CLKOUTx, and these are generated from
> AUDIO_CLKx. Thus we need to call clk_prepare()/clk_enable()
> for AUDIO_CLKx.

Don't we need some disables somewhere?

> -	for_each_rsnd_clk(clk, adg, i)
> +	for_each_rsnd_clk(clk, adg, i) {
> +		clk_prepare(clk);
> +		clk_enable(clk);

Do clk_prepare_enable() and check the error code.

--FxavXfDenm+F7xE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOhr6AAoJECTWi3JdVIfQGsYH/1VaYSz6jz7bpIakXAxAPZo8
GNk9sGFqdjrgVZGw3/ZXnaVBtksler+YuenW4R5xNdB1Ii1gNCQAbKwOBYOZpsfG
wCnuGK3C9pxOhAg+UMziVbXLU9pkKMHK0BKVDHBxG+8AhrC3waYiH4vh7xip++Zs
nwuuS/opHfpe803s1fMGOeFWsQD+ABlE8LyuWXXvNuhMe+8GLTQPCyxCCEs6KDN+
jQlqaWEMGddmAquzSks+0Hjo4+2R/wM+ZhCc/rWJMC2y00Q/7CU/gyJVDwGBVspm
u7Lcq/hxJaIOX9Ja4aFhtW5EpkDHIKzxTl6x31pYu3DpyWqLlDdmcgDc7/gZzMY=
=NgAg
-----END PGP SIGNATURE-----

--FxavXfDenm+F7xE/--

--===============0947624362096765331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0947624362096765331==--
