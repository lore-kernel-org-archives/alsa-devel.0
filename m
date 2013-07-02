From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add ak4554 driver
Date: Tue, 2 Jul 2013 01:31:10 +0100
Message-ID: <20130702003110.GS27646@sirena.org.uk>
References: <87bo6mixuj.wl%kuninori.morimoto.gx@renesas.com>
 <51D1A10D.5000303@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1530925959201521624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D013265268
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 02:31:15 +0200 (CEST)
In-Reply-To: <51D1A10D.5000303@metafoo.de>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1530925959201521624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BPsvfkagM77L7Mqx"
Content-Disposition: inline


--BPsvfkagM77L7Mqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2013 at 05:32:29PM +0200, Lars-Peter Clausen wrote:
> On 07/01/2013 08:43 AM, Kuninori Morimoto wrote:

> > +	priv->usrcnt++;
> > +	priv->rate = params_rate(params);

> Set the symmetric_rates field of the dai driver to 1 to enforce symmetric
> rates. No need to implement this by hand.

That won't work because there are separate playback and capture DAIs at
the minute.  But I think that can be avoided, will comment when I review
tomorrow.

--BPsvfkagM77L7Mqx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0h9KAAoJELSic+t+oim9SLoP/jhxR+ZAhOqYO/s+6aHwDfnQ
s/H+6vd0zNOrGNpuR95wiQ01t8aYvYU5tzYhGGidtsY+ghr+XIgps3Sp/KpfS9MO
JeGVotwInlaD9QmHayiJqfdQzw3mrKdrynSUBkvOYv7sQ6+zVlg7uJKX4rhXZD+2
G0SWBSsXkzMhNOPeIGxi3XmHHshBrCpVw2FX4vXAiSVDyS2Fv1by/o/JY1S42QOS
ni9wAeWhDN7X6caxrnAjy+cSE2ah7pn/KmgYma0GlLnO0kDTkCGgGi4FxBnlzGan
2+WwhtM6eiy0OrzoyDjrgt9bKgM06LLJqRrJypGI14Spb43KqeNBrsZvk2pJ+JLH
iH8OUIaASJSawBFf/9Ou0wcnc1pJtKki2/tONcBK3MI4mpOH4nKQWpBvYWHfqPTV
4xNoWY1IIJknola7uBH80hdNi5WX4zZWDrhvEH3ex45/0YZCThYixYj94x/4njA1
McgUfnGqL0KJ9HcyjCBzHO/UWigRdTxJh24TLOct7FneP6aRj0sIJ0CMca/f+Sjd
wN9W+s8nSsuBwQHa1bZ3XlwbNlxqce/Eui3lNEj1QGb/yAMy7w6RV+bDN8w2wfdB
nK5YanCltHxD7/zkZVUjevzZLjRvb5QN/pZyPYCo1eve4FD6KVTscnHK0qMduKiO
mh1usrbdj1psiX2M94eE
=eK8J
-----END PGP SIGNATURE-----

--BPsvfkagM77L7Mqx--

--===============1530925959201521624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1530925959201521624==--
