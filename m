From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Asoc: sam9x5_wm8731: depend on ARCH_AT91
 instead of SOC_AT91SAM9X5
Date: Wed, 14 Jan 2015 19:00:00 +0000
Message-ID: <20150114190000.GB3043@sirena.org.uk>
References: <1421152046-20069-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4641981076901503396=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D8464261521
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 20:00:20 +0100 (CET)
In-Reply-To: <1421152046-20069-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4641981076901503396==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2015 at 01:27:26PM +0100, Alexandre Belloni wrote:
> The SOC_AT91SAM9X5 option is going to be removed, only depend on ARCH_AT91 like
> for the other drivers.

Applied, thanks.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtryvAAoJECTWi3JdVIfQpxwH/jiLAJJ0eyk7/jw8sbEpng3d
tBOzl9BLc6HtYksH+YJ5IQTuKGv6YlvnzbXYHTYad9IYymRCgwyyfxGCu4EXUAHP
6BGP+8m1hJmvBwRNwuzbbVSXNFeYUwYUzcNWcSC9jz2HqczS9NsbE79nYEurTlnT
q9chwf5tF9Dpf19efjcsBLOgt9txYytWkkCQUvC3nS2aH3FHthHsbXkGJ8neUfVR
AJpy4jqSHNDm9FJlYvYCibuT4SFVo3UgTLpdAsNrCaxNLBhOOjj4OjqhabE/omrS
AYOR6KFrQgVYoTJBWaSIgTUwV9qmL03KBJQsB40edNvpEFgFTITL9txZUlhxt5g=
=jwo0
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

--===============4641981076901503396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4641981076901503396==--
