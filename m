From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for
 lockdep
Date: Mon, 29 Jun 2015 16:34:11 +0100
Message-ID: <20150629153411.GG11162@sirena.org.uk>
References: <558C0067.2000401@linux.intel.com>
 <558C1824.8020204@metafoo.de>
 <20150625153325.GR14071@sirena.org.uk>
 <558C229D.4090409@metafoo.de>
 <20150625160817.GT14071@sirena.org.uk>
 <CANMq1KA2C1ZYUd_s_R5DWn-Hy_XZZQ_aaR47VLpPsNvcvxEQ9w@mail.gmail.com>
 <CANMq1KBcWw9jsGkrK0dYzOWGZAZYmHdo6gvvpQwt_ftq+avqVg@mail.gmail.com>
 <5591414D.6080802@metafoo.de>
 <CANMq1KAmV7f2f8zhL+VVdpL3AeQKe8RB5nigmZDwrn=JbWGh9Q@mail.gmail.com>
 <559153A3.1000006@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559153A3.1000006@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Arjan van de Ven <arjan@linux.intel.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2015 at 04:18:11PM +0200, Lars-Peter Clausen wrote:

Please delete unneeded context from replies.

> Leaves us pretty much with only two options. Either add a lock key pointer
> to regmap_config which needs to be manually initialized. Or wrap all
> regmap_init() variants to create a static lock key. I'd slightly prefer the
> later. We can avoid most of the boiler-plate code by using some helper
> macros to generate the wrappers.

It's better to keep the bodges in the core, yes.

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkWVzAAoJECTWi3JdVIfQDiwH/25DEDkVLXtZDf8gxjuAfFuw
uLU793s6mCrlbyHWRdkUJ7GkLQTQdn1rPbWUEgoV0qZfm5jkoslHYuxrKIruQUXm
1jVX7nML5sCnDlOEI3JENBWiWLv8IDSVBjsQGNwbSC41AoY9DcNcxzj1g8qwtyhN
1i/M0FOYxV4FirWx/g8RIX1QMjZFwdaD6oHQUt7fKRac49OOxALTItN2UAnbGEQH
cTLMXHWi9Z+M/DNysbvWnrpg09XxFACDTxePC6i3SSq2S3DHU5jENp4YkmfC/a48
ArR23OZr93OL8zatPPZfoyH4T5M6uGuUk/O6Glf3r9toRLzRi8NTJ71GKMZ2f1g=
=n1hK
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
