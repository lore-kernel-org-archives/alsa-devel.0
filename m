From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/2] Add snd_card_disconnect_sync()
	helper
Date: Fri, 13 Oct 2017 18:11:50 +0100
Message-ID: <20171013171150.fcpwiaj5issdgmym@sirena.co.uk>
References: <20171011101618.8736-1-tiwai@suse.de>
 <87fuanv70u.wl%kuninori.morimoto.gx@renesas.com>
 <s5hfuano5k0.wl-tiwai@suse.de>
 <87efq7v2qf.wl%kuninori.morimoto.gx@renesas.com>
 <s5hh8v3pelc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5803873725511566859=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 01EF6266E90
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 19:11:55 +0200 (CEST)
In-Reply-To: <s5hh8v3pelc.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============5803873725511566859==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jg76ql2oldnyrocj"
Content-Disposition: inline


--jg76ql2oldnyrocj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2017 at 11:43:59AM +0200, Takashi Iwai wrote:
> Kuninori Morimoto wrote:

> > My environment now is I'm using DPCM.
> > 	FE : rsnd
> > 	FE : rsnd
> > 	BE : ak4613

> > 1st issue is that kernel need below patch.
> > I guess BE is using dummy driver, and it doesn't have ops(?).
> > If this is needed, I can post it.

> No, this can't be right.  Every PCM implementation mandates the
> presence of a trigger callback.  It's a must.  If a fix needed, it has
> to be fixed in the driver side.

I suspect this is a DPCM framework thing - when the paths are joined up
at runtime there's going to be at least one trigger in there but with
DPCM it's most likely going to be in the front end, the back end DMA is
often going to be transparent to the system and so not have a trigger.
However if you just iterate over all the PCMs you'll see the decomposed
front and back end links with their dummies in there.  Not sure what the
fix is here, probably we need to be hiding the back end links more from
the ALSA core.

Liam?

--jg76ql2oldnyrocj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlng89UACgkQJNaLcl1U
h9CMoAf/diWi4CCpA53NBz9B4pFmfDPrwANcYmBLlDUEyTsVrrbCKJairhoi/SM5
yabrmX+Le22vkCnoYiSywZMEDz6+MneJHgEQD3pbpFPj75gpDKQv8O999ejZJij1
ebHQQooWLMLepIAF/kb4MEJLhRsUZq5R33CJScKh3hZAGHgUhmfFDNqp9BJratKn
qg8Zl8fGg/uCRPlKVc9eV2eugdjg0pPKWJmtH/mfGJTXx29+gIlR/kB2fOLnYQ8y
gEli2r4yJYNlkmcWFyvirKflWfAW1j0x312z4ylMLvQt4kK+5FyZPLt6/O+SHHrv
Mw3V0ztkI/3xHdzlES7kWixbtl/jIQ==
=3q1/
-----END PGP SIGNATURE-----

--jg76ql2oldnyrocj--

--===============5803873725511566859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5803873725511566859==--
