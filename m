From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC updates for v3.17
Date: Mon, 4 Aug 2014 18:29:24 +0100
Message-ID: <20140804172924.GD17528@sirena.org.uk>
References: <20140804161750.GV30458@sirena.org.uk>
 <s5hppgg6wj5.wl%tiwai@suse.de> <53DFBB7B.2030804@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6336340705562635379=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6A8B261AB0
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 19:29:44 +0200 (CEST)
In-Reply-To: <53DFBB7B.2030804@metafoo.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6336340705562635379==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k6sXTxdZLCwjPj85"
Content-Disposition: inline


--k6sXTxdZLCwjPj85
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2014 at 06:57:31PM +0200, Lars-Peter Clausen wrote:
> On 08/04/2014 06:37 PM, Takashi Iwai wrote:

> >Thanks, pulled now.  The only build regression I've seen is the
> >warning:

> >sound/soc/soc-dapm.c: In function =E2=80=98snd_soc_dapm_get_enum_double=
=E2=80=99:
> >sound/soc/soc-dapm.c:2862:15: warning: =E2=80=98reg_val=E2=80=99 may be =
used uninitialized in this function [-Wmaybe-uninitialized]

> >I guess it came from the recent Lars' change.
> >It just gives the garbage value and shouldn't be serious, but it'd be
> >better to be fixed in anyways.

> yep. looks like your compiler is a bit smarter than mine. I'll send a pat=
ch.
> The issue itself is harmless though since we even though we do some
> transformations on the uninitialized value the result of that is never us=
ed
> since we return a error code.

I'm not seeing that warning either.  It might actually be that your
compiler is smarter than Takashi's here - IIRC some of those warnings
get suppressed if the compiler works out that the uninitialised value is
never referenced.

--k6sXTxdZLCwjPj85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT38LoAAoJELSic+t+oim9DUsP/R8SaXOEml48x3r54T+Oq+YA
Rq/c7sU0kg71NggaEBWK2cIQnYRWaYLmftoWxebYqpuy1BrrNp2MRNt33JPTaFAN
NNk0D0ZvKR+ed/7Rh0G7JI6BjPB3T4HF2nVG0xUb6m2iyMhtLK8J6IpvFgoAFcaF
9DDJ7vq8WKyhEw8OSFxKnfJJjV7/404DXIN3v/b7zQdQEF66QAZxE0bETSC0id28
WN8trZNeGQ/JSyHwoOs01kBsHZjisGvTq2Fb/yBPJEG9LCsEZbwNIdR8Tx2x4KFQ
m52gIE87nuKlBaJ8+3Aoq3j84CUv7qnYy4ANWOgJMkwQ0KQaVgCw4vErJVpcVRLT
sbOAGWY0K5GKBQ8mThb6wM06vamW23LM38t669NMWtE9O+Vrd1HmZ8mu4rJYQMT/
tJw7s/rHlP4xHec71880eT70Q8wCerkLgle+QMYZyUWpR8AX5aUoN3CzmbDPyP/r
mfrz94ZRsDzLAhTRgLqZW3+GxKP63aRGusnIXBV8bxx8ZndS+bOMRQYXatVpx7y5
kkaJAr88U8P5KKpoem9aUQWmdB0kEkeIHETbTgpKSyC7MpLvqw9MLZNsCc7Vysuy
pJ1a+JMrokNeql78IwGeU6iwPN4UCWL0WdWQZUkS5+j4Exf0es/1fONIoCUKH1UQ
z1EhdMFfCmhz3GaqEi40
=7GK/
-----END PGP SIGNATURE-----

--k6sXTxdZLCwjPj85--

--===============6336340705562635379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6336340705562635379==--
