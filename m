From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 15/47] ASoC: remove blackfin drivers
Date: Wed, 14 Mar 2018 09:12:12 -0700
Message-ID: <20180314161212.GS2186@sirena.org.uk>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-16-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3936801622793390732=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E7F126718B
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 17:12:23 +0100 (CET)
In-Reply-To: <20180314153603.3127932-16-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3936801622793390732==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9wW3yB/H9ZmnRBtb"
Content-Disposition: inline


--9wW3yB/H9ZmnRBtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2018 at 04:35:28PM +0100, Arnd Bergmann wrote:

> The blackfin architecture is getting removed, so the ASoC drivers
> are all obsolete as well.

This is going to cause loads of conflicts due to the ASoC platform to
component refactoring - can you send me something that I can git am
directly against my -next please, it seems better to apply it there so
that nobody needs to see the conflicts?

--9wW3yB/H9ZmnRBtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqpSdkACgkQJNaLcl1U
h9DaIwf/Tv8pWYVLPMnlGBNdlg5uS4LTtoickmYdhGauOa2y7kLG1t17zEDR7pvb
SvDAtQ/nvUYSF5TJ/It7LN47nus4ZDWBndvxTuEDTYA8un6k0LRN/Hn6noRZE0ka
tKvtLoFDD1T/Ul9KcCqTuUvz+YgIAPMNeFZxemt0A0cHAHioPPJUDUFPVlq5YUCj
GHdmBScRazZuW+ZV4pbziqX81DNzW1uTJOTAaGCqO0OpG1ytuQHAcFNkGRb8t7Mn
iQgxEJcuQo4WyaeiD6Vb3vvvjBUcc88iRQDAds8PdsUhXg7ke7vwiAY1LLfBXt7f
uMdXKFH1sWKYRsrqDquP4ERX8oPEGA==
=hEr4
-----END PGP SIGNATURE-----

--9wW3yB/H9ZmnRBtb--

--===============3936801622793390732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3936801622793390732==--
