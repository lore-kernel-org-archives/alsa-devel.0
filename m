From: Mark Brown <broonie@kernel.org>
Subject: Re: DPCM: skip DAPM_STREAM_STOP event to BE,
 if still used by other FE
Date: Mon, 4 Jul 2016 11:11:03 +0200
Message-ID: <20160704091103.GX6247@sirena.org.uk>
References: <1465109939.29781.2.camel@mtkswgap22>
 <20160629190816.GS6247@sirena.org.uk>
 <1467599214.21156.2.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4409982092655432144=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 96547265870
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2016 11:11:21 +0200 (CEST)
In-Reply-To: <1467599214.21156.2.camel@mtkswgap22>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "ChiPeng Chang ($BD%{,
 J~(B)" <chipeng.chang@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--===============4409982092655432144==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FVm6dlxF4pQlpRQl"
Content-Disposition: inline


--FVm6dlxF4pQlpRQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 10:26:54AM +0800, KaiChieh Chuang wrote:
> On Thu, 2016-06-30 at 03:08 +0800, Mark Brown wrote:
> > On Sun, Jun 05, 2016 at 02:58:59PM +0800, Kai Chieh Chuang wrote:

> > > The BE receiving SND_SOC_DAPM_STREAM_STOP event, while still used by a
> > > FE who is in STREAM_START state. The DAPM will just inactive BE related
> > > widget/dai without checking. This just doesn't seems right.

> > Why not?  The backend is still active and running, why would it expect
> > to be stopped unless it's supposed to actually stop?

> Yes, I don't expect it to stop.
> But at this situation, the BE change to state STREAM_STOP while
> still used by a FE in STREAM_START state.

> Shouldn't the BE stay in the STREAM_START state?

Yes, but that sounded like the situation you were describing?  It's
really hard to follow what you're trying to say here, perhaps just send
the fix you're proposing?

--FVm6dlxF4pQlpRQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXeigmAAoJECTWi3JdVIfQhG8H/3HqpQSJ8eQ3uMGO79qsEMHx
qvnHxwKCUAwxhIQCLYr2cZsEOmfX1lJTD8zR6u1ULQm5LwrXP5XOjkS78stWwJk8
ba028FhoOW7OmYVHX/0ikyg9F0qUfLYKNelY1jf+R8YlQ4cYkKrFdtnjIQavbE8+
tVd6wVND1doWIdoS5o5Vo2jkp6mJ5ZWspbo2gBSI3bhZoFZ7bw9Vki2KE14u6cvE
JzD68VsR6xq+xPcm/qnGYaCwUICciu0JMvrDN6dwNC9DCd4eQ38lr/pBdH1ohcSf
sYZ+V8R/mpqxxzlJPPimOnfUmiu0QONIxjWGvEyk0q1YXjs/p8yhi3n75BW1BG8=
=dneu
-----END PGP SIGNATURE-----

--FVm6dlxF4pQlpRQl--

--===============4409982092655432144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4409982092655432144==--
