From: Mark Brown <broonie@kernel.org>
Subject: Re: simplify simple-card
Date: Wed, 18 Feb 2015 01:14:08 +0900
Message-ID: <20150217161408.GX9110@finisterre.sirena.org.uk>
References: <87fva68ckb.wl%kuninori.morimoto.gx@renesas.com>
 <20150217043205.GS9110@finisterre.sirena.org.uk>
 <87oaotrtxz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8955710677864266555=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94741260525
 for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2015 11:03:30 +0100 (CET)
In-Reply-To: <87oaotrtxz.wl%kuninori.morimoto.gx@renesas.com>
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


--===============8955710677864266555==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9I0HVnGRacHebCDW"
Content-Disposition: inline


--9I0HVnGRacHebCDW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 17, 2015 at 05:23:40AM +0000, Kuninori Morimoto wrote:

> Sorry, but I guess you are misunderstanding about my idea.
> My idea is that we create above sound cards, and use it by

> 	sound {
> -		compatible = "simple-audio-card";
> +		compatible = "single-audio-card", "simple-audio-card";
> 	...

> If we can create simplified simple-audio-card (= here "single" audio card).
> we can use it, if not, we can use current simple-audio-card.

> If it is difficult to keep compatibility between current "simple" and simplified card,
> can we create above new sound cards series ?
> Some of these functions are already created as common code (but no one is using it ?)
> new sound cards series can reuse it.

I'm still seeing complexity here from the fact that we have to work out
what combinations of features to support - if we're splitting things out
then at some point we are going to have to have split code paths.  It's
possible I'm just not seeing the advantages here and that the code will
make it clear what the benefits are but it doesn't feel like it's the
way forwards right now.

--9I0HVnGRacHebCDW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU42jPAAoJECTWi3JdVIfQqNEH/jRd+W1zX/NKL3uCX4fgh0AR
Dl7QtJuhrKKa11P4uNZmGnkVxPtf3mL0nVnY99bAEyAUdOkRStNfNmRZRZY85N44
qW2pEAUvzy61aNh7cgNs/1zPUADfwQnJ34/OT1zAX6udb4LXc/PIdzZZa8WufPFn
oXOX9606ZxM+gdE1xA0oGepUeGqwfTp4VemupaBk4PsLF/Iez4M4snX5N3pUSlaZ
AlXRlOHtghTXpDR0CUUox24ygHFAZsmd0umUb/Tq49bi2BAISYcz0MgebagXAiUv
//GjeJyT/dK5CJPTWwRTT+QNFCkrFnyXVjTbO7kSfQN9ELEyPWC+p5nc/Vnf6eE=
=P2XJ
-----END PGP SIGNATURE-----

--9I0HVnGRacHebCDW--

--===============8955710677864266555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8955710677864266555==--
