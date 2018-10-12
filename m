From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sun4i-i2s: don't try to start up or
 shut down DAI if it's active
Date: Fri, 12 Oct 2018 18:45:43 +0200
Message-ID: <20181012164543.GF2340@sirena.org.uk>
References: <20181012153254.10844-1-anarsoul@gmail.com>
 <20181012160905.GA2340@sirena.org.uk>
 <7437935.iAfLsdZGOz@anarsoul-thinkpad>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2797358806546529503=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C39C267845
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 18:45:50 +0200 (CEST)
In-Reply-To: <7437935.iAfLsdZGOz@anarsoul-thinkpad>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Yong Deng <yong.deng@magewell.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2797358806546529503==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 09:28:56AM -0700, Vasily Khoruzhick wrote:
> On Friday, October 12, 2018 9:09:05 AM PDT Mark Brown wrote:
> > On Fri, Oct 12, 2018 at 08:32:54AM -0700, Vasily Khoruzhick wrote:
> > > Otherwise we may end up with shutting down I2S if shutdown() was
> > > called for capture substream, but playback is still running.

> > Would it be cleaner and more robust to use runtime PM?  I'm wondering
> > what happens if some of the configuration stuff turns out to also need
> > some of the clocks for example.

> I guess. I'm not sure why this code was put into startup and shutdown=20
> callbacks in first place.

> Maybe Marcus or Maxime know?

> As for configuration - only bus clock is necessary for configuration and =
it's=20
> already enabled in runtime_resume() callback.

Probably these really are only needed when audio is active so it's
saving that little bit of power in which case your fix looks good to me
but I'll leave a chance for the people with system specific knowledge to
review.

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvAz7YACgkQJNaLcl1U
h9B+/wf/ePIwBuIQH0aTfQCfu63YYQZSXJzdGmpD0p6CpnT9mkTI9yAzOHalhfsn
C9EPi6GCK3PM7eF65AbCx48LT6A9ZE7+tjY+Xi09FR9cL+5Xma/k2n910EpxurYI
/4X0ubT4APr+9QeBW7YWQTQ+3qFvtaNxFDemFu1WLyuCWiTOVzSYiYwPMceDx8Mk
VzbhXUiTRfdxA87CDU3zu+6xTx59IKVwrGI5FyzF6MncgiCoYYxjr1efJuj6X7Z5
OJBCB4rNYBJHgNNAi1zGyQtZsjp6CmJegEZrxI0lIw8W1UQEDNfcaCPclkgC/j3N
r1UDiM3a03ZcKeIy5+mDnwoQEdwGwQ==
=MUMe
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--

--===============2797358806546529503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2797358806546529503==--
