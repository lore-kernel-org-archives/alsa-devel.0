From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: mioa701_wm9713: Don't opencode
 CODEC register access
Date: Tue, 4 Nov 2014 11:49:57 +0000
Message-ID: <20141104114957.GN3815@sirena.org.uk>
References: <1415039583-4858-1-git-send-email-lars@metafoo.de>
 <1415039583-4858-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4293591455846531743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 740212605EC
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 12:51:25 +0100 (CET)
In-Reply-To: <1415039583-4858-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4293591455846531743==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JZhpBjp/UIQS9x0q"
Content-Disposition: inline


--JZhpBjp/UIQS9x0q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 07:33:02PM +0100, Lars-Peter Clausen wrote:
> Properly use snd_soc_update_bits() instead of manually calling the CODEC
> driver's read and write callbacks. The later will stop working once the
> wm9713 driver has been converted to regmap.

Applied, thanks.

--JZhpBjp/UIQS9x0q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWL1kAAoJECTWi3JdVIfQOwcH/1/0DHewtku8q4JbRTmr8ihN
MMD7zF7ERHl+lFa9U2QO9TgAyppcFw92dos6McXBK+YMCD5i4P89XqZmC5whvZvJ
eCklzj1QCgiJjeX32Rp2pHLCjVRQGbcGflCDW+jhlwvDmt2E1PHB40Fns50VJ+Xz
gBNXTmVBhkDZGQuGeOnBLqGACxYKjIInndWd7Q502/vrKyQ7jy4JHQ+P77Ltzla8
corhzySYptpLS4BQs+lwcDSZQugtcFp5eF0McslNNKc87WHLyzZbez4p1uvIdxrQ
zXkl5r002fWS1kTuQFSopQM8B3CpmBHoO+TpOLOrpu386fgnSqLpc9yGSvTJYAg=
=1OWN
-----END PGP SIGNATURE-----

--JZhpBjp/UIQS9x0q--

--===============4293591455846531743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4293591455846531743==--
