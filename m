From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch
	fall-through
Date: Mon, 6 Aug 2018 12:34:26 +0100
Message-ID: <20180806113426.GA17525@sirena.org.uk>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
 <30613.1533313609@turing-police.cc.vt.edu>
 <85d918a5-6a14-ead0-4d0e-d63b5e43ad81@embeddedor.com>
 <20180803164504.GF6591@sirena.org.uk>
 <684a4fe9-6818-d19c-e7b7-fb8d592a0cee@embeddedor.com>
 <39703.1533318918@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2558175337382804349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A2D62676A3
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 13:34:30 +0200 (CEST)
In-Reply-To: <39703.1533318918@turing-police.cc.vt.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: valdis.kletnieks@vt.edu
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2558175337382804349==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 03, 2018 at 01:55:18PM -0400, valdis.kletnieks@vt.edu wrote:
> On Fri, 03 Aug 2018 11:56:12 -0500, "Gustavo A. R. Silva" said:
> > On 08/03/2018 11:45 AM, Mark Brown wrote:
> > > Basically nobody ever uses OPCLK so I'd be susprised if anyone ever
> > > noticed.

> I wonder if nobody uses it because any attempts to do so get an error? :)

No, nobody ever physically wires up an OPCLK.  If one was there it'd be
unavoidable.

> > I see. I wonder what's the best approach in this case. Should that code be
> > removed instead of 'fixed'?

> I'm thinking that's a spot that needs a 'break;' added.

Yes.

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltoMkEACgkQJNaLcl1U
h9Apqgf+J0nzjGBWmBrdQrw3Oij0LLWled8F5vK8DW/8xwLlhyo1NMaCrBzBldoI
1V5ualL+zq8IJTBEZUp4Y8reRsF0xUBZi5hGdyq67j2mU+PVz13NEXRl0L6cddDr
a8stUW107ah26XtHfEBFS+/Pgitkldml4R4TMgLhspZqn9rILrF8JZ0zCmGocqg5
rKIHzYU7D79DDgpIXK3scrkFTQW9rZNqrR9ZdZNiDeHQCLKOv0WRn4P819eM7SrV
fyKuixESDLPHC9BNBd7eIMq4tw03RdvgKMirpwsLIPyzccwXHNAuY8rABgLwRHOE
AJbTIs7Mpl0BacNDNn5BDQdEOopMEQ==
=yaI4
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

--===============2558175337382804349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2558175337382804349==--
