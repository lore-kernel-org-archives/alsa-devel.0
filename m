From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: twl6040: Prevent extra power
 transitions during resume
Date: Fri, 11 Jan 2013 15:02:48 +0000
Message-ID: <20130111150248.GD20956@opensource.wolfsonmicro.com>
References: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
 <1357900355-5055-3-git-send-email-peter.ujfalusi@ti.com>
 <20130111115207.GW20956@opensource.wolfsonmicro.com>
 <50F01644.30703@ti.com>
 <20130111134601.GA20956@opensource.wolfsonmicro.com>
 <50F019E9.3030805@ti.com>
 <20130111142403.GC20956@opensource.wolfsonmicro.com>
 <50F02537.1000305@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8426442177949208888=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98BDE264ED1
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 16:07:50 +0100 (CET)
In-Reply-To: <50F02537.1000305@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8426442177949208888==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Eldrgvv4EWsIM1sO"
Content-Disposition: inline


--Eldrgvv4EWsIM1sO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2013 at 03:44:07PM +0100, Peter Ujfalusi wrote:

> If it's OK I'll resend the series and replace this patch with a different one
> to remove just the second
> twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
> call from resume.

Sure, no problem.

--Eldrgvv4EWsIM1sO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8CiCAAoJELSic+t+oim9gOQP/3VnBhv/qtuWVbrXX9/Osv/e
ZTks1hoa/w6P+A/wpmpr5AhYSjvfQazX4EafgSuao0Jv6h25NKfoTpgDSeifbeux
OeFfMb4bDzRxR2pNwngHkz+iqVv/PeHb234Fm54fkY632zr+2Ndn2dc9Z5REOpUi
Oc+1SH2Tt9URgtMZ44NhnkJuxpz7JVBFtNudWgREtGG21xGsuDnSad7QzXlKSBFf
65d4nIzxiBNKEkLwC8taqvlrgjpOX95hmVUe0UrunxmQRTkqn2iuGEc8B1tuHxMr
o8WkFE3gP5tzIRJhk+r6Kt4xI3hzmnTE1Y98j/pz9vYHNgXWN7vfml++/ISwyUcd
mErGM7exbZduYM+cJXyugW9YN95barlJpR3D8/jUDcN7LacAzQrlkbtHDeTX8hmo
jMYQMPMUL7NXN0hh3QxL01ns+eQB5BuHsKJaQRmUaVX6lmI/e+hPMZaGJDoJSZik
60wL+rZvsp/2P78N6dTxegHtfriSvLzWM+mZDjVHi9n/n+EBFVyVdgzR9ILz0SXa
j0yXWuXEmD474peIDm0vGbg1c9TGcgQaPtoymJvHBI+C8wlxOICxD2l5X7GECpdf
HkrlMX7+fWlXCv2Lp9BE5Xs06UUksl93bKEmjhkraT2eesy4497ssBp7M1GWY4ET
budRw+1FfKs4Q8GStl9M
=4ML8
-----END PGP SIGNATURE-----

--Eldrgvv4EWsIM1sO--

--===============8426442177949208888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8426442177949208888==--
