From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Questions regarding adding regmap support for
	TLV320AIC3262
Date: Wed, 13 Jun 2012 18:56:25 +0100
Message-ID: <20120613175624.GG7804@opensource.wolfsonmicro.com>
References: <6817C817C9581447825BFB369EAC42163E936642@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0196079736972802031=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1965E104543
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 19:56:26 +0200 (CEST)
In-Reply-To: <6817C817C9581447825BFB369EAC42163E936642@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Navada Kanyana, Mukund" <navada@ti.com>
Cc: "alsa-devel@alsa-project.org." <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0196079736972802031==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 12, 2012 at 08:45:51AM +0000, Navada Kanyana, Mukund wrote:

Fix your mailer to word wrap within paragraphs.  See email-clients.txt
in the kernel.

>   In order to support such a regmap, I would like to push the
>   following patch for regmap.c to add support for 24-bit register
>   addressing.

This looks fine, please submit as covered in SubmittingPatches in the
kernel source.  You might also want to have a look in the list archives
for the patches that some of the guys at Dialog have been submitting for
devices with paged register maps, it sounds like these might be useful
for this device.

Please always CC the appropriate mailing list for the subsytem, in this
case linux-kernel.  There's nothing ASoC specific about this.

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2NQ+AAoJEBus8iNuMP3dzscP/2kf30Cv/fmY2Fmdc67O0X9B
AAAHzdHemz8JIo4QlzVaOqf981NBbjfroc2549lcS1xYUHsgKvCEp/3QjjIJlAtd
vdHmcwn4svNFB/g//B+7DfzT80SR2E6ftAtgd2Ll3Tv1qVz++cSRqxurg59bnNjE
FN1gGUJKsbKOtFSTaMmBzUHS1yl7U4PtHPENKNYextSj17Jw2qCm7l6Ca/3qcKw9
2a9YlzxAOI/cacnXjPXIN9DJAJEBseEM5na23y3DsIBPhk1Un95JR7r4GFzaGlut
Lt69PjEEP8RKo33R7bkUUmX1ETV6+YBoQDZ2Hh7R/lS6zboQ5yW98d7VYxQ0L0e7
aDpkfebYRB2CF3B689lxUKP65WJY55SmRXq80KvWMKF7BPcCuGF/xcCgLi/IFWpj
Iru7Dk35FHGlPS1zQ2TwvG1RL/Q0aYoLb4B89/Q6PxcWSpZ8sp9TFeOa5E+ERi6P
qNwRCLYBWM4PKRve3zGJUmEP0l7YeAYtFVJ0BD7pqV9UP13hxdarVlsPans4MjuU
WmbZf5/0GhMvMtAapx/qFHgkYdpdnynwosniVh43uOLVU509ypE90KWfg5vZsEdt
LlU+gTKhK1g4blfUNgntGgiwnx8W9jpwdjfGc7J4Oeyv0Mv4jutHBS/87RakKVlL
XOnUH0vKfAFRQ/avxjvV
=BxND
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--

--===============0196079736972802031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0196079736972802031==--
