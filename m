From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/12] ASoC: omap3pandora: Convert to
 table based DAPM setup
Date: Fri, 21 Mar 2014 18:04:06 +0000
Message-ID: <20140321180406.GI552@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3514691016358733429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 26EE7265316
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 19:04:24 +0100 (CET)
In-Reply-To: <1394634460-15889-7-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============3514691016358733429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jQIvE3yXcK9X9HBh"
Content-Disposition: inline


--jQIvE3yXcK9X9HBh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:34PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the controls and DAPM widgets and routes. This
> on one hand makes the code a bit shorter and cleaner and on the other hand the
> board level DAPM elements get registered in the card's DAPM context rather than
> in the CODEC's DAPM context.

Applied, thanks.

--jQIvE3yXcK9X9HBh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLH8TAAoJELSic+t+oim9rdYP+wSJNr+hhbBP+ivnxTQ92g6P
LCf0FdhJxjJ4N14LG5BSOLq4l5/HR+XdfNzYvLdtA/dWT/nSTkiFSo3xQVBEi+wr
972aWDRJPjN8WrcqFrAwI0mizAcl/8UBSDlpgEJUdTDxSHNwaM788oA907VfPS2V
jjXcWpRjAT5wqHyig3tb6QxtLOdpUmYDJxyXvgM2Gn/DmPDu6NnxELt8mx5En5pI
wAm21KKtF72Xm6BnaKFVe7x+lZp87SorvdTl8Z2zJN7fHo5pBivNNnzmSXSgkAMl
BWPOMhQ6o8xM+/I4J8lEmCfS5yV7zwgvEaSIxHKn+yZnNHd7TOyuYFrhUwKKdrsG
9nare3oll4f05I8YbZ0iRoI5HvfifQFdf6ayWV9VfzHD5Gf1ZGE7XQ9MJuy5jFcE
P4qgQpjFbkbn0v7e2QdDjNRrkLruFvbCBNSz5EzCXDAWGuzc/Uqw6/nljQMMij05
qN+GQ0eGdkurnQ4On7sVNHNsAtvicR03a8YfO697y9x/DkATArKtg53sgbZ0w/CH
Ru2v+LTukrDi2zYGbw4TfwvzW6RLyDLJE3JU4DSfLZbucEBW8exoHN3EQGC735AT
wl9BxpjO6XeKEY3REOGGadUbsDeQvO6Wg3rGGFrupAjslct7bCVhdZOznN0qaqpN
MwcrzqIioAarcY6LL9bH
=Mruw
-----END PGP SIGNATURE-----

--jQIvE3yXcK9X9HBh--

--===============3514691016358733429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3514691016358733429==--
