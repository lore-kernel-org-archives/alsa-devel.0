From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98357a: Fix speaker pop when
 starting playback
Date: Mon, 16 Apr 2018 19:06:57 +0100
Message-ID: <20180416180657.GI20726@sirena.org.uk>
References: <20180321223015.32173-1-ezequiel@vanguardiasur.com.ar>
 <20180322015456.GZ2186@sirena.org.uk>
 <1521723692.1890.1.camel@collabora.com>
 <20180327113631.GB29239@sirena.org.uk>
 <1522187864.2289.48.camel@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2641195698359893769=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 320442673D2
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 20:07:01 +0200 (CEST)
In-Reply-To: <1522187864.2289.48.camel@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ezequiel Garcia <ezequiel@collabora.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Barber <smbarber@chromium.org>, Mac Chiang <mac.chiang@intel.com>, Ezequiel Garcia <ezequiel@collabora.co.uk>, kernel@collabora.com
List-Id: alsa-devel@alsa-project.org


--===============2641195698359893769==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BWWlCdgt6QLN7tv3"
Content-Disposition: inline


--BWWlCdgt6QLN7tv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 27, 2018 at 06:57:44PM -0300, Ezequiel Garcia wrote:

> On a second look, I don't think digital mute helps here. And I don't
> think the problem is fixable at the CPU DAI level.

> The noise has been reported on bcm2835-i2s and rockchip-i2s, which made
> me think most SoCs were unable to guarantee the clocks could be stopped
> properly.

> As the commit explains, the root of the noise is that this amplifier
> specifies that the LRCLK cannot be disabled with the BCLK being
> enabled.

> I don't see any mechanism at the SoC level to guarantee that the LRCLK
> and BCLK clocks will be shutdown in order.

Honestly I'm surprised that there's a big issue here - most of the SoCs
I've seen shut everything down at pretty much the same time.  It sounds
like this CODEC is *extremely* fragile somehow and probably can't really
tolerate having the clocks stopped at all.

> Well, from the above description, it seems this noise arises from a
> limitation of the amplifier, so it doesn't seem too bad to apply a
> small delay and make it configurable.

> The default value (no delay) will work for most users, and the delay
> parameter would be turned on by those having noise issues with this
> driver.

> That is what patch v2 does, let me know if you still think it's
> horrible, or if you think I am still missing anything.

I'm still not super sure why you need to assert SD_MODE with an extra
delay here (for the benefit of the archives that's shutdown mode which
powers the chip off) - if anything I'd have thought it would be better
to assert it before stopping any clock and then deassert it after the
clocks are running again which would be what mute would do.  Why is that
not sufficient?

--BWWlCdgt6QLN7tv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrU5kEACgkQJNaLcl1U
h9B3TAf/VDLUUvizNEJ5oCnTH4qNmqblSMwKQZ0pu/73yrVa+uUMobhtT7ECZBha
9IjDbgE11g8a8A6ru4qnJAAicGYL65Pq5KjeOzG/ZWxgW3voBMZ8AKJULybHMJ+R
NxfEbVON8+Gv5aCcEWoUksJpUaRHFX+JIMVgo/DxIhVSpU5lD0edOJGQbH9S4K7F
em53IRfNM3uPUEt2FCyvUAjCchd+b0YnQUn+kI1b+kNvvEkudGk9UKdJ9FaY6rtM
d7j0k07WYQsf4KNdnSlUZkFmP+gDuI1eoB4ZL0EtUxUplLr7BCwKZSNHjnxt5fiz
sAs73ZIyiSl2wsgJ5JY/t6ZJgU0BJw==
=e7Zt
-----END PGP SIGNATURE-----

--BWWlCdgt6QLN7tv3--

--===============2641195698359893769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2641195698359893769==--
