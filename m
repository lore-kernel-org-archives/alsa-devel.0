From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 1/4] regmap: cache: Add "was_reset"
 argument to regcache_sync_region()
Date: Sat, 25 Apr 2015 12:32:35 +0100
Message-ID: <20150425113235.GA31708@sirena.org.uk>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
 <1429915008-22015-2-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5369337328003865982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA9272614E0
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 13:32:47 +0200 (CEST)
In-Reply-To: <1429915008-22015-2-git-send-email-cernekee@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, abrestic@chromium.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, dgreid@chromium.org, olofj@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============5369337328003865982==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 03:36:45PM -0700, Kevin Cernekee wrote:

> index 116655d92269..ece122a6fdeb 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -438,7 +438,7 @@ bool regmap_can_raw_write(struct regmap *map);
> =20
>  int regcache_sync(struct regmap *map);
>  int regcache_sync_region(struct regmap *map, unsigned int min,
> -			 unsigned int max);
> +			 unsigned int max, bool was_reset);

This seems pretty ugly - both the fact that we're changing the signature
of the function and the naming of the argument feel inelegant.  The
point isn't if the device has been reset, the point is if the device
currently has the default register values or not, and this means that
the user is responsible for tracking that state until the next time it
does the sync.  That may be immediately like in your case but there's no
reason that has to be the case.  The fact that we're passing in
something called "is_reset" which sounds like a state value for the
register map is a bit of a warning sign here.

What we should be doing here is providing a way for users to tell regmap
if they've reset the register map and actually we already have that
interface, it's just not got the best name - regcache_mark_dirty() is
effectively it since there's really not a lot of other reasons why a
driver would need to mark the cache as dirty.  We're just not handling
it properly.  What we should do instead is to keep the interface as it
is for now and make it behave in a more expected fashion so that if the
cache is explicitly marked dirty we assume that the hardware is in the
default state and otherwise we don't.

Ideally what we'd do is both improve the naming of mark_dirty() (though
that's API churn which is nasty) and arrange for rbtree to cache the
default values lazily, that way the only things in the cache will be
things that have been explicitly changed (we will still want default
checking but it makes life easier and means we don't end up having to do
a full writeout for cases where things have been put into cache mode
without a reset).

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVO3tSAAoJECTWi3JdVIfQ4tQH/jToqLKDOV2DsmIaJcA6b7Mq
noDT4NFcdbgemOEVGFEGEdZBckC40k/Xq4TaGs17DYxzVnUgMCXJGyiK51vydtn3
4N++Z+IVauSe8Vshae6/uigcMk35NY5YxnxSmX3w1avhqex3D+u/nD+VosCwaZ88
e3w+lpnIs1CWJcvIoul0V6KG86zxFFlHsxuCHT5wH7uaURTpAkeJoqWhpZnerjR4
co8rEvXAX4NIxrBV7fH6MUWBWHDWnICYW3bVksOZgYYi/CNyyY6V2o2CDVn32/Rb
UWco874qp9IBJM/DzcIaTc94jKqxGs2u/iY56Y0SvdMW36cOgrSt+voR31hskCI=
=oLvD
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

--===============5369337328003865982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5369337328003865982==--
