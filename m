From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [RFC] I2S and LEFT_J (was: ASoC: pxa-ssp: enhance
 I2S and add Left_J support)
Date: Mon, 15 Jun 2009 23:11:13 -0300
Message-ID: <1245118273.24109.642.camel@brutus>
References: <20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
	<f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
	<1244730992.21356.50.camel@brutus>
	<f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>
	<1245077824.24109.51.camel@brutus>
	<20090615150433.GF6106@sirena.org.uk>
	<1245086420.24109.159.camel@brutus>
	<20090615174037.GH32700@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4746092363335872913=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B9782446B
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Jun 2009 04:11:22 +0200 (CEST)
Received: by qyk1 with SMTP id 1so5234078qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2009 19:11:21 -0700 (PDT)
In-Reply-To: <20090615174037.GH32700@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4746092363335872913==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-IiI4cI3ur5UShJeIjLbF"


--=-IiI4cI3ur5UShJeIjLbF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Seg, 2009-06-15 =C3=A0s 19:40 +0200, Daniel Mack escreveu:
> Forbidding it due to API clearance even though it's
> supported by the hardware is a step backwards.

I wouldn't consider this API clearance. If you look at the pxa-ssp.c
history you will see that the first version of this driver that hit
mainline used to work for the standard 32 bits frame_width for 2*16 bits
samples, for DSP_A/DSP_B and I2S.

(Tough I2S was broken for other reasons if you used
SND_SOC_DAIFMT_IB_IF, and required a set_tdm_slot() call)


Commit aa4ef01de5f2e7ed948b88f9f1cfc93c8e0c3f25 broke DSP_A and DSP_B
for 2*16bits samples, if you don't make a dummy set_tdm_slot() call.

Commit 72d7466468b471f99cefae3c5f4a414bbbaa0bdd broke I2S mode for
pxa2xx, even with set_tdm_slot(). And introduced a relation between
SerClkDiv and sample_width that shouldn't exist.

Commit 92429069d0fc9f52d436c9067c5b5c392e3f8876 extended the breakage of
2*16bits samples on 32bit frames for all modes, unless you call
set_tdm_slot(2, 3).

So, mostly, I'm fixing regressions. ;)

Of course I want the driver to work with all the weird non-standard
formats that hardware may require, but the current code is broken on
standards compliant hardware unless you do some set_tdm_slot black
magic. Doing set_tdm_slot hacks is acceptable for non-standard devices,
but is not a nice thing if your hardware is standard or if you want to
use _real_ network mode.

--
Daniel Ribeiro

--=-IiI4cI3ur5UShJeIjLbF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko2/0AACgkQw3OYl0G0liRwAgCfTF0End6ve8axudV16uEAWju6
jLsAn3FHmu+c6qqOw4Ao4PM5UO1k4ONF
=Z0YH
-----END PGP SIGNATURE-----

--=-IiI4cI3ur5UShJeIjLbF--


--===============4746092363335872913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4746092363335872913==--
