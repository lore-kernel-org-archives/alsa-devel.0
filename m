From: Mark Brown <broonie@kernel.org>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Tue, 12 Aug 2014 19:20:29 +0100
Message-ID: <20140812182029.GX17528@sirena.org.uk>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <53E9D383.5060103@metafoo.de>
 <CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>
 <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
 <20140812115755.GO17528@sirena.org.uk>
 <CAKON4OyOL2asou5NvL0crcAy=wYdguBYpc7w+x0xcUUf93FxUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7153751895884838199=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4985726529F
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 20:20:38 +0200 (CEST)
In-Reply-To: <CAKON4OyOL2asou5NvL0crcAy=wYdguBYpc7w+x0xcUUf93FxUw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============7153751895884838199==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s4SVo4+dQCTUzKvM"
Content-Disposition: inline


--s4SVo4+dQCTUzKvM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 12, 2014 at 08:45:22AM -0400, jonsmirl@gmail.com wrote:
> On Tue, Aug 12, 2014 at 7:57 AM, Mark Brown <broonie@kernel.org> wrote:

> > Yes, as has been said several times now it's the responsibility of the
> > machine driver to coordinate clocking in the card so if you want to use

> I hear this, but I'm conflicted about putting a generic capability
> into the machine driver.

It's a generic machine driver so having generic code in there seems
reasonable.

> 1) Are sysclk and mclk the same thing? Inside of simple-card they seem
> to be but I can possibly see arguments that they aren't.

Probably in the context of systems simple enough to use simple-card.

> 2) Should sysclk for the cpu-dai and codec-dai be set independently?
> In simple-card they can be set to conflicting values on the two nodes
> in the DTS. Should sysclk be a single property for the machine?

No, clocks might be at different rates for different devices.  One
device might divide down the clock to the other.

> 3) If sysclk is defined by a phandle to a clock, how should clock
> accuracy be handled? For example in my CPU the best clock that can be
> made is about 0.01% less than what it should be. If you take that
> frequency number and start doing integer division on it you won't get
> the expect results because of truncation effects. Diving by 44100
> gives 511.95 which truncates to 511 instead of 512.

I'm not sure it's worth worrying about systems that can't generate
accurate clocks at this point, but perhaps someone will think of
something sensible to do.

> 4) If the sysclk is going to change based on the music, should it just
> flip between 22.5/24.5 or should it use the FS multiplier in the
> simple DTS and always be set to FS*music? For example FS=512 so for
> 44100 it is set to 22.5Mhz and 8000 it is set to 4Mhz.

If a fixed multiplier is set I'd expect to see it observed; obviously a
device may be constrained in what it can actually use though and a fixed
multiplier might not be the best configuration.

> 5) What should the syntax for this look like in simple?

It really depends what the "this" is; try to think of something
tasteful.

> 6) Longer term set-sysclk could be replaced by using phandles for the
> clock and then clk notifiers in the components to listen for it being
> changed. That would remove this problem of having multiple sysclks in
> the system and the DTS syntax for identifying them.

> So in my case I expose a MCLK clk. sgtl5000 codec references that
> clock with a phandle. As the cpu-dai looks at the music it changes the
> rate on MCLK. Codec gets notified of that change (if it is listening)
> and can act on it.

OK, but that's not meaningfully different to just having the machine
driver call set_sysclk() and only works if the best way to change the
clock rate is to change the clocking inside the CPU which isn't going
to be the case for all systems.  That's the hard part, we have to be
able to scale up to handling it.

--s4SVo4+dQCTUzKvM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6lrqAAoJELSic+t+oim9pHYQAJ3lrpJf03lFJRLTCgl133dO
96ojSEsxW4JhT7W35A8VvZiPI5YTrrF3+TQR63ukC87clLePdeUsBB292RwHkk1U
aMR6jGB3uoBxlWhZrR/nvFwcL2JaM1owQCMcdXNdH7TLo97laGJvVB3eUK3/iuya
knfsuNImqIlEnl2orD4lDJD0LWb80mjR07ZNC4v+SrVSRALL+oL3vYezunn4X/f2
pHC4n8y+63pqvhAt+2Ljb2TxKlrosx0Pg4fOHK/3dis/p09gyx+myOYijF9aA+VT
zDOkKE0ffu86k/dnZ0JumoygMVQZfxGn2a6EmqJBNr0bJ5NRYXLPpAK3jaGsY5hA
FO3wjS0jaVbqNoovM0LVO3V6OQYqMcwjjsrnS9BUqIMFiBMJt37INeUYV31XWpCA
Too8eD+4S15cOLGgoapMnNaxlrWBQAoPlQI+inat+Uod3xWNtTkmq8oQb1dp/Sa2
SVB+ZanM0i7Il/gTcYJxwackXo7GWunqhjVswE9RP4v/MCsqpXABjR5VSjiJsReb
w9zAnhD4GOC1DQw6tvmzwPMafA/dLYeLd7iQBn3zqj30OJhIr8EOX295EZOqnK7N
LUxi+zpfnFd/YSHbx82vLtDpK3LPrZtBK+FoQSDNoqyD3t5R+6iY7Gcf0J3ss9E1
CE+j0zGbxg1kfrldEzeF
=QehS
-----END PGP SIGNATURE-----

--s4SVo4+dQCTUzKvM--

--===============7153751895884838199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7153751895884838199==--
