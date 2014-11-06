From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: rsnd: Add Volume Ramp support
Date: Thu, 6 Nov 2014 16:11:06 +0000
Message-ID: <20141106161106.GP8509@sirena.org.uk>
References: <8761fc7vpx.wl%kuninori.morimoto.gx@gmail.com>
 <87tx2w6h2r.wl%kuninori.morimoto.gx@gmail.com>
 <20141028223814.GM18557@sirena.org.uk>
 <87oasviuw0.wl%kuninori.morimoto.gx@gmail.com>
 <20141029225659.GS18557@sirena.org.uk>
 <87y4ryxuxs.wl%kuninori.morimoto.gx@gmail.com>
 <20141031115111.GM18557@sirena.org.uk>
 <871tpjaju6.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7347217100135074049=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC7B42652AA
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 17:11:35 +0100 (CET)
In-Reply-To: <871tpjaju6.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============7347217100135074049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QCvc+0a4DZLbIBWe"
Content-Disposition: inline


--QCvc+0a4DZLbIBWe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 04:30:00PM -0800, Kuninori Morimoto wrote:
> > > /*
> > >  * target volume for "start" is Mute.
> > >  * volume X x 0 time = volume 0
> > >  */
> > > amixer set "DVC Out Ramp" 0%		// Mute as default

> > I'm sorry, this explanation still isn't at all clear to me.  Can you
> > explain it in words please?

> Our DVC Volume Ramp is doing "Normal volume" x "Volume scale".
> "Volume scale" exchange Volume in "X db / Y step" (= speed).
> Our "Volume Ramp" exchange this "Volume scale" in "X db / Y step" speed.

> "Normal Volume" x 0 => "Normal Volume" x 1

> Does this good answer for you ?

OK, that's what I'd thought that the control should be doing based on
the naming but the examples you were showing were confusing.  Let me
take a look at the new version you posted...

--QCvc+0a4DZLbIBWe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW52ZAAoJECTWi3JdVIfQ6swH/RzjfK2Z3Jzk/iY3A5Id+EPg
QZwn/QRnPkdl7LKurb45Si5O/FaE5yf9Kbi9p5b/uwEQdAO33+ZuZvMYVJB6yz/9
BtW/NMfVJGHA5j1fNlh4PCombe6xBhM2CYvbgh7yvvCGHTyASTZVv7kLM3lnEkIA
qNYcUh/rGCrroEp4Z/CY3NUGnNN5IxEdzXjU/fK7RW2XCrR9uA8pKq1X6kPFRASJ
EL0P2V/dKS3tsv3ihyPwHvXOAFcNFXb8q3e3E7u/iXhrVVAYgGoKZqaZkIGUskw1
5vSGWQRuDAqcdzyZzbyiiijNTMFTq91ySucBgGXV9Qdbe4+JNYcyqR4urgtKqYM=
=iTRG
-----END PGP SIGNATURE-----

--QCvc+0a4DZLbIBWe--

--===============7347217100135074049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7347217100135074049==--
