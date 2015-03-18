From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC fixes for v4.0
Date: Wed, 18 Mar 2015 10:12:01 +0000
Message-ID: <20150318101201.GV28806@sirena.org.uk>
References: <20150317113635.GB28806@sirena.org.uk>
 <s5hh9tin02o.wl-tiwai@suse.de> <55094298.8020306@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2346766066386496721=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FC6E26055A
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 11:12:13 +0100 (CET)
In-Reply-To: <55094298.8020306@metafoo.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Gabriel Dobato <dobatog@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2346766066386496721==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xQA5JmyoyfznAa64"
Content-Disposition: inline


--xQA5JmyoyfznAa64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2015 at 10:17:12AM +0100, Lars-Peter Clausen wrote:
> On 03/18/2015 10:09 AM, Takashi Iwai wrote:

> >% git grep '"NULL"' sound/soc/
> >sound/soc/codecs/tlv320aic23.c: {"Line Input", "NULL", "LLINEIN"},
> >sound/soc/codecs/tlv320aic23.c: {"Line Input", "NULL", "RLINEIN"},
> >sound/soc/codecs/tlv320aic23.c: {"Mic Input", "NULL", "MICIN"},

> Gabriel send a patch for this a while ago, which was actually the reason =
why
> I started to look for more of them. Looks like the patch had some formali=
ty
> issues and wasn't applied yet.

Trawling the alsa-devel archives it seems the patch was flagged as ARM:
and got some other replies so I'll most likely just have deleted it
unread. =20

--xQA5JmyoyfznAa64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCU9wAAoJECTWi3JdVIfQ5nIH/j20hFpsD+fNMmiJUyUwPwrE
Znm2A8hXaWQqs54QYcA2M38+mhYEz7QD6xmGWTRo2mrH4UdxKC6VdjMZ6wcIIBA6
bKMlcVUCE3wuCUqcFf7D+B5wUrjo9LL3HZi2+LKt+9zR6wo0GCtKK7D+zt1WFBrs
HxTH3FAGBhjN82+YpT438fGPR6c6Pzoir0KlnZryfk2ZyVM9lqavd85k3snSXzO5
rHYXiA68xTxbmgPm2l0olSqFin880ug6ikjI29Xn6bvinpI/Tr8HkCCKo/Nf1BxU
qieDv7rLBNg9aYpf6qtxlHOjxs67AX14738SOe/8tyjOTIdaupbQPfHFCxx8DiI=
=3FHG
-----END PGP SIGNATURE-----

--xQA5JmyoyfznAa64--

--===============2346766066386496721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2346766066386496721==--
