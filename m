From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S
	bindings
Date: Tue, 11 Apr 2017 21:19:50 +0100
Message-ID: <20170411201950.37ef4qpiefhengjn@sirena.org.uk>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <CAL_Jsq+bsh8Byow4poT7cdpLY_skb7QxbzkAmj4q7Cf6Z88GWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4381782170080685463=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E44D26684C
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 22:20:12 +0200 (CEST)
In-Reply-To: <CAL_Jsq+bsh8Byow4poT7cdpLY_skb7QxbzkAmj4q7Cf6Z88GWA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, olivier moysan <olivier.moysan@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: alsa-devel@alsa-project.org


--===============4381782170080685463==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xacb7rhtzkaf6p74"
Content-Disposition: inline


--xacb7rhtzkaf6p74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 11, 2017 at 11:02:57AM -0500, Rob Herring wrote:
> On Tue, Apr 11, 2017 at 9:32 AM, Mark Brown <broonie@kernel.org> wrote:

> > The graph card is blocked on your review...

> Maybe if there were more reviewers it would move faster. I don't know
> ASoC that well.

The times I've looked at it recently it's been stuck in DT style issues
rather than anything substantially ASoC related, as far as I can tell
the binding is essentially empty from an ASoC point of view and
inherited from the of_graph binding.  There's bits in that are a bit
random like specifically listing the CPU DAIs and only them but that
just looks like one of these random DT things that's predetermined.  I
really can't see anything at all in there to review from an ASoC point
of view, I've applied the changes that don't seem blocked on the
binding.  If there's something you're looking for then please say...

We never seem to make any progress on the generic changes in drivers/of at
the start of the series either...

> > I'm also not clear how
> > without something like this we'd be able to identify a specific DAI
> > within a device if we don't have a way of identifying them.

> Isn't that what the graph does? "dais" points to a list of ports which
> are the specific DAIs whether there are multiple ones in a single
> device or multiple devices with a single DAI each.

But the ports can still have indexes AFAICT (the examples show port@0,
port@1 and so on) so we still need to define what those indexes mean
which is what this is doing?

--xacb7rhtzkaf6p74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljtOmYACgkQJNaLcl1U
h9B5OQf7B9wNcudZtBplNLf1XRNZi7DFyY4DCG+5G4YCqxk16xgA9osL0lUiOTy3
lAsejRSnnkn/lH+Ii6Dji784DoUw4P1PhOTcJHcXUdbBShreBPTvC4heIbXy+waF
cZuXsLxjC7iQGWUU9fCxm7YNYnaME1NKZPjGb7Pcy8LQAp5WYu0k2E7OxZbWg77f
6rmUNbEWBPBU2qI+ykibDGs+5iBZh/vMdp/AapvwKBoS3wjpa7VasK+P7axm7F+U
YZaiVHsm9iNIZEu5qcXaVC8HzQCm0NQXG5C3FMSqMGquCcPct/Q0RQRW2QtitZO0
oXijSKpN2MvhHcMSRx+6HHQaxdAnYg==
=uZV/
-----END PGP SIGNATURE-----

--xacb7rhtzkaf6p74--

--===============4381782170080685463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4381782170080685463==--
