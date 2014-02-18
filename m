From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/15] Input - arizona-haptics: Fix double lock of
 dapm_mutex
Date: Tue, 18 Feb 2014 09:28:07 +0900
Message-ID: <20140218002807.GG2669@sirena.org.uk>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392655903-24537-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140217192025.GB19223@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140217192025.GB19223@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, myungjoo.ham@samsung.com, cw00.choi@samsung.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 11:20:26AM -0800, Dmitry Torokhov wrote:
> On Mon, Feb 17, 2014 at 04:51:29PM +0000, Charles Keepax wrote:

> > snd_soc_dapm_sync takes the dapm_mutex internally, but we currently take
> > it externally as well. This patch fixes this.

> Hmm, from the first glance this needs to go into current release,
> however it seems that it has been broken by
> a73fb2df01866b772a48fab93401fe3edbe0b38d 2 years ago so nobody cares...

Please include plain text versions of commit message descriptions, in
this case you're referring to "ASoC: dapm: Use DAPM mutex for DAPM ops
instead of codec mutex".  I expect nobody noticed in part because a lot
of use has been out of tree on older kernels and in part because the
issue is a race - there's a good chance things will work just fine
without the locking.

> Looking at the series I am not sure that this is right direction. You
> actually do want unlocked versions of snd_soc_dapm_* functions so that
> callers can take dapm mutex and then perform sequence of operations. The
> currect callers that were taking the mutex should probbaly be changed so
> that they do not drop it until they called unlocked version of
> snd_soc_dapm_sync().

That's all more work than is in scope for a bug fix though.

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTAqkUAAoJELSic+t+oim91ugP/Red69cNLvmI8BIMet/dEQRC
UyAUMzqe4KeOTjzxpyKxR3UFAGDyVX0EzNiET6BJtESJKRjI0DO8lBRXuvZsQOlK
KDqgHqIzrIEt0yDkCixyrr3epDdJ/5UAHb0NoKecOUKAUjNnq2SvaFV62ayoH6m3
KIw0PaswdkGtFrglAC20mEurnTAdG+2nuZitLKwpxv/tYiikYXILcmmbdBY9eiR9
VAYPjBuHArZw0Qiq6g5bl2QvWrVE6ymt31/HACmHnPjAmKpe4EzxDp37vmwjffk0
xoJnjlnSM5C6mfIJ5g4+n9n13Lv0dRBvda74Ggx6FpF2KDUHw973i4hbR27ePzgl
q2eIt+WTwPWp/QkjxLLFi9CZOyseL9OJnb3yiItxvzKUfLcE2VJSoTtQF4++AUSd
F//4DoXyWbrxkp86BUn2F/3eHkVldiaHqEW25o5/u4nn3YjvR0cYSET/Bwc/LOh2
KUXY1FqoOQyvlA2+owPiWzfSTdE8+H5TLzpLOY3kCtQFv3an0E3KGiZfCYJOsjBc
JLt3NqcxwnKeGgkEtfLV3BrIf8UvSrYE3fMgyxEo+opX9hPULS0CLk8wx1qQchnp
wTFp0+koOyWQKcMnb/zfDupyiqKJOh6FfxEp7ouflE0Y8ygU0RH/J366bQCYsjWT
BijjNHJM2+QtXGZjBO5r
=FYp9
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--
