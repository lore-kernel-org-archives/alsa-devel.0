From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] ASoC: dapm: Skip CODEC<->CODEC
 links in connect_dai_link_widgets()
Date: Mon, 12 May 2014 21:34:06 +0100
Message-ID: <20140512203406.GI12304@sirena.org.uk>
References: <1399472428-11034-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8583068066605096853=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4007A2650DA
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 22:34:25 +0200 (CEST)
In-Reply-To: <1399472428-11034-1-git-send-email-lars@metafoo.de>
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
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8583068066605096853==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="21IhkoDbXRTaKHBc"
Content-Disposition: inline


--21IhkoDbXRTaKHBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2014 at 04:20:24PM +0200, Lars-Peter Clausen wrote:
> For CODEC to CODEC DAI links the paths are created in snd_soc_dapm_new_pcm().
> Also for CODEC to CODEC links the widgets are connected cross-over via a DAI
> link widget, meaning that the capture widget of one CODEC will be connected to

Applied, thanks.

--21IhkoDbXRTaKHBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTA7AAoJELSic+t+oim95F0P/RksHPtk2E4vZivmxo7m/XDg
MPbbTfpvNYBLn132Xao0tFjGzbzd6WPn6Z5hslMLs1QODJmFqjPyP8qPaW2JhUks
9f0yaKJ55LlvU514gttU7mPh3Jsc3SrfIwntYUmKArj/hPRSYBE2SRMrM2cHUUGx
d5k5N47xg+ZHWX7j8KI7PM8OgATRGy0gPhM9x6YUbJWRwTe3+RfHciHQxzlAhwUI
RZKhGqloIrPtRGSZ3X0t+BnrEHNF7ZXVfMKR/1sXY3kLQyAuWAJXtWiPRvqMKynl
ibhkxt6MNZlid1hSn6nrll3tX0KcfoCiH6kxP4yqrLU3aFF61W4w7Jaivhb50srb
LJt5+8FeX7hLXenG+1L1x2j71Wz/6wlY4ZTRjy4lZBw0uFFfZipdUtWrVLxzki1C
7JbwEZaNjgDJzNBN5zdcvnFEQFlkjQ59pM/5LhZkqVsta82v4FK7AE4B7Lcurub4
t7zVTOSJCS4OZDVJpNdJv3x0NpjAD0r9KacUpE30o5OV+ge5s2uQN8RsT1++um5O
FJQ3niQ20V6rjXG93bDkiVd/a5mDnxi7wwAhP++EtbJQo5w7eNCH2tuNZfoJakQJ
+JcZbyKbLj8pii8EFZ/RAg9cuBmg+Nt0mPTirxhYGhFFLf+auUnqpy0tvjNb8wRu
YEJ83QbSTBje4OkiFMse
=VtUA
-----END PGP SIGNATURE-----

--21IhkoDbXRTaKHBc--

--===============8583068066605096853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8583068066605096853==--
