From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: un-implemented .set_fmt
	is not error
Date: Fri, 18 Oct 2013 14:09:36 +0100
Message-ID: <20131018130936.GP2443@sirena.org.uk>
References: <87bo2n1l2y.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4721795583475292204=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C280F261AB4
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 15:09:42 +0200 (CEST)
In-Reply-To: <87bo2n1l2y.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4721795583475292204==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xq83POD0U/QTzh8i"
Content-Disposition: inline


--Xq83POD0U/QTzh8i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 05:25:45PM -0700, Kuninori Morimoto wrote:
> Current simple-card returns error if DAI doesn't support
> .set_fmt callback.
> But the return value -ENOTSUPP means "not supported",
> it is not error.
> This patch avoids such case

Applied, thanks.

--Xq83POD0U/QTzh8i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYTMNAAoJELSic+t+oim9IfcP/0c0aEY+196ReEZbMhetjPlx
Y2TfEslMI2/mOV0IrlRy/0yhtztgi0lP2FWRa5V+WMiI/lppldtCtPf++DJVmwDs
lXdOBAvaD2TXOI8ipTDsQPSGwzqUWbU9ew8zEtgvdNB/3M9xnSlC4pCzZy3ttNFA
fbMN3p361ydvqNZVnSTHGnkG/WMj5+bzGIAl0/iGSgMP5TewUjBNWov1AaUFG8PY
EHBKhWG3JW5TCIBLFw2TemtikcQDmi5bpObdvPw/GYqjnJS+vZ1LP4/9Y9suvGYa
gyurMDsA+rvAg2zIu8k2v8FRSbqPUDHhd6PXgVSJi1J0uyH5nz1cettGn9Q80WdK
YN2eklD4U+fmqP4PCzEvuYbNPC0TaecwKS2OcvmludUqFVPcRGgaYqHx2NuuzYU0
jKrDNFsWEIieUIVanhdVf/IZQZjBH6OE9YQX1n7PYMVXYFBPMwQXApWGytTa2GWr
fCMnumflO88Nb5qTVnsLkXIUciUmncz2GlIFme804z874G3ZTkVmyhich0X6L6mL
8AkGqTLI+M0HR6ypVN1iGCycOrxADUegWEvmjrQ8kpgzFEjHRS1eo9AiaVGOGzI+
/T1/rCyHUDUJ7/sYfYrGxyFRTm6ALsFmaNU58SxpSrm8fvdf872SZQpcpjGVN6LF
ZoPzBzYGuNtzVBdHG7L7
=hvZj
-----END PGP SIGNATURE-----

--Xq83POD0U/QTzh8i--

--===============4721795583475292204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4721795583475292204==--
