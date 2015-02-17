From: Mark Brown <broonie@kernel.org>
Subject: Re: simplify simple-card
Date: Tue, 17 Feb 2015 13:32:05 +0900
Message-ID: <20150217043205.GS9110@finisterre.sirena.org.uk>
References: <87fva68ckb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4895081537208451209=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0A1F26087E
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 05:32:55 +0100 (CET)
In-Reply-To: <87fva68ckb.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============4895081537208451209==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wlFCko3yyTbBmKK8"
Content-Disposition: inline


--wlFCko3yyTbBmKK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2015 at 08:49:31AM +0000, Kuninori Morimoto wrote:

> I want to create new sound card driver which supports DAPM.
> But I can't use simple-card driver for this purpose because DT binding is=
sue.
> I guess, this new sound card can use/share simple-card functions.

Adding Jean-Francois who was looking at doing a refreshed simple-card
using the graph bindings, and Lars who's been involved a bit as well.

> OTOH, simple-card is not "simple" today :(

> Basically, main purpose of simple-card / new sound card is binding CPU/Co=
dec settings
> to ALSA SoC framework. But we have many pattern for it.
> From DT bindings point of view, we can/should use same DT bindings for sa=
me settings.

> Now, simple-card is supporting
>  - single CPU/Codec
>  - multi  CPU/Codec
>  - more feature...

> My opinion is that complex code has un-understandable bug.
> So, how about simplify simple-card, what do you think about this idea ?

Obviously cleanups are good, but we can't break compatibility with old
bindings.

> We separate current simple-card to common parts, and, simple-card specifi=
c parts.
> basically, common parts controls DT bindings and ALSA SoC settings.
> sound card specific parts cares each own feature.

Bits of it are already written like this so more librification seems
like a good approach, it also means that when someone has a genuinely
board specific driver they can reuse as much code as possible.

>  - common             : basic common functions
>  - simple-audio-card  : existing driver, keep as-is for compatible reason
>  - single-audio-card  : single CPU/Codec sound card. simplified from simp=
le-audio-card
>  - multi-audio-card   : multi  CPU/Codec sound card. simplified from simp=
le-audio-card
>  - fixrate-audio-card : new sound card
>                         same as single-audio-card, but it needs sampling-=
rate-convert via DAPM,=20
>  - chain-audio-card   : DAPM card (?)
>  - ....

> My idea is taht we can replace current "simple-audio-card" to "single-aud=
io-card",
> or, "simple-audio-card" to "multi-audio-card" on DT.

I think this would make things more complex since we'd inevitably end up
with combinations of the features that need supporting together and it
seems like there'd be poor code reuse.  We do also still have to support
the existing binding.

--wlFCko3yyTbBmKK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU4sRAAAoJECTWi3JdVIfQFLEH/ik1Qh2jrsXqf0sHR1NET4gI
NLP8stiuLLqjXTyW8OPJlH/jZPS0G0gxTpVLgBmyvvz4O3Z5iq58uPtvG8Tdvg5F
4DxEYUXUrL5pZXyZ8nNdmxmN2GtYQ+a7DUJDh2aQbd2/xDO8ALcp8ZDyp7Mbzeq7
vsTUGhmWljuD76fX3wC0OdRbh1XNaPDB8iY1YFxcr2sXRlEMK/bVuh/839I+7pKB
QReE01dWymotRNV4ZUZrUT+RAFPsLAnFwXzmkPALiEH9fTdv7GR0oMj9m58FbyRh
7wNEANFamBzsr7HQj35s8Au1fbQVdL7P8k5gNaeugrnzuJ94nd07p5ZFlg0Ae50=
=hn7a
-----END PGP SIGNATURE-----

--wlFCko3yyTbBmKK8--

--===============4895081537208451209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4895081537208451209==--
