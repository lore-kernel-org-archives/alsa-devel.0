From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/31] ASoC: wm0010: Use WARN_ON() instead
	of BUG_ON()
Date: Wed, 6 Nov 2013 10:31:30 +0000
Message-ID: <20131106103130.GN11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-6-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6698228587849295412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E45AA261645
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:31:32 +0100 (CET)
In-Reply-To: <1383673218-18405-6-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6698228587849295412==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ztcJpsdPpsnnlAp8"
Content-Disposition: inline


--ztcJpsdPpsnnlAp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:52PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--ztcJpsdPpsnnlAp8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehp/AAoJELSic+t+oim9YTsP/1QfGSRX3w+iuC/eaqe0yqbM
wg73ncqXMeUvseMenCvlR+40DUC3Uk18f52ejEUZ9z19PMHjWisS+y1A2mW+TZUj
PatpEy+CwvyQoP3nbQwOFsYldYiGJi1vL5AljaO/nrCnygYcmTEyekAI3wVprT3w
jbfoMdPhP+0ZpJfWnjEyZo0ijRqQmm0g1k03S53QjNZLYM4Mjr5KFSkdEhe25fM1
VL28F5Wmig8wa6p0MlRSAZ2yC4/Rhl5ue3tmMhDExPv5WyTHJ99fZb6rE3Lm8sqi
DHWuXSEC8GLt6eFzoK0IjYvaqzSa7EBzsxgGxBbW2w8tfyBezVseOu/be/QU8JqV
WCB7aIG167jB2csY4uG0OFAZetvLfOwuOEJZIywBCd8FUI//c5Y60qdBoR64P3Zw
TNVZXONaTRZDsXL5o9xdVg42r4fZTnexV4kRjruoCS+exzSIIIjHWuX+OUUx2Jrx
Ar8M4HyGfewFF3ZCIE6Y9k4/btg8jKru/bo6r3QAqz+un38k+COB9DndrxtZRoyb
jFVG6eslTix46jIVhz3acC6oY11NbW7DbxPMedKeGdd1sjyRZSL9bl7sBB7urgbR
lEbjFAWfcPRaxUTZCi656xM83slgNoc5KOEg/H2vs048MGwSQ3Hr2yq4zezIgjlG
jT0bbFnzf5gOkh+ZDCYQ
=HSA1
-----END PGP SIGNATURE-----

--ztcJpsdPpsnnlAp8--

--===============6698228587849295412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6698228587849295412==--
