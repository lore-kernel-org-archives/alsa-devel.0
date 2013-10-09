From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: pcm: Trigger all commands on error
Date: Wed, 9 Oct 2013 15:59:17 +0100
Message-ID: <20131009145917.GN21581@sirena.org.uk>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
 <20131008094839.GB19005@pengutronix.de>
 <20131008104457.GA21581@sirena.org.uk>
 <20131009130553.GD19005@pengutronix.de>
 <20131009132004.GL21581@sirena.org.uk>
 <20131009141242.GE19005@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0836673370725589355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CA6D52654D6
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 16:59:23 +0200 (CEST)
In-Reply-To: <20131009141242.GE19005@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: kernel@pengutronix.de, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0836673370725589355==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lpu0notPcOSkplGy"
Content-Disposition: inline


--lpu0notPcOSkplGy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2013 at 04:12:42PM +0200, Markus Pargmann wrote:
> On Wed, Oct 09, 2013 at 02:20:04PM +0100, Mark Brown wrote:

> > I'm not sure what you mean here.  How would the error be handled without
> > calling _STOP?

> The START error should be handled in mxs_saif and there shouldn't be a
> _STOP call for mxs_saif_trigger afterwards to handle the failed START.

How would the framework know that the error has been handled - what
tells it that the error returned is for an error that has been handled
as opposed to an error that has not been handled?

--lpu0notPcOSkplGy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVW9CAAoJELSic+t+oim9DG4P/jEmJBGwBBrEkzHg9XgUhACE
7hZUufjtT4iEgfE2racxkrYE4lv0gNxzcxDJtTydZI6K2wOYC56A/JLsG6DCj+As
YTLag2m5NY5CidH0pYfgPiA1ttuuTUJ0cEfI5O0SOVTdFQ4rniBPAvYqpUXvFguL
V3VE5AKBQ5mbT8BGnWUxOs0RuvOfwiXQjdRYNFQqg0T5DUCaRruzNivHRRfUSh8c
hI21qgKlSnja8v6lQnb4ZrIC9BX8+KuEh5qFCwwp4EXhChVcUI0Li2Q2VlqhVJxj
pi+SfZ+Z87pTluHvGgJ100IObSxIo/TRukH4ZtQM0sPtUGsF4iRkiuJTqsyEEa5Z
kZR+bNyNtRrCkX8/hG0wi2bdkRKAIc0Q1yOM3qaW/WHLuLGVc4S9u/g5Y/0+Y1nR
TZKb8qe93cyKot3cI1gutfSWsFpTKKz8yenApW9nhtFGwDeFjb6DIVRaOimBfgTo
SelSx9UB5D3lPBJ7oqm5wXc0+lbRpW+KabxzoNEdpIAi4RuAGXksVbaF7WwMTp7M
bbBFkM73Sddjk9XToL5cHz9dqC6TUFPSqcazymjavzbS9SY+3pOXu/AnVZrgtk8j
6EqTQDZstgN/3hit1SooPTl2xU8hAolR5QdRsiY+eEN+1IyyNYICVQ8pAStL83Os
fIgNoa/0N/ZKqbiJaRKu
=er1n
-----END PGP SIGNATURE-----

--lpu0notPcOSkplGy--

--===============0836673370725589355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0836673370725589355==--
