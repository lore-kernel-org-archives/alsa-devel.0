From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/12] ASoC: SOF: Add DSP firmware trace
	event support
Date: Tue, 4 Sep 2018 16:46:39 +0100
Message-ID: <20180904154639.GG12993@sirena.org.uk>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
 <20180831151910.16122-8-liam.r.girdwood@linux.intel.com>
 <20180903162503.GS10302@sirena.org.uk>
 <579fc5f7d26a8cba21fe36eb4ff6bb4a1a0d8496.camel@linux.intel.com>
 <20180904150333.GF12993@sirena.org.uk>
 <fe9e199c8e9c3f688cc84393b85e1a390ace3c7b.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0950907455898306157=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 61A8B2676C6
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 17:46:41 +0200 (CEST)
In-Reply-To: <fe9e199c8e9c3f688cc84393b85e1a390ace3c7b.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0950907455898306157==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 04:28:49PM +0100, Liam Girdwood wrote:
> On Tue, 2018-09-04 at 16:03 +0100, Mark Brown wrote:

> > I was thinking the code could read it like it's doing now and then just
> > have a trace event to dump it into the core trace infrastructure as it
> > reads things in.

> Most of the data is binary atm, so we were decoding in userspace. Any objection
> to decoding in the kernel as different trace events ?

I wouldn't think so.

The way the trace stuff works is that the writer dumps blocks of data
into the trace buffer in raw binary form in a structured block tagged
with the event type and then later on when something reads out the
buffer they can be formatted as desired, including things like hex dumps
(IIRC there's facilities to just get the raw buffer entries too, I've
only ever used the human readable interface myself, writing software is
hard).  This gives very fast writes which is really nice for anything
performance sensitive and means you can leave trace on a lot more than
you would otherwise.  I'd guess if you were decoding it'd just be
splitting the buffer up into per message chunks.

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOqN4ACgkQJNaLcl1U
h9BzEwgAgB6DKcDcEZXfbP8dFl5nmrpL0LlgeByrdwnkGfHZ5idXcNA3B/vK9oqt
/UyMbxzI8t4gJoH1g0sCch8MJ2tUKNdeBziil/3IBMudBbAymRa6lsHo4BoMscJT
IBZXpHf/CbvPO8wzO0Q1K7VXEU6JGfIq2khZ+9VyCC9dZ5qyD4yJSx8dOLcFnYwM
qVQrcmyjvaRWJ9AY4BYQdi3K38oDzAhOHSaUujGJzK2Y/e9Q5bzZbtCGFYIiCO1h
dr51kOY1w4LQuY6mi7Z1kTaN29L2p7yvEz9DLoG9QrOsTXptMGEqggI3pTSa5M0A
y/Ihz0nVk0U2ihj9bG/WDmiLlOL7Fw==
=2LGw
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--

--===============0950907455898306157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0950907455898306157==--
