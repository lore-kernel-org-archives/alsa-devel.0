From: Mark Brown <broonie@kernel.org>
Subject: Re: wm8960 sleep time is too long when system suspend
Date: Mon, 2 Nov 2015 11:12:40 +0000
Message-ID: <20151102111240.GB20228@sirena.org.uk>
References: <20151102084402.GA7603@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8165417502919163099=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF4552607C8
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 12:12:48 +0100 (CET)
In-Reply-To: <20151102084402.GA7603@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8165417502919163099==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2015 at 04:44:04PM +0800, Zidan Wang wrote:

> Hi Mark,

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> In wm8960 codec driver, suspend_bias_off has been enabled. So when
> system suspend, the wm8960 codec will go to bias off, it will disable
> VMID and VREF, then sleep 600ms. It seems that 600ms is too long for
> system suspend.

> Because the wm8960 datasheet don't mentioned the sleep time, so i want
> to check with you if we can shorten the sleep time.

These times are totally normal for a VMID referenced CODEC like the
wm8960, attempting to ramp faster produces audible artifacting.

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWN0UjAAoJECTWi3JdVIfQ6w8H/1Dxstznkt5srWj8sHZvRjAX
S7PVnHupoIBKVKNcRib3UBsEvhInFt1fcHj3pbt9I96jF6OuznTo6oGSVyxPuKvd
dFdtBpRo1i6jTsLvs9i4pHMj2nyiu4UPG423iE/Yv4vLKMdUBvpGNbGZsfPOkNFa
JmLT/D5Y05HhyXcqEi4Qwg+IaEewoNsIFDNzm2WQqeTXwNKskmPfZ3JdkoTl1oC6
XK5gSjvBHhUL7Mo04rNe44VIoVA/J5S6lXWOs9EUVy/yc0iMjKVTL//rcXKSUiMr
zuD9LZd7p774T6tXeH4DYoWQEK5ZtUhz2GBWGGjZ6qBcdt8y1oGVFV3tAJp4vsE=
=NjwX
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--

--===============8165417502919163099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8165417502919163099==--
