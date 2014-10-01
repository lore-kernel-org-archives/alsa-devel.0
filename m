From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Allow the codec to work in
 slave mode
Date: Wed, 1 Oct 2014 19:27:54 +0100
Message-ID: <20141001182754.GL4273@sirena.org.uk>
References: <1411082245-25679-1-git-send-email-festevam@gmail.com>
 <20140923015448.GF27755@sirena.org.uk>
 <CAOMZO5BUvZDgY+-VUVENWEoXZS4qFDBKA7ZZLAOzDt-Oawm9tA@mail.gmail.com>
 <20140930192912.GM4273@sirena.org.uk>
 <CAOf5uwmFZcKvmSHWLjhu5OMuM=ZUOT2KXhwKdcZQSWOuhqdDsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2112924108260206982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B6CC2604CE
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 20:28:03 +0200 (CEST)
In-Reply-To: <CAOf5uwmFZcKvmSHWLjhu5OMuM=ZUOT2KXhwKdcZQSWOuhqdDsw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============2112924108260206982==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0FAxone1iWZ10Obo"
Content-Disposition: inline


--0FAxone1iWZ10Obo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 30, 2014 at 09:38:21PM +0200, Michael Trimarchi wrote:
> On Tue, Sep 30, 2014 at 9:29 PM, Mark Brown <broonie@kernel.org> wrote:

> >> Any particular register I should monitor?

> > Did you just listen or did you measure the performance?

> >> Sorry, but I guess I did not understand your last question.

> > I'm really not sure how to simplify it...  clearly we're skipping some
> > configuration here, what does it do - is it purely for generating BCLK
> > and LRCLK?

> Are you talking about clock_in and sigma-delta? So no  the bclk and lrclk but
> the clkin of the codec.

I'm sorry but I can't parse what you're saying terribly clearly - please
bear in mind that I don't know anything about this device, that's one of
the reasons I'm having to ask questions here.  If the configuration that
is being skipped is not about generating BCLK and LRCLK then it seems
like it's going to be wanted in slave mode as well as master.

--0FAxone1iWZ10Obo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULEeqAAoJECTWi3JdVIfQBeEH/3B0QNWOO8ZypfflX6SMFlOF
p0fMsuyz/xvVdagG4T8bzr2I5JgQB0a3Hq1M0tvwpfh45bhOIkWuN622pTiMWt8p
nT5iy0c037B9q1x2bB8cka4gXpnhvECclhrApyCRU6AykDZygFRbFJmg09HgIv1s
GGj6e7xV9lFIS+j2G4+RUXdDAzzmDaGKvZnh02QiucQD9ZrfrW/Zo/wKf4xroMNN
bDq//Rv0NDHZ7jqK5WOjpF0CMw9m4yx7Wte4OP/kSD4lzfGV8LGWyoBA7tLOZIEh
ajcpwzkSQBv0mX75yIvwRjqJgekRKW+nC1YjF7tfvDc9IXusYiNqNe/VSWJkMMk=
=artK
-----END PGP SIGNATURE-----

--0FAxone1iWZ10Obo--

--===============2112924108260206982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2112924108260206982==--
