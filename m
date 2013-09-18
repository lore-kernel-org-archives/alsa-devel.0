From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Wed, 18 Sep 2013 18:28:58 +0100
Message-ID: <20130918172858.GE21013@sirena.org.uk>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
 <20130918094158.GL21013@sirena.org.uk>
 <CAOesGMj52_xcKS4q54i_gw_T2xWt=c6rwBtP9Ds2LbytjRuNKQ@mail.gmail.com>
 <20130918153842.GA21013@sirena.org.uk>
 <20130918165334.GA26446@quad.lixom.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2930373973380391096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 66E942610A8
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 19:29:11 +0200 (CEST)
In-Reply-To: <20130918165334.GA26446@quad.lixom.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--===============2930373973380391096==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="34/PV/2fFpU6TJrn"
Content-Disposition: inline


--34/PV/2fFpU6TJrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2013 at 09:53:34AM -0700, Olof Johansson wrote:
> On Wed, Sep 18, 2013 at 04:38:42PM +0100, Mark Brown wrote:

> > In that case you should've also CCed the maintainer address, you should
> > always CC maintainers on patches.

> Sure, will do. But you should also consider using your maintainer address
> for your maintainer work. Linaro will surely be credited for it anyway
> in the oh-so-important statistics. :-)

People like that stuff for marketing outside of the stats and I like
being able to keep personal addresses for that.  TBH it's rarely a
problem, the CC maintainers bit does the right thing.

> > We're supposed to be able to do this sort of stuff without the ifdef
> > noise and have the compiler eliminate unreferenced static symbols
> > automatically, though I can't see how of_match_ptr() actually does this
> > now.  I don't immedately seem to be able to persuade Kconfig to turn
> > off OF to verify though we do have some examples which nobody has
> > complained about...

> The problem doesn't show up when you build the driver as a module, because by
> then the MODULE_DEVICE_TABLE() reference means the table is referenced. But
> when you don't build as a module, MODULE_GENERIC_TABLE() reduces down to
> nothing, thus causing this.

I'd have expected the folks doing the allyesconfig builds to have
complained then...

> Only way to avoid is as I see it is to mark the table __maybe_unused,
> which in this case doesn't look like much of a better option.

> Most other drivers, for example those using pci or of module tables, have
> Kconfig dependencies such that there's no need to ifdef. There are plenty of
> examples of drivers ifdeffing on CONFIG_OF for those tables though.

Yes, you used to have to ifdef everything but there was a thing about
stopping bothering doing that.  The same issue applies to the PM
functions.  It's certainly annoying to have to faff around with the
ifdefs all the time.

ISTR Arnd was telling me about this stuff, CCing him.

--34/PV/2fFpU6TJrn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOeLXAAoJELSic+t+oim9VPgP/R6sSgcAuIjmhIzBjnaDd8+g
pbZwZXg/JkuQkOOwe+lB6I/sv8sCrPFE5oBC5U68T7eHM20o/rE5mbynl0roLJB5
m41IQr9+H3ujYH6OlWjUxVRhefVGm86QmE/ywvp+ykZiMYM/5W2Kem6K+BxQaqfx
Covbl4n/sKLqc14rP8MaVZ7MDbExkX97sD/2Kch65aDSb5IOsQyoAQDsXz16TXx1
l6DWM07efK5KAk325X8NBy1y6PBHUu2pSvyKU+TmhSoZFJwTKS8jFKCkXmMP6QCx
K9fGMgs0uZxnW2bJDn3YpVGxjcUQttIocZj/ofqPtqKj7MaQ651cCDySrCnjCH7/
HmAHuhtktj8Vnx2DppX18qcc2HCyqcdh3E7tEahNQcQ3LbSImMHvQZbvzC5okqof
J3zKpDCk94ECRdwFBZbDg53ZpKsRv307+Mac81RfbLl28AnoUaFwRzmDWYZRKuJo
ciV4nOt+wTo01uBF66JtXio9JTNaCjQxwK9yJMLQgbnAUMWJFj4ptx7PAplQhMDL
tLbumNWddiUU1uJV/SkdI04LyhtP90fkkO/8aCB1mhWnQNBKKiQ5cSW6FPsOe5oP
Fvb+U1AKQKG9cTjiQcMtaWzR9gL0fx7Tj86fnvC+uVsQ/VAQPmjxR2X0xKM9KAeA
SKEQpqrZSJ60phH06oKh
=aL7b
-----END PGP SIGNATURE-----

--34/PV/2fFpU6TJrn--

--===============2930373973380391096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2930373973380391096==--
