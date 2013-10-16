From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: dmaengine-pcm: Add support
 for querying DMA capabilities
Date: Wed, 16 Oct 2013 19:10:57 +0100
Message-ID: <20131016181057.GX2443@sirena.org.uk>
References: <1381237680-32654-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2871219302704415408=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F08B52651EB
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 20:11:01 +0200 (CEST)
In-Reply-To: <1381237680-32654-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2871219302704415408==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GH/dAUXXAlpmc9La"
Content-Disposition: inline


--GH/dAUXXAlpmc9La
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2013 at 03:07:59PM +0200, Lars-Peter Clausen wrote:
> Currently each platform making use the the generic dmaengine PCM driver still
> needs to provide a custom snd_pcm_hardware struct which specifies the
> capabilities of the DMA controller, e.g. the maximum period size that can be
> supported. This patch adds code which uses the newly introduced

There was some discussion on this but it didn't seem terribly
conclusive.  Are people happy with these?

--GH/dAUXXAlpmc9La
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXtatAAoJELSic+t+oim9+EsQAI2yR1/DQ9Xr0mN3O5LPjQzK
fIjXsoUm9z9rL6VvPt4VXk7v24er6JdkPbaI+FUp1aa6s7uA3LjB96N3t18F3wtY
zxnDzWa0GLfxjuRnTgQ1AKFbJSAh7H4Ef/p890mRSnseyHOP30TMIAN3cjfeackv
kUGbyfM+V1+Mfdj/sF6WnSmqoypS7IeR6Jn/LuAfNIKlhckcCS6Pq5Y0ZUhl7ehr
MK1nxvJ5ROcutovrR1yHkS/i+u7/YcSP0N1N4Qi51bjRErxC2AaMmlzeAsXRO9/h
qCiDD/rywPqQhrAhoH1C8YdlWgWbaM2aO3e6sb2FjUIjaRAgK8mlraAWXJpMptP+
VBUVG5mEvwc/ARF9PyvQu1SL9sTFubvQ6PL9TUiBPWHEL6mEjIled4BjSHQRE6vc
Ioe6J3pSpzqYdsAhAushNBGIQzBbN+m7IuXbHIt+x1LNrfdfROXK2H0IRsSiyXdB
wiZDzIQ7nc8xpX8rdc5N9JIkRGD2JztVlXJIR8AbFLgBJEkE5lQOSvxODHhNT1Xm
E91XKlXMy2fKzuSWlSdf5J7MXh/CpntYLKC9yuNWe0adpr+8fitAS1q1w75UG9Rv
1ySisZNCDT5KCvhY9W5LarF5ENO5hUr1ATD4qk8ZWTxFE/ECeThSsSnsJXYO4YLI
Bm2gzC2h8eSqNXxxI2zU
=qtsN
-----END PGP SIGNATURE-----

--GH/dAUXXAlpmc9La--

--===============2871219302704415408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2871219302704415408==--
