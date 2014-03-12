From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: core: Add support for DAI multicodec
Date: Wed, 12 Mar 2014 00:28:22 +0000
Message-ID: <20140312002821.GD28112@sirena.org.uk>
References: <1394536644-21438-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8654749800469234922=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9B32261B01
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 01:28:39 +0100 (CET)
In-Reply-To: <1394536644-21438-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8654749800469234922==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u6ak1upF5j4uU0dQ"
Content-Disposition: inline


--u6ak1upF5j4uU0dQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 12:17:24PM +0100, Benoit Cousson wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> DAI link assumes a one to one mapping between CPU DAI and CODEC. In
> some cases, the same CPU DAI can be connected to several codecs.
> This is the case for example, if you connect two mono codecs to the
> same I2S link in order to have a stereo card.
> The current ASoC implementation does not allow such setup.

First up thanks for working on this, it's a feature which has been
requested for a long time but nobody stepped forward to do it before
now.

This is rather large so I've not had time to review it today, I'll try
to get at least a first pass at that done tomorrow.  I did notice that
in your comment about rebasing you mentioned a series - it'd be good if
we could see this as a series, splitting it up would make review easier.

> CPU DAI in a multicodec DAI link can have more channels than what each
> CODEC has. The number of channels each CODEC is responsible for is
> machine specific, hence it's fixed up in machine drivers in a similar
> way to what DPCM does.

This one is interesting.  It feels like most things will want a static
mapping because that's what the hardware does but there will doubtless
be things that could use flexibility.  Liam has looked at this in the
past (more for TDM IIRC, I thought about it for that as well and I seem
to recall Liam's ideas covering it).  It feels like we should start out
with static mappings and build up dynamic later on but equally well
getting something merged would mean we could improve on it.

> The patch is based on 3.14-rc6.

For such an invasive set of changes it's probably worth working off
-next, I forsee conflicts.

--u6ak1upF5j4uU0dQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTH6oiAAoJELSic+t+oim94gAP/iMdgXYqwyiovw+weymyOhgv
a2UDoLdH4vnIYOCkCknGlT74Dy3KsuVQzYCHxq2h6M3Wv639KPcxhadCDySbx16i
NDyvoAopmdHY9LwC93aAGhKZQdNmEVnwZ5l7YN602MaeCYsJtLMCn44F5MXTFmPc
KMIzfjnFCb5lDOTzsd+RzWtx0rCHKFEeaDvDCCMQe+7ZGQ6RkeCV2newgsRBtalq
nOUAPfvXqWykYLANPDwIbJj//rTpKbLN7njRFFY1Q+m4XI7K31m0ccX9Sg9E17CC
rTgvOGeA8K+X5aOr3kOzOZf5ud+Chz93RasNHaznkTVIhUOXvjbXELC/YnyMT9OB
gF3BkzCoHyBnhhLVnrF2mhIa2Rym9QHGedkjLKGeDZWEtbAaMWF4+9PqDZ25ztmH
Yx8dO8EP9bxoETKZqlt7gMROycwH82+LS9k2GSNWo30OX69mHzLXDCFxtIh6E6v2
ENw46i654ZL7V/iYQ30hJywnGM2zYXoXQow3+9p1VCrRJzDSaXuaEbts9xtzC16e
fGcAmBF4pVDD7ra0xG2in3B9E5pUSeVsUi/xg4bG+EkgLYJi5QpVjsVgWk0VjWV8
Y9wSmbM9XeocLVaskm4Wf96ZIk7TfRsqdt1NYV66fPsvxnFMjU5T+H6WXIPqR/Qc
m7OiOxPxow+WCh6c3RrQ
=lwpq
-----END PGP SIGNATURE-----

--u6ak1upF5j4uU0dQ--

--===============8654749800469234922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8654749800469234922==--
