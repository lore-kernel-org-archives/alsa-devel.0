From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: wm8971: Use
 system_power_efficient_wq instead of custom workqueue
Date: Wed, 1 Apr 2015 21:28:30 +0100
Message-ID: <20150401202830.GC6023@sirena.org.uk>
References: <1427742293-8588-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5086347862928490148=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 186C7264E9F
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 22:28:42 +0200 (CEST)
In-Reply-To: <1427742293-8588-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5086347862928490148==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2015 at 09:04:45PM +0200, Lars-Peter Clausen wrote:
> The delayed work used by the wm8971 driver to manage the caps charging
> doesn't have any special requirements that would justify using a custom
> workqueue, just use the generic system_power_efficient_wq instead.

Applied all, thanks.

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHFTtAAoJECTWi3JdVIfQKnAH/29n3MiITU1zYCTuve5huS9V
7GtpHLJxX7SgHo7ol/V6SfzzGPein+HwvwEL3xgM9YnTxtrjQssd8a3E2SYZgfWs
szYJJsJaBq7BCguqjwzdnBKx1YEMAY2ti469pJE0VPlRctegyGTnSyaid13kyb1w
yOpOm3hBs31BXl8OUMA/SBhooCsxYtHjQCCQ17oUJ7IxVqOmXVlmqoT8+UaEnjKZ
lPSXVp5dOPNU6BwSAnGJhbD5XfYL/ya/FH5vsZRCpe+dQZbWJ8w1KeSTMFy7BMQy
5WcA+hGl7Z+Nyb1YbHb7AfwE0H+8TaUHzLDl1ggGi7MJqpFDQPankm7brJ8BnkE=
=Axku
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--

--===============5086347862928490148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5086347862928490148==--
