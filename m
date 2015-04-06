From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/5] ALSA: jack: Refactoring for jack
	kctls
Date: Mon, 6 Apr 2015 17:11:55 +0100
Message-ID: <20150406161155.GH6023@sirena.org.uk>
References: <1428062838-14786-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4565580609505983333=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9889260425
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2015 18:12:01 +0200 (CEST)
In-Reply-To: <1428062838-14786-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4565580609505983333==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QuX0r7ZseMwydPce"
Content-Disposition: inline


--QuX0r7ZseMwydPce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2015 at 08:07:13PM +0800, Jie Yang wrote:
> Currently only hda will create kctls for hda jacks, for asoc, people
> may need create jack kctls in specific driver.

Sorry, you'll have got some pushed messages for this - I applied it
locally to have a look at it and pushed it by mistake.

--QuX0r7ZseMwydPce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIrBKAAoJECTWi3JdVIfQ4UkH/2UKVyqoFfJM//NC8e4XgBSG
hGNO3m94+vLT5atCb2RadWlI5BnaYNCquKJaGj/ZPRLR1CY22BaGX9o8LRQSHeQn
FOXZMupYw1rNBha+a8D8bZmDRCfudePF32yTXsbTlKaQH0wm+ceSeB9VD0fhyftl
DliRsGD6fCptgZf7iZqIbSqMWargosfa3S3QDcqXQe6k/hWpc0y4XtarEXHUqthQ
N99yrgo44cwq5GjcyfVTDJ5dBNzokWlD1BElyHEtivYREzQ7anJDE8M29gchlb78
5T8sgG5qSOzAmMFa+AaMZ4YlHsnwLV4F3Ezp553drE7v/udV6zLymvwMU3T7qk8=
=xgjd
-----END PGP SIGNATURE-----

--QuX0r7ZseMwydPce--

--===============4565580609505983333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4565580609505983333==--
