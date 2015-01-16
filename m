From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: smdk_wm8580: Pass card DAPM
 context to snd_soc_dapm_disable_pin()
Date: Fri, 16 Jan 2015 16:59:54 +0000
Message-ID: <20150116165954.GG3856@sirena.org.uk>
References: <1421415293-29589-1-git-send-email-lars@metafoo.de>
 <1421415293-29589-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5841240238842586846=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 01C8E260453
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 18:00:01 +0100 (CET)
In-Reply-To: <1421415293-29589-2-git-send-email-lars@metafoo.de>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5841240238842586846==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
Content-Disposition: inline


--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 16, 2015 at 02:34:53PM +0100, Lars-Peter Clausen wrote:
> The "MicIn" widget is a card level DAPM element so pass the card's DAPM
> context instead of the CODEC's DAPM context to snd_soc_dapm_disable_pin().

Applied, thanks.

--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUuUOJAAoJECTWi3JdVIfQ6ZsH/Rvw1bhKUiqEqXdCzYxcuQzB
Aa5oKac46Rw5IHtLh1+aCycvmzmGCtehBZ1V2jaCRbOqCwDsOD79WEExtG8ySvt5
ePxybESKh8TPu22w0Ps5lKvvwB9FnYYLZJkFezLGVzN1loI+sYDe2VcM00GxYalZ
Y/pJl6qLsbHRGnIzVLi912Gfs2w3UCO/lh6qmuyfnqqWmMKAl1oPavRfzV9b2Q38
TcsJzvBXnTvLt8smyv0Qj/0GX9rILFAQ0+JPzSSohk/Xo0d/5H1a4gG3IQp9IMGf
y8L6eOrwRm3G82JUq99U1sKhVEcid3B0b1HzDIuJ4ZnlJBTywJOv/erNhfVn+oY=
=kIYY
-----END PGP SIGNATURE-----

--oXNgvKVxGWJ0RPMJ--

--===============5841240238842586846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5841240238842586846==--
