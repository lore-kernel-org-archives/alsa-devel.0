From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: rockchip: add rockchip machine
 driver
Date: Tue, 19 May 2015 12:16:02 +0100
Message-ID: <20150519111602.GG2761@sirena.org.uk>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk>
 <55535035.5070608@rock-chips.com>
 <20150513164250.GB2761@sirena.org.uk>
 <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com>
 <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
 <555659DB.9010204@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4201370400123746347=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B1362650C3
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 13:16:17 +0200 (CEST)
In-Reply-To: <555659DB.9010204@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, zhengxing <zhengxing@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xing Zheng <acgzxing@gmail.com>, Douglas Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Dylan Reid <dgreid@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============4201370400123746347==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vjcY9ywptAIx3JpL"
Content-Disposition: inline


--vjcY9ywptAIx3JpL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2015 at 10:40:59PM +0200, Lars-Peter Clausen wrote:

> I think the proper way to support this is come up with the concept of jack
> detection providers and consumers. A component can register a jack detection
> provider just like it can register a DAI. And then in the board driver you'd
> just link the jack detection logic to the jack using the usual approach,
> which is also used for DAIs (e.g. of node or device name). The core would
> then take care of calling a enable callback or whatever is required to setup
> the jack detection logic in the driver.

Yes, nobody has really cared about it since we started pushing things
out of the card init into the device level.  We would also need to add a
way to force microphone biases on for devices where that's not a part of
the jack detection IP.

> This would also nicely solve the issue with the GPIO jack detectors, where
> we currently can't really handle -EPROBE_DEFER. The GPIO would be requested
> by a jack detection provider which can request them before the card is
> registered rather than having to do the requesting in the card's init
> callback.

Cards should be able to do their requesting in their probe function
prior to registering with the core even without anything else, though
that needs a bit or refactoring too.

--vjcY9ywptAIx3JpL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVWxtxAAoJECTWi3JdVIfQkLIH/2cJwvtJ0Xppc1u7IP1bJWLL
xjNk6s+qb4Ewcsq1bLsCgx+mUpXoONjBfbNZ2mYpRMr40L14565sEBHwk44uYesw
oM3cfpXROKcGIznnnodqdYvG/6AxATEUBBAHidNKCk+HgCfPTdiaYb1Nn/vul7fA
0p5wJfSaMdDk6wQjm7oUIN1+woOQ+29b1tTZ1whSZV3My2b+up50/dDlxl8yuVzJ
S2ytgHVD/APOCiEmxYvIDQ5kV0Gk5rmX6XSFYp36TPc9IIGGYE61tb4dGLSWLy6U
VZ9rAj18WyJGAK2Wy2E1xq9R84gSLuegzGlG+ZwVvoYG1EiFyXptmB9cuJpHa7E=
=t67s
-----END PGP SIGNATURE-----

--vjcY9ywptAIx3JpL--

--===============4201370400123746347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4201370400123746347==--
