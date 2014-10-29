From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] audio: sai: Add Power Management support
Date: Wed, 29 Oct 2014 11:36:34 +0000
Message-ID: <20141029113634.GF18557@sirena.org.uk>
References: <1414552896-20797-1-git-send-email-b18965@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="blhOMs4YVM72OzYk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414552896-20797-1-git-send-email-b18965@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alison Wang <b18965@freescale.com>
Cc: perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--blhOMs4YVM72OzYk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2014 at 11:21:36AM +0800, Alison Wang wrote:
> This patch adds Power Management support for SAI.
> Activate regmap cache with REGCACHE_RBTREE, and use

Are you sure that REGCACHE_RBTREE is the best option here?  For MMIO
devices the cost tradeoff for the rbtree is usually higher than people
like so flat caches are preferred.  But if it works for you that's fine,
this shouldn't be *that* performance critical.

I'm also a bit surprised that this works without register defaults being
provided since we need to make sure we allocate the rbtree nodes outside
of the spinlock we use to lock MMIO access - was this tested with
mainline?

--blhOMs4YVM72OzYk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUNFBAAoJECTWi3JdVIfQ2RoH/R78fnjr1p5Nb8zDFRKIXXhB
RgnOYVpZJxHKjZX2gtm7V61dSYbWilH+nKZ3vhaeG0H84n8gqvLLFOc+w8OhtRNZ
pzZReEutmW+oQCmV7UZYUn1ThprS4ojjTQ+cfBSo8L9gPtRqslhrvD+u4bA92/hk
CfWZ8srGW3CK/Vzw3lSkOBmuW3A5ruwShYN9NGyKB2KFNmWZcX4d3Zen9cJvw2M+
MJxF0e7YNvfgc77pEWcmq3flrONr8pit5o2evNsDcqYl7tVM+ij9p3mXtfRE4Wu3
c8cICgv971oVs1EtXEh+qvPsbvUfR/vw8G+nXyTWvaL3l9WWhlScgkpHassLB2g=
=ftGc
-----END PGP SIGNATURE-----

--blhOMs4YVM72OzYk--
