From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 4/6] ASoC: codecs: msm8916-wcd-analog:
 set default micbias voltage to 1.8
Date: Mon, 31 Jul 2017 11:07:05 +0100
Message-ID: <20170731100705.lbnodjfgnwxwhqyt@sirena.org.uk>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
 <20170726003512.18965-5-srinivas.kandagatla@linaro.org>
 <20170728134038.y5wnrurmwn4bxxsh@sirena.org.uk>
 <94765031-d840-bcae-11e3-16e1e55a7aa7@linaro.org>
 <20170728140108.ds5x4irfep4ss3lv@sirena.org.uk>
 <0f96d65a-f7d9-0139-e0c4-49069e717f34@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1424552902335438153=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA2EA266F3E
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 12:07:15 +0200 (CEST)
In-Reply-To: <0f96d65a-f7d9-0139-e0c4-49069e717f34@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============1424552902335438153==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a3ctjcd7pbsc5av2"
Content-Disposition: inline


--a3ctjcd7pbsc5av2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 03:45:08PM +0100, Srinivas Kandagatla wrote:
> On 28/07/17 15:01, Mark Brown wrote:
> > On Fri, Jul 28, 2017 at 02:54:59PM +0100, Srinivas Kandagatla wrote:

> > > This was set to 2.7v previously for special headsets which have high
> > > impedance.

> > So obviously this will break existing users.  That's not OK.

> This would not break any exiting users, as this part is applicable for on=
ly
> headset detect usecase. I will try to address this in ("PATCH 5/6 ASoC:
> codecs: msm8916-wcd-analog: add MBHC support") patch.

> The default voltage for most common usecase should be set to 1.8v anyway.

Just leave it at the hardware default like we do for everything else in
ASoC. =20

--a3ctjcd7pbsc5av2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll/AUgACgkQJNaLcl1U
h9CVtQf9G70Z+V4+GCkuU7EAiG9PDKMIhkduxNaoyH47VoN4b/DHqK2BQxqUW279
LGYqdBCu14cfMheo0HBf9G5ZRBhNOHWHMfMfk28XJ6I8qqIwEfU/uhRehXXU96OD
gD30sZVjK4GtCCvslmd0TRNf5B4BKMPnAaMGV14ouzamPURE2QmIX+78ER8UAdW2
RHfxUxx34IJ30vVQikE66i3rpdGJfftPGtKh9e6o/mSX1hjG6gmnqqvdVN+rgGdz
7xlqrOeWW0ddllrec9BGmP79iZcb+dQJqD/33iWcF8HNxmCxZDXw0g1MVcpiQ/Hg
JT8u6XlZT3ODCtvexBOo5VieWe2Atw==
=005P
-----END PGP SIGNATURE-----

--a3ctjcd7pbsc5av2--

--===============1424552902335438153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1424552902335438153==--
