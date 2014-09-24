From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: max98090: Move interrupt request
 from codec probe to i2c probe
Date: Wed, 24 Sep 2014 09:37:29 +0100
Message-ID: <20140924083729.GD4015@sirena.org.uk>
References: <1411127301-366-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8295001474246303536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 078502654D3
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 10:37:44 +0200 (CEST)
In-Reply-To: <1411127301-366-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8295001474246303536==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pS0IeWLqOQV1qy0L"
Content-Disposition: inline


--pS0IeWLqOQV1qy0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2014 at 02:48:17PM +0300, Jarkko Nikula wrote:
> Keep MAX98090 interrupt requested after i2c device probing as long as the
> driver is loaded. This fixes the issue where subsequent codec probe
> max98090_probe() call fails in interrupt request since interrupt wasn't
> freed over codec remove-reprobe cycle.

Applied all, thanks.

--pS0IeWLqOQV1qy0L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoLIAAoJECTWi3JdVIfQW7EH/iKat2stUWDgT0a8RiUjyiUz
e263QdDrQl91WM1MRgXEOhHi/qdPM3p+j9jbH9H/Ns1M2iMqwm2FZShE7YhSMh1r
ewq6Dn1is/PC4Hu3RBInKO7JxQjdp7SSTXXcnsGb9CoZfcUSA6IbHnFTG4fGW4CD
BKC65j3rRxS1bEm4XYppuQZck1mhg5lGJahYMs9y7+7GcUwvlpjePGtm9U14nUva
cygKnECaYLGQ6n4CV7ArpCB1i9GfMoJxOmUmsTuxgerSJ4tbJjLE5eQWALeb33u7
IW4WmxFugqBKOETECUA8Em49R5GMF5GBMgQyn9mLsNOWCtRIRTV8Og9oHgpYFwE=
=tWiI
-----END PGP SIGNATURE-----

--pS0IeWLqOQV1qy0L--

--===============8295001474246303536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8295001474246303536==--
