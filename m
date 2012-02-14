From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Fix snd_soc_add_card_controls
 to pass correct data
Date: Tue, 14 Feb 2012 15:17:03 -0800
Message-ID: <20120214231702.GD3152@opensource.wolfsonmicro.com>
References: <1329260193-9757-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4585264748731031298=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 762C2243A1
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 00:17:10 +0100 (CET)
In-Reply-To: <1329260193-9757-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4585264748731031298==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 14, 2012 at 03:56:33PM -0700, Stephen Warren wrote:
> Commit 022658b "ASoC: core: Add support for DAI and machine kcontrols."
> created new functions to create controls for cards, codecs, platforms,
> and DAIs. The new snd_soc_add_card_controls() passed the wrong "data" to
> utility function snd_soc_add_controls(); it should be passing a codec,
> but instead ended up passing the soc_card. Fix this.

Well, sort of.  The idea with Liam's commit was to split things out so
that card operations got given a card so the argument change was
intentional.  What's gone wrong is that things like PIN_SWITCH() (which
is only ever used by cards) weren't updated to match so they still
expect to find a CODEC there.  This'll quite probably have broken some
other machine specific controls too.

I'll send a patch for PIN_SWITCH later today but it looks like we need
an audit of all the drivers using non-CODEC adds to make sure they don't
assume a CODEC in the callbacks.

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOutmAAoJEBus8iNuMP3d2LYP/2LIxAizqjQYtCLcDUfBuylS
9Snl/LMO1u3FSUQDQJvHwGmoNvpVnycsEYdr11BOTssu459J0lZFgb5gJqwM+czW
2mVEx6mpiziKd56xfpB+RZqrA2/mOQeWpZkbAbhPzTWnvg48IGEMG7w/ftHNCBvn
wljse+tvnEFkJMplJeYfXbGHqQUQvDjgBVv9K2UHslM7v/lLgKMLenrKHUtAAVsI
R4p4opfbfnQdtwltXirStc7ohRu3xGOaTMgSiPg8A5FJZreD5AnI370NVp8HpHXQ
W19ghp8WtNfyZ3vhIXsvLGAHHbiAP2pGNuUhwOZO5XyCOC/sGjR8rRtm6kRTxDD7
lhrhdSP/9+OaaGm8WNI3/3aN8xCEdXGcgmJ+lxbr0JUousQFpe/kAv2No0Wl4wcr
xK6ynq1iUkMz1NtXQj91hKM7sX3pH844LAwm9XaSsybPx9YMzaEkXfNhPsDKd7Dw
xwP0oUGy431lPGFZFT6KdOaAXGYJqB6VuRm9XrRGh0AVwiBvYKbz0r/7njm0CO1K
CWETfqEhAOeanfcHKLk3Pev2K92xWZgFICbLP5sVrLLZUiifcVLJZeq1ECJRH73T
NRr55DXN2xth7+ugPRNZgZBiW/lJKIqpOVblJlBqmKNJGynuh/czVcfrQY5D2FfE
9rVORL6y2QqdjC595KfD
=ptDv
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--

--===============4585264748731031298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4585264748731031298==--
