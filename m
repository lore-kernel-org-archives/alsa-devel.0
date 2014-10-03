From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Fix NULL pointer dereference
 when registering card with widgets
Date: Fri, 3 Oct 2014 15:39:36 +0100
Message-ID: <20141003143936.GB24441@sirena.org.uk>
References: <1412339560-18019-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0047180246504914624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B17926047B
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 16:39:55 +0200 (CEST)
In-Reply-To: <1412339560-18019-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0047180246504914624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 03, 2014 at 03:32:40PM +0300, Jarkko Nikula wrote:
> Commit 0bd2ac3dae74 ("ASoC: Remove CODEC pointer from snd_soc_dapm_context")
> introduced regression to snd_soc_dapm_new_controls() when registering a card
> with card->dapm_widgets set. Call chain is:

Applied, thanks.

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULrUnAAoJECTWi3JdVIfQKlkH/RpWKFMhPgogKvVsvNo33uPr
QceoM23y1YHY5qT9cKJBFHWNJofV2TQWik9JxvUZC2MLEcZA4Le9Y2XlGi/LAj+b
KOPypb7oTsbT6v33a0t1IWBxiu+9rweX24PjZgZBvRzaw4YQw1bvhFqrZ55bDn/z
7S4migZ4wzREVNEP34qwTlZTM5z1Rq79KGl26hpQBrnoQcUqbx4gNHHppFJiQdEw
CoflgmorEQrK+ahh60nlBpw0mwuQTNHS+EfZQ87jhrWQF5TrirAdA09LDkgg5Cnd
4dJY6l4vGf/NSvgnAq5obcGwhK9BqjAdC1rI6nEcaBb7ioyeXnqulbEw/ju3Sk4=
=w7Kz
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

--===============0047180246504914624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0047180246504914624==--
