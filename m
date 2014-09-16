From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 02/10] ASoC: Intel: mrfld: add bytes
 control for modules
Date: Tue, 16 Sep 2014 11:50:52 -0700
Message-ID: <20140916185052.GY7960@sirena.org.uk>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1627254805985343928=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 58107261A7F
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 20:51:01 +0200 (CEST)
In-Reply-To: <1410255693-6958-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1627254805985343928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ms171w63QQ5R/kt"
Content-Disposition: inline


--3ms171w63QQ5R/kt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 03:11:25PM +0530, Subhransu S. Prusty wrote:

> +	/*bc->max includes sizeof algos + length field*/
> +	len = sizeof(cmd->dst) + sizeof(cmd->command_id) + bc->max;

Throughout this patch you're using this unusual comment style with no
spaces around the /* and */.  As previously requested please do try to
follow normal kernel coding styles.

--3ms171w63QQ5R/kt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGIaLAAoJECTWi3JdVIfQgEUH/jf1B6o2lnPOWmpjxugaEHpZ
we6IdimO0aIjnK9xwUyx65jnJ+tTMrI98uXX9rsYcTrkOUJPuayxZhLbkuggJ4MR
ssKDCaOONZUaasC5PN3hEQS+pI5tBHbeu8bIBiPexNJRd1XPzi+uYpntEq5JR5RE
GNhzFvfBjymWMPmdL73JHBaItVsEMUiCOJLlGdCXa7Y0maol7QzPlsPws5Ystjds
Gw0K0Ds0r0oIOQKpZDnFXowfxrCruEU0a97a3mwAut6emqJquJVlQ9S1E7IObF+s
PryQCthBiAepNtjxA9E0QbQQeR3wYj0qL0xJQTnIwI84/nBdkJl5IKwu7yLQ9Co=
=B1RW
-----END PGP SIGNATURE-----

--3ms171w63QQ5R/kt--

--===============1627254805985343928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1627254805985343928==--
