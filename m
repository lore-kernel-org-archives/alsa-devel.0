From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Allow the codec to work in
 slave mode
Date: Thu, 2 Oct 2014 18:58:56 +0100
Message-ID: <20141002175856.GY4273@sirena.org.uk>
References: <1411082245-25679-1-git-send-email-festevam@gmail.com>
 <20140923015448.GF27755@sirena.org.uk>
 <CAOMZO5BUvZDgY+-VUVENWEoXZS4qFDBKA7ZZLAOzDt-Oawm9tA@mail.gmail.com>
 <20140930192912.GM4273@sirena.org.uk>
 <CAOf5uwmFZcKvmSHWLjhu5OMuM=ZUOT2KXhwKdcZQSWOuhqdDsw@mail.gmail.com>
 <20141001182754.GL4273@sirena.org.uk>
 <CAOMZO5A-wd-XcjNdQbz5RGiC6zx+RLGzCBmbUurMvsHqNUTvgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4662047318733923487=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A49C62604EE
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 19:59:14 +0200 (CEST)
In-Reply-To: <CAOMZO5A-wd-XcjNdQbz5RGiC6zx+RLGzCBmbUurMvsHqNUTvgw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============4662047318733923487==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WUr/cuZz0HKWk6w/"
Content-Disposition: inline


--WUr/cuZz0HKWk6w/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 01, 2014 at 03:44:59PM -0300, Fabio Estevam wrote:
> On Wed, Oct 1, 2014 at 3:27 PM, Mark Brown <broonie@kernel.org> wrote:

> > I'm sorry but I can't parse what you're saying terribly clearly - please
> > bear in mind that I don't know anything about this device, that's one of
> > the reasons I'm having to ask questions here.  If the configuration that
> > is being skipped is not about generating BCLK and LRCLK then it seems
> > like it's going to be wanted in slave mode as well as master.

> This patch does not skip any configuration. It just remove the error
> case for sgtl5000 in slave mode.

> Not sure why the error case was there in the first place, as I think
> sgtl5000 slave mode has never been tested before.

The comment says "if mclk not satisfy the divider, use pll" and then
does in fact skip configuring the PLL (or at least a register change
which looks like it does that).  Looking at the code it seems like
there's a requirement for MCLK to be one of the standard multiples of
the sample rate.

--WUr/cuZz0HKWk6w/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULZJfAAoJECTWi3JdVIfQF5UH/2lxzhvxvUkz0c77QWQ7Fohq
/HQ2xWD1FKniDpk+xxe8v8YZnIfJLXpgxtGE3Pd+hVI2JldPIyCldpuxRuQVKTvT
ZotMBpSorZ948L1qQ7j0yXoQUxCz2qy7XdqBSM97ZXXvnVaDT1+XQManCDN4yikG
db/LUZyUnQF0zCXD8YaEvUpTRdxYvhY0JaKv3qijZu8o4GpexuvYNSUmmSFhDIhe
CosyddS6HGwlLxayfon4Aaspfl+jfle0No3vvwXEVio556CxaBbms0X1bR8nVl+h
pjBKk4J+ibMak1rKuI/y/iX79ns+ZH/v5MySAmQMQ4fJIKDGhj0ljJGcZuim9fI=
=BY9f
-----END PGP SIGNATURE-----

--WUr/cuZz0HKWk6w/--

--===============4662047318733923487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4662047318733923487==--
