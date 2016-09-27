From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASOC: max9867/rt5616/wm8960: remove usage
 of obsoleted TLV-related macro
Date: Tue, 27 Sep 2016 09:17:29 -0700
Message-ID: <20160927161729.wdw2uywiux2szhc3@sirena.org.uk>
References: <1474933860-15692-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0043652425720877259=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77091265D93
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 18:17:43 +0200 (CEST)
In-Reply-To: <1474933860-15692-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, anish kumar <yesanishhere@gmail.com>, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0043652425720877259==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jqtg7sssfqbszh3y"
Content-Disposition: inline


--jqtg7sssfqbszh3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 27, 2016 at 08:51:00AM +0900, Takashi Sakamoto wrote:

> ---
>  sound/soc/codecs/max9867.c | 5 ++---
>  sound/soc/codecs/rt5616.c  | 5 ++---
>  sound/soc/codecs/wm8960.c  | 5 ++---
>  3 files changed, 6 insertions(+), 9 deletions(-)

Please send one patch per driver where there is no interdependency
between changes, this makes it much easier to apply your changes since
I keep changes for each driver on a separate branch.

--jqtg7sssfqbszh3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX6puYAAoJECTWi3JdVIfQ8m4H/jReNDOTfVuVTgncWIlk2LbU
k8VLdrWIYR280i9l5/eOSWajz74iPWbRd+kkxHUjf5HwNr6A3R7Ot+Mj6wakBD00
bPuz5JTs2rPb75PCRRhWbG7RJI0HpfjfFM/cI4D+w3vOUxCMJiLoXTsbJiBzN5fR
Cz1ZFzXZvwbMv+aO8wKs8iB7RcEE0hQaM8J5NzdHpzhsniWpOdc3e+Hvmia/ZcgR
fcl2CCl7/u7bbU2hDgcPi4K/klUwmml3GwHMlE8KJkSjnUuVYRXY1ypf/i0VX6y+
GwVlJ0xXi2yHIQ6UMiBqB8YUjbrKOXwCk7txtxbPL4FBi33tnWti2V2BadDN/P0=
=YcaQ
-----END PGP SIGNATURE-----

--jqtg7sssfqbszh3y--

--===============0043652425720877259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0043652425720877259==--
