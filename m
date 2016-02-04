From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/11] ASoC: Intel: Skylake: Fix delay wrap
	condition
Date: Thu, 4 Feb 2016 11:24:36 +0000
Message-ID: <20160204112436.GM4455@sirena.org.uk>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
 <1454502594-21700-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0598957360614452524=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87EFF261583
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 12:24:44 +0100 (CET)
In-Reply-To: <1454502594-21700-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Dharageswari.R" <dharageswari.r@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0598957360614452524==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBMNUjqROSlRgKnE"
Content-Disposition: inline


--gBMNUjqROSlRgKnE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 03, 2016 at 05:59:45PM +0530, Vinod Koul wrote:

> +	delay = (hstream->bufsize == delay) ? 0 : delay;

Please don't abuse the ternery operator, if you're not inserting it into
the middle of another expression there's no reason not to use a normal
if statement.

--gBMNUjqROSlRgKnE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWszTzAAoJECTWi3JdVIfQtDEIAIEXH6V7X+VTxkD8tF7dh3EY
O261Whty7xWwYWptMuBMRUpCabeT734CqXT1zL2As1Tem080iOGtfJQvX+GkUdDk
bynUwc0yRcNh9dUB/FAZf63ei3LRIQXFboE/WZoyqX49bB08EHA8/QkRmYi9miTH
prrmqdTFHvmsvkZEsevvU2S7oOynrxNaDGdIFXgWlqhG5Cx2uJVGB93Bt+kbyrEW
v6ZnaSKAE5L7RyeB5YHPWkrIU2NlvrmFcXNGUb8TmzUIzjobM+CzrUAmmOS22zry
A7NbTOU3ydSjZGVdo/JxASrKlT4cFbxHEfpWBGDm4mm/HlpMbHfomsW8QBLFVxM=
=CqW7
-----END PGP SIGNATURE-----

--gBMNUjqROSlRgKnE--

--===============0598957360614452524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0598957360614452524==--
