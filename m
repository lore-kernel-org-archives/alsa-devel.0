From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 000/127] ASoC: codec cleanup - codec
 probe/remove
Date: Wed, 10 Aug 2016 12:17:48 +0100
Message-ID: <20160810111748.GI9347@sirena.org.uk>
References: <87popieek9.wl%kuninori.morimoto.gx@renesas.com>
 <54ffe6bb-9a97-db02-e96b-588630b08468@metafoo.de>
 <20160809112639.GJ10383@sirena.org.uk>
 <87a8glii9q.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5954050873689434987=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EDCD265DED
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 13:18:00 +0200 (CEST)
In-Reply-To: <87a8glii9q.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============5954050873689434987==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Content-Disposition: inline


--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2016 at 12:31:29AM +0000, Kuninori Morimoto wrote:

> My understanding is that current "codec" is already part of "component",
> and new ASoC controls "component" only.
> This means, if we switches to new ASoC style, it can't call "codec"
> side callback ?
> Indeed my patch-set is using/keeping "codec" pointer, but it is each driver's
> matter, ASoC framework side doesn't care about it.

If something is only using the component interfaces except for things
like probe and remove then converting them to component interfaces makes
sense.  If it's still using CODEC interfaces for some bits then it's
less clear that this is a good idea.

> But it seems your opinion is like this ?
>  - ASoC will care only "component" (same as my opinion)
>  - This "component" includes all features
>    (= Codec feature, CPU feature, Platform feature, etc)

I think so, yes.  To me the goal is to avoid too much rigid
categorization of components so that we can handle devices that have
combinations of these features effectively without having to worry about
exactly what terminology we use to describe them.

> Anyway, I don't want to create new issue on ASoC.
> It seems we (or only me ?) still don't have cristal clear big-picture (?)
> If so, my previous patch-set might make new style switching difficult.
> Mark, because of this reasons, is it possible to remove my previous
> patch-set (= topic/codec-component) from your repository ?
> Incomplete big-patch-set will cause new trouble.
> I want to cleanup ASoC, but I want to do it under cristal clear agreement.

I think that's a reasonable thing to do in general, I don't see a
particular need to revert it.  Like Lars said I probably wouldn't have
done it right now but you've done the work so I don't see any need to
revert it.

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqw1bAAoJECTWi3JdVIfQmrQH/2jqmFz5FGV1R9le0bFa765U
5r4HsDHDiTjC0H0B9VhOm4LOMtS0+PT2XStpApwAsMvP5ehVBw48cmI2BDCiNoYA
u1LCK2WL+Tt5lpZmCgJCYbfsL5WU/V9vZABYEQHgX4EOH/0wCKmgeb1havCyAALY
0rcxjUab5aEQ3NxJFRwg7XS+GEawX/lAg2hNtelhlAkNzBlk4Or78sUhesf9LCTU
JADJuL66a1/ha9EYvEQ6892JvQvPHTysya96QgpCpDHPgSgIGARatR//Zl6PYGU0
JnG11sPDn9jeICypakbznQY6Gcv3SHcaZeeP4p+M0R/NHfo1qSaPrU/uwaQoY4s=
=Qs3R
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--

--===============5954050873689434987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5954050873689434987==--
