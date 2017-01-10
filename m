From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4642: Replace mdelay function to
	msleep
Date: Tue, 10 Jan 2017 12:24:49 +0000
Message-ID: <20170110122449.xhfdph5u6dkxdutz@sirena.org.uk>
References: <HK2PR06MB123504946F7D9CBFA0445A74BE900@HK2PR06MB1235.apcprd06.prod.outlook.com>
 <HK2PR06MB1092F11AFF71BCF6CFE41CE6C5900@HK2PR06MB1092.apcprd06.prod.outlook.com>
 <HK2PR06MB1235B6435DA88D1DEEFF37FBBE900@HK2PR06MB1235.apcprd06.prod.outlook.com>
 <874m1zay9v.wl%kuninori.morimoto.gx@renesas.com>
 <HK2PR06MB1092376B43150072E37148DBC5900@HK2PR06MB1092.apcprd06.prod.outlook.com>
 <HK2PR06MB10928AA734902EC15D19EE50C5900@HK2PR06MB1092.apcprd06.prod.outlook.com>
 <87k2auxk40.wl%kuninori.morimoto.gx@renesas.com>
 <HK2PR06MB109231252C5BD2F3CD6A7E93C5930@HK2PR06MB1092.apcprd06.prod.outlook.com>
 <HK2PR06MB1235B7DA8F97119F90296F4ABE930@HK2PR06MB1235.apcprd06.prod.outlook.com>
 <87ziizpsxr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1606920229042860543=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 073252673E4
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 13:24:56 +0100 (CET)
In-Reply-To: <87ziizpsxr.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, Hisao Munakata <hisao.munakata.vt@renesas.com>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Simon <horms@verge.net.au>, YOSHIYUKI ITO <yoshiyuki.ito.ub@renesas.com>, Tsuyoshi Tsumuraya <tsuyoshi.tsumuraya.zy@renesas.com>, HARUNOBU KUROKAWA <harunobu.kurokawa.dn@renesas.com>, RYO KODAMA <ryo.kodama.vz@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1606920229042860543==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ljc2bbfswgvye74"
Content-Disposition: inline


--7ljc2bbfswgvye74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 10, 2017 at 02:13:04AM +0000, Kuninori Morimoto wrote:

>  	case SND_SOC_DAPM_POST_PMU:	/* after widget power up */
>  		/* Power save mode OFF */
> -		mdelay(popup_wait);
> +		msleep(popup_wait);
>  		snd_soc_update_bits(codec, SG_SL2, LOPS, 0);
>  		break;

This doesn't apply against current code, the driver appears to have a
fixed delay here not a variable one?

--7ljc2bbfswgvye74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh00pAACgkQJNaLcl1U
h9Ad+gf8Ct3tsCU6OHNJPr/U5I7bdDqrBdRITdixpEhrwmdjbloMUO6GxSZfOCtl
svCpi0P/MLD7al8KWMB6tlsQhoMHm3suJv/VBU2vij+nhzyjoNR4wYBqZ4hzyaAm
5UuwZ9rRTOrTvS7PhpUdYYoqJPaVqfbT1AWLAoySK+Zigg9W23ODAQgEnnVnboj+
wBuZTji5sJ8+cONBNToRcJ5GhL7QqoqlcmkYmsDbg75S65uBraGKs6FJDP1bKJgm
mNHmQ+PxL3ffwGQ48/x8qv/Ycn+txvQjfMUiBIwYLc85Oqz9ms2kd06xqvaYelld
pCVKtHC55NFSgq7F0nDA7/d62cVJKA==
=m+6o
-----END PGP SIGNATURE-----

--7ljc2bbfswgvye74--

--===============1606920229042860543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1606920229042860543==--
