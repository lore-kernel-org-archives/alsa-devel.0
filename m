From: Mark Brown <broonie@kernel.org>
Subject: Re: How to correct params_format on DPCM ?
Date: Fri, 10 Apr 2015 16:43:38 +0100
Message-ID: <20150410154338.GL6023@sirena.org.uk>
References: <87twwsttp5.wl%kuninori.morimoto.gx@renesas.com>
 <20150408180118.GG6023@sirena.org.uk>
 <87a8yg8nko.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3894288325046204040=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 18DC2260661
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 17:43:46 +0200 (CEST)
In-Reply-To: <87a8yg8nko.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============3894288325046204040==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TYHuJK3gTQZFbmpt"
Content-Disposition: inline


--TYHuJK3gTQZFbmpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 10, 2015 at 07:12:28AM +0000, Kuninori Morimoto wrote:

> > I'm not sure what exactly was intended here but this seems to need
> > fixing in the core - I think the assumption in the DPCM code is that
> > the sort of hardware that uses it will have rewriting support that makes
> > the back end constraints irrelevant to the front end.  I think what we
> > want here is some way to signal to the framework that the front end
> > constraints aren't used and it should use the back end ones instead -
> > perhaps just omit the constraints that aren't rewritten and then have
> > the framework take those from the backend instead.

> Now I'm debuging about this issue, but it is very complex.
> I need your help. where should I check/debug ?

I think you're going to need to implement some new code.

> Which function/method controls format ?
> I guess it is doning some kind of

> 	format = cpu->formats & codec->formats;

> DPCM case need to care about FE/BE, and maybe this is lost item.

> 	format = fe_cpu->formats & fe_codec->formats &
> 	         be_cpu->formats & be_codec->formats;

> I guess it is done before hw_param() (?),
> or snd_soc_instantiate_card() timing. but I couldn't find it.
> It is very confusable/complex. which function is doing this ?

My point is that it's not happening and you're going to need to add that
support.  It's slightly more complex than your picture as most things
that do DPCM can rewrite the format so we normally don't want to
constrain with the back end constraints.  Like I said in my eariler
reply I think we want to change things so that if there's no front end
constraint we take the back end one instead.

--TYHuJK3gTQZFbmpt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJ++pAAoJECTWi3JdVIfQzUQH/jwNLKE2shPtrxDpz6B6s/Oh
bAEv9TjBgSbPdIXPQUscZA9F9nWPjN1I5M4uqZboqxGcp3MU38+3I9ztg0UhZ/8o
Pa4a6nEZQ0WhdG23pmIXhU/NLnukaP7aAqeps0k96Ay4Ake5yIejsedVHdnpUriI
itntsUu254y9LAzjGi2cazHway8GjSsdNAzPHL8KtKE/dDpeh/e8q/8vL+77GytP
QsVcD6bb547RrXzybnZF8WFLpcr1JxJEJUmnsucK7CvgqSjJQ7L7yJiqfWCwP3Pk
jcScC+PzQETCPoROD3Uu8QocUjcA6ZupCxaIk5wf67HloLz8GefYQYyduJaZDg8=
=D7u3
-----END PGP SIGNATURE-----

--TYHuJK3gTQZFbmpt--

--===============3894288325046204040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3894288325046204040==--
