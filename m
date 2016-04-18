From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Mon, 18 Apr 2016 17:47:27 +0100
Message-ID: <20160418164727.GI3217@sirena.org.uk>
References: <1460578847-8712-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4564064577077314676=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A316C2650CC
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 18:47:34 +0200 (CEST)
In-Reply-To: <1460578847-8712-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4564064577077314676==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2+N3zU4ZlskbnZaJ"
Content-Disposition: inline


--2+N3zU4ZlskbnZaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2016 at 01:20:47PM -0700, anish kumar wrote:

> +static const char *const voltage_level_text[] = {
> +	"9.5dB", "10.5dB", "11.5dB", "11.5dB", "12.5dB",
> +	"13.5dB", "14.5dB", "15.5dB", "16.5dB", "17.5dB",
> +	"18.5dB", "19.5dB", "20.5dB"
> +};

As I said last time I would expect this to be a TLV control.  As far as
I can tell this is basically functioning as a maximum volume.  Otherwise
this looks good.

--2+N3zU4ZlskbnZaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFQ+eAAoJECTWi3JdVIfQaSQH/0KWRrgwqsNNYAwUw7dUlOw3
Mvx43S19bYpmNTJ7O/rl6eugl33DFpK+jwOG1Y+E4gs8aiZB9ppMHlFz77RA7fHf
RuKms/ONu9D0Uc6VcBVKhFKN0PEdYv2PuOrZbpNrjV0Ris7gBEKJ6PTwgse7CvfT
YTzLbSPVUWuk0QyZXULXRMmkVl9rkaFZ1yZS9P9dm1MSyaYwO7w52IfsVf4xc8d5
zeAutnI/9O6AF8Kt7WnZRXlLOGl/Yt0oz/fjbOCnkXkee50K2Rtprf/fvWodKWw4
9yWIVruyqVu2TR8D8qSiF/QEUXw1e/JkIawpVhJo98yJpCYPltKgNO+G0gS5lME=
=7ZIB
-----END PGP SIGNATURE-----

--2+N3zU4ZlskbnZaJ--

--===============4564064577077314676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4564064577077314676==--
