From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: rockchip: remove redundant
 dev_err call in rockchip_i2s_probe()
Date: Mon, 28 Jul 2014 14:46:44 +0100
Message-ID: <20140728134644.GV17528@sirena.org.uk>
References: <1406553660-30014-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0059429985322364111=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21C10261740
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 15:47:11 +0200 (CEST)
In-Reply-To: <1406553660-30014-1-git-send-email-weiyj_lk@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: weiyj_lk@163.com
Cc: alsa-devel@alsa-project.org, Jianqun Xu <xjq@rock-chips.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0059429985322364111==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfyoAYARu3sSNMjT"
Content-Disposition: inline


--OfyoAYARu3sSNMjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2014 at 09:21:00PM +0800, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied, thanks.

--OfyoAYARu3sSNMjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1lRBAAoJELSic+t+oim9S5EP/RJ/Wq0kL7i0epnc/KANFkvV
0HCvD2cXrvXefIPYlAUzSSeCOeUx8qSp1W0WPVwTW8plQQ5JlUwG7+E+UaLgmsrW
7qDg7THmT70nxUQdXjyQLr0o2ALfOammpPzVXRGL+GCgiAHFDxEPqp1g7ZNq76Nz
nanDLzbrUhSqe1IkxUiwbnCoVqVYb8fwMqEMyt3RpnU0vZPH4JyFnx6dJgm58J5j
6hlVmtW/E+H8JwHh/9jDFamFKvBXRdFAMJZHlEzRu42JiqHwAqe7CPTrDj4a+0ck
V/A6lSF6C94JzJF6yRDHBAveNXS9cvusERoEgt1njj/tRqIjSW57khFFBgvgk0dV
VyrsegtUcjZCdAynpstbWYYyVlfId/9O/tYuRtga91y9QnPHjuKx9HbTWUNp2bhM
lIDXPpl97HZA7q/55Bv//g/mG3oWiD+ILtHJuio+F7VZxmrgRLyDKpZtwtty9Vq5
NOaCUA3x0b8NM8yD/9vbC6Il9xfCi1aGFY1xaDJiNB0/Uyzby12J59oHpFgKLvUw
f1LK1hnAT6e2hyGLjPsmzQviNHwLPDuDD50k/WOk2eaRR7MwXFxTkjBOLcVDfSdR
8vNLkUruqW0xfz+C7HsmUPLBkL3Fz1CsDH+7AC084HU21FEOWq8HbjZAhLNlShdG
HdMDMCO5hTzTt+v+vAjM
=iBmJ
-----END PGP SIGNATURE-----

--OfyoAYARu3sSNMjT--

--===============0059429985322364111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0059429985322364111==--
