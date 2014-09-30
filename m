From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Allow the codec to work in
	slave mode
Date: Tue, 30 Sep 2014 20:29:12 +0100
Message-ID: <20140930192912.GM4273@sirena.org.uk>
References: <1411082245-25679-1-git-send-email-festevam@gmail.com>
 <20140923015448.GF27755@sirena.org.uk>
 <CAOMZO5BUvZDgY+-VUVENWEoXZS4qFDBKA7ZZLAOzDt-Oawm9tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3776403247937619397=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73DB2260442
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 21:29:29 +0200 (CEST)
In-Reply-To: <CAOMZO5BUvZDgY+-VUVENWEoXZS4qFDBKA7ZZLAOzDt-Oawm9tA@mail.gmail.com>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============3776403247937619397==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vTfKKTivj/mQoluA"
Content-Disposition: inline


--vTfKKTivj/mQoluA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 29, 2014 at 10:17:57AM -0300, Fabio Estevam wrote:
> On Mon, Sep 22, 2014 at 10:54 PM, Mark Brown <broonie@kernel.org> wrote:

> > Are you sure that the configuration that results is valid?  Typically
> > the requirements for MCLK to other clock ratios are very similar for
> > master and slave modes, it's just that it tends to be a lot more obvious
> > when things go wrong in master mode since directly visible clocks tend
> > to go wrong as opposed to performance problems.  Are the dividers that
> > we can't get configuration for purely for generating BCLK/LRCLK in
> > master mode or are they for other things?

> Tested sgtl5000 slave mode with different sampling rates and it plays well.

> Any particular register I should monitor?

Did you just listen or did you measure the performance?

> Sorry, but I guess I did not understand your last question.

I'm really not sure how to simplify it...  clearly we're skipping some
configuration here, what does it do - is it purely for generating BCLK
and LRCLK?

--vTfKKTivj/mQoluA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKwSHAAoJECTWi3JdVIfQd2gH/RK2jEgNoJvMm12xi7w6y7wX
fb+Uft4TBUTf8BwZ62PF2Lkk+qpNS/E93G6i+LQy7LbbOD5/IMLSBAA304KQw94T
eSukJvfuFRk8tPgO61HtvGu8Xuz2DeUNIaqrE19Gt8n7n07MLDUHrsHzi2kUUgIL
2kHVuij0A0zij+idTTN2x9JruYkigaOIO2w5/Aq8mloYZYq9K5od39F0TuWB3i8k
K1qWcORgSqOtNTqATFHdHuwwXIP19g/zMfq/lkpL0v/3+4Wc5Df3ExdBmpgjTt8V
4wfgO69LXL7mUvTJZIAuyjQ8gZrwPZ/45JDf5mWI3c76r1y4TbyvkHtZZlYPmQo=
=O2g7
-----END PGP SIGNATURE-----

--vTfKKTivj/mQoluA--

--===============3776403247937619397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3776403247937619397==--
