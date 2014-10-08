From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mc13783: Ensure we only try to
 dereference valid of_nodes
Date: Wed, 8 Oct 2014 16:50:15 +0100
Message-ID: <20141008155015.GF4609@sirena.org.uk>
References: <1412779204-30876-1-git-send-email-broonie@kernel.org>
 <s5hk34ak3dk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8049253250915288370=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 45080260478
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 17:50:35 +0200 (CEST)
In-Reply-To: <s5hk34ak3dk.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8049253250915288370==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sa8Wro6pbQmO8/rE"
Content-Disposition: inline


--Sa8Wro6pbQmO8/rE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2014 at 05:06:15PM +0200, Takashi Iwai wrote:

> I'd move the declaration of np into if block, too, so that it won't be
> referred in other places.

I generally dislike that style outside of very large functions; it's not
typical for C.

--Sa8Wro6pbQmO8/rE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNV02AAoJECTWi3JdVIfQzAcH/jk9Y/go17d+xs3SCP/m2fI/
28Y9GvYN0rN/LhApPlJyFP6moz2X/UDtzOQ44dfrNmUMZaTB4LOMrZJaD0g/6V6O
/n9SA7XGkYqZzeuM4SYgVY3fYShzf25xKG2LSxW5E+eFZ0g9SqvbGSmDZ3HokcqY
TMx14ppE3OWt51ZJzAKq6EElCTEArcskVu1FCj2Pvr17NW/g5uUx0elqN2Db70Rm
z5aPsSVWWe38OLZkQO83KVLOmwXVT9NXoHaqepTyG+sWznCosVgTsAFxR9JsNVaz
Xb5kteP07N7fKtXS/YeBTz4P8mrNnZc8HZjDFxajZbhPjhOH4f0vuxgcPutZSKg=
=EI74
-----END PGP SIGNATURE-----

--Sa8Wro6pbQmO8/rE--

--===============8049253250915288370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8049253250915288370==--
