From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8731: initialize the hardware when
 loading the codec driver
Date: Fri, 5 Jun 2015 19:27:46 +0100
Message-ID: <20150605182746.GF14071@sirena.org.uk>
References: <20150603131926.eba497d0b22010838fb094f4@intel.com>
 <20150605162546.GB32730@opensource.wolfsonmicro.com>
 <20150605112026.5ec1809046fdd1817691ce05@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1065988527001478414=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C71BB2668DA
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 20:27:56 +0200 (CEST)
In-Reply-To: <20150605112026.5ec1809046fdd1817691ce05@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <sergey.kiselev@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============1065988527001478414==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iDVed5OELLBB+kAD"
Content-Disposition: inline


--iDVed5OELLBB+kAD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2015 at 11:20:26AM -0700, Sergey Kiselev wrote:
> Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:
> > On Wed, Jun 03, 2015 at 01:19:26PM -0700, Sergey Kiselev wrote:

> > >  	/* Regulators will have been enabled by bias management */

> > This comment needs an update because this function is only called
> > from the bus probe so no bias management will have been called
> > yet. Basically we are powering down here after probe is complete
> > and the bias management will power us up again.

> I think that's what the comment says (future perfect tense?!). I can
> rephrase it with something simpler like "regulators will be enabled by
> bias management". English is not my mother tongue, and I appreciate any
> corrections. :-)

Yes, will be is better - it binds "will (have been)", that is "it will
at this time be the case that the regulators have been enabled".

--iDVed5OELLBB+kAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVceohAAoJECTWi3JdVIfQ744H/1/7s2ElXh/tVAtRaqkxyaHK
M0MLfYNFryCODk1qS6uU2llnZ2gkh4sN8F1QWHeOpxKBHjPa4jkemNgRh92cFF6a
dsxsZwNtNG5jhyn2ABeNsgPtPnBdCmbEokQhGlaCfwc6P5JEKEvL+Nw2u0CGUo9e
dqErGpt9t8MxSWQXIEA/9iKHpBWn46DRp3b/HwpYnVxD32kI5pWib2IPaLgJhYb8
tFiIEqOx3B6NtPML8ODtdE2KznCw2IfMGc1nSrtQUIL2OkLKVTafQGqLA5dPh0DU
g2I+COA5n+qtmWtHF6huYwSNYmXFtBH/OVlp/Yw7XKYkLO5CvKgWvXHNgZW4kC8=
=NokY
-----END PGP SIGNATURE-----

--iDVed5OELLBB+kAD--

--===============1065988527001478414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1065988527001478414==--
