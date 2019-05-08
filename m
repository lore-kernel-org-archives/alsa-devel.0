From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v4 1/3] ASoC: rt5677: allow multiple
 interrupt sources
Date: Wed, 8 May 2019 15:35:58 +0900
Message-ID: <20190508063558.GM14916@sirena.org.uk>
References: <20190503230751.168403-1-fletcherw@chromium.org>
 <20190503230751.168403-2-fletcherw@chromium.org>
 <CAJ77E19K7ukNzvhOx1Jh_E6A69fqc6OMJ1aEgR6QjFmM0d=ePw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yf+QnTYkcH7pT0Mu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ77E19K7ukNzvhOx1Jh_E6A69fqc6OMJ1aEgR6QjFmM0d=ePw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Curtis Malainey <cujomalainey@chromium.org>
Cc: Fletcher Woodruff <fletcherw@chromium.org>, linux-kernel@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>
List-Id: alsa-devel@alsa-project.org


--yf+QnTYkcH7pT0Mu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 02:10:26PM -0700, Curtis Malainey wrote:
> On Fri, May 3, 2019 at 4:10 PM Fletcher Woodruff <fletcherw@chromium.org>
> wrote:
>=20
> > From: Ben Zhang <benzh@chromium.org>
> >
> > This patch allows headphone plug detect and mic present
> > detect to be enabled at the same time. This patch implements
> > an irq_chip with irq_domain directly instead of using
> > regmap-irq, so that interrupt source line polarities can
> > be flipped to support irq sharing.
> >

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--yf+QnTYkcH7pT0Mu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSeM4ACgkQJNaLcl1U
h9BylAf+Nv/ilS/5+jTsgqLELyIU1qpJcPHRC012pUfUyxBH8YSDpyPfqOOCGXoI
O9V67lf67LEVCYsUXgSfpcALi084m38vQfXGJppyPniYWEczD90yZOkm2faA46o4
QKeDeVGTwtbZ5phTrqOx9YsBE8k8XfBmzcy3u1b0ZmHMUqAM1b33QO4rCFJs5iZD
at95vkcj9Adm092gyGgmcY32xIAMR2Y0CGlKAAGd9Gk77mtPL7gVhrPXGQu266Cb
XKrDI44ZX79Ob00wMMoJUaVKAAbGwcl71VOXQFpI5tnDgnV5jCq+1k+00b6xlwiC
sE+rE+1f4uGwLBJt04QQa8kW8dA0xA==
=mlaw
-----END PGP SIGNATURE-----

--yf+QnTYkcH7pT0Mu--
