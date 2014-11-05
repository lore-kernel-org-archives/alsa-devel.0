From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: rsnd: Add Volume Ramp support
Date: Wed, 5 Nov 2014 17:24:23 +0000
Message-ID: <20141105172423.GG8509@sirena.org.uk>
References: <8761fc7vpx.wl%kuninori.morimoto.gx@gmail.com>
 <87tx2w6h2r.wl%kuninori.morimoto.gx@gmail.com>
 <20141028223814.GM18557@sirena.org.uk>
 <87oasviuw0.wl%kuninori.morimoto.gx@gmail.com>
 <20141029225659.GS18557@sirena.org.uk>
 <87r3xqxf1z.wl%kuninori.morimoto.gx@gmail.com>
 <20141031115330.GN18557@sirena.org.uk>
 <87389zakvi.wl%kuninori.morimoto.gx@gmail.com>
 <20141104114541.GL3815@sirena.org.uk>
 <87oasm4id2.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7854317204376150677=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79E0F260711
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 18:24:44 +0100 (CET)
In-Reply-To: <87oasm4id2.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============7854317204376150677==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 04:10:39PM -0800, Kuninori Morimoto wrote:

> > Like this second one (just say 128dB/step if it's only one step).

> Maybe this is  bikeshed, but I want to use same as "datasheet words".
> Some of them is not "1 step".

> 	"0.125 dB/1 step",
> 	"0.125 dB/2 steps",
> 	"0.125 dB/4 steps",

That's absolutely fine - I didn't realise they weren't all a single
step.

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWl1HAAoJECTWi3JdVIfQ6rQH/3b1aimL8jBS2Gotr/cBKY+d
sLN8A6k66kOoLQgy1hMNOnth1HZdFaIG/x2Qtwe3pb8A2ffjHxUZJD4hBzanIuaa
Yib5d8vBvN8ZX+QWQQamcjCP4fumiIkjkH/CxfdoxgpYsfBnk1dDVkTSdhU9c5LZ
Lk96hg2F97onBZljRP4+aUrw0DfzYssJJydLyGS4d5cHBYUcYJSvUOAJYOHJElGM
LIO5HLbCmcWEl6bKywsjxbI/4+B5UgjS2Cmg9BQeQuhCGvlwjCf6NMnslb6FvZV3
2/hWZ9wKfyShNq2hwncNA9PWfkHHAujb53HlM0niyToqkx9b7FGxW0Um1DqFU9o=
=ULMa
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--

--===============7854317204376150677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7854317204376150677==--
