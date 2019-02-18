From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Fix refcount underflow
Date: Mon, 18 Feb 2019 18:22:40 +0000
Message-ID: <20190218182240.GG10794@sirena.org.uk>
References: <20190216100927.10017-1-daniel.baluta@nxp.com>
 <87pnrp52jl.wl-kuninori.morimoto.gx@renesas.com>
 <87lg2d51lv.wl-kuninori.morimoto.gx@renesas.com>
 <b4bee8ff1307004ec9d1122f70ab2cb0d636ea4a.camel@nxp.com>
 <s5hpnrp8ret.wl-tiwai@suse.de>
 <20190218175010.GB10794@sirena.org.uk>
 <CAEnQRZCLE7DHumOCDSXxaKEgpukDgP5EtH=j7xMwTBJcTWQTZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6989027852877012952=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 30D8826552B
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 19:22:43 +0100 (CET)
In-Reply-To: <CAEnQRZCLE7DHumOCDSXxaKEgpukDgP5EtH=j7xMwTBJcTWQTZw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "vicencb@gmail.com" <vicencb@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============6989027852877012952==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kadn00tgSopKmJ1H"
Content-Disposition: inline


--kadn00tgSopKmJ1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2019 at 08:00:48PM +0200, Daniel Baluta wrote:

> Would you want me to change the patch for 5.0 to have an identical commit
> message as the one for 5.1?

No, that's fine - since Morimoto-san's patch has been tested I'll just use
that.

--kadn00tgSopKmJ1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxq9/AACgkQJNaLcl1U
h9CKWAf/QhJOOS76j3FBAB7PkiShjc2QFHAP9oqiH9Lww2tp3YOOsGCFdJlb6cBI
w2zA6yFx1Y4tPYVlsVQIX5U2aGmHzIebVvsxQA4n6GMGj8kmf87AI+x32JXBqV7Z
T2dKCFkAx67vaFy6ReFW7Ck0SZfRLjEYMWTANBmnmq7wlgApQxuvlySMIPnrN7Md
5t5qn2xFsBonZACjE7PgQEB1KaLKsWCPj2G8HZexyr0wq68ll4snaHxHHbg7Gna7
Iv+wCry69RvEPOcq+aUH/PttGwL4BBhKniCsmvVYH25+vFt366BNUzkunMIQ3yk1
M8+REeKOGuXHuf0wr5zWsnLoaseIAQ==
=wHox
-----END PGP SIGNATURE-----

--kadn00tgSopKmJ1H--

--===============6989027852877012952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6989027852877012952==--
