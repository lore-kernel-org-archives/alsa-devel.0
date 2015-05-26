From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Tue, 26 May 2015 21:14:26 +0100
Message-ID: <20150526201426.GA21577@sirena.org.uk>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <55633CED.2090600@metafoo.de>
 <20150525171501.GC21577@sirena.org.uk>
 <5564BED6.3070604@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4623228581558990229=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1C77262606
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 22:14:36 +0200 (CEST)
In-Reply-To: <5564BED6.3070604@metafoo.de>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4623228581558990229==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yEuxjfeaz4aFLPvI"
Content-Disposition: inline


--yEuxjfeaz4aFLPvI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 08:43:34PM +0200, Lars-Peter Clausen wrote:
> On 05/25/2015 07:15 PM, Mark Brown wrote:

> >I think it solves the 90% case well enough for simple-card (which is to
> >the main target user here) and the situation with jack detection is
> >already fragmented enough that we're not likely to make things
> >that much worse.  Though now I think about it just taking the gpio out
> >of the device name would help with binding reuse for other users.

> Yea, but 90% of those 90% are already covered by the existing bindings. The

I'm not sure what this thing with "yea" is (I've seen some other people
use it too) but the normal word is "yes"...

> existing simple-card bindings and driver support GPIO based jack detection,
> albeit not as flexible as this. But we don't actually gain that much with

Huh, so they do.  Ugh.

> >Yes, this is the complete solution - and it's not an audio specific
> >thing either, there's a reasonable case to be made for saying that that
> >this should be resolved in extcon rather than in any one consumer
> >subsystem.

> If the bindings are good it doesn't really matter which framework eventually
> picks them up, but in this case the bindings are awfully ASoC specific and
> leak a lot of the shortcomings of the current implementation.

Could you expand on the abstraction problems you see please?  It looks
like a fairly direct mapping of GPIOs to a jack to me (like I say I
don't see having GPIOs directly on the jack object as a problem - having
to create a separate node to put the GPIOs in doesn't seem to solve
anything) and we're not likely to have enough GPIOs to make the usual
problems with lists of values too severe.

The only things that concerned me particularly were the name (which I
did agree on once you mentioned it) and the use of a bitmask to describe
what's being reported but it's hard to think of anything much better
than that.

--yEuxjfeaz4aFLPvI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZNQhAAoJECTWi3JdVIfQSysH/34CFscSNKwq+YM+BAgntDmV
T3izylWRZHiVkZsM4Gw/cR1b4JqEbLgC1iRsRltyXG0DzN+18GfEgTyC55w8LVrg
0j+iCixZII8DDGbyj3OwTtiRBGElmCfHhL+NqQixa1+07Dn6CtzxrHzTqYi4SqdE
wNiHqjexscPg+gSDbcpMjoExtC043Fk/cfv64s7cxbkQPIYtb7MX13q/D0P4D0NH
gIrfg3z2+JRkFDGZuQcSX83U+ppKofrmeAGoHtLBDDBva8KLzizLJV5TuY/exLR1
jEI3NV50TFj2PzBzSBqxGuJXa9aO9530LFJrU5eqo3tOAUGCEgsxGRpg0xai2ss=
=Bg/c
-----END PGP SIGNATURE-----

--yEuxjfeaz4aFLPvI--

--===============4623228581558990229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4623228581558990229==--
