From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: DPCM can care FE/BE merged format
Date: Mon, 11 May 2015 17:15:45 +0100
Message-ID: <20150511161545.GN3458@sirena.org.uk>
References: <87mw22ufs3.wl%kuninori.morimoto.gx@renesas.com>
 <s5hr3reklel.wl-tiwai@suse.de>
 <87y4llucde.wl%kuninori.morimoto.gx@renesas.com>
 <s5hiocplv8x.wl-tiwai@suse.de>
 <20150421104210.GE22845@sirena.org.uk>
 <87pp6xm36l.wl%kuninori.morimoto.gx@renesas.com>
 <20150427203310.GJ22845@sirena.org.uk>
 <87a8xb4uqy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4308882204273584483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AF8D264F53
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 18:15:53 +0200 (CEST)
In-Reply-To: <87a8xb4uqy.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4308882204273584483==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EqVOK5mkaJAMmtSx"
Content-Disposition: inline


--EqVOK5mkaJAMmtSx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 04:14:47AM +0000, Kuninori Morimoto wrote:

> > Not quite sure what "flag control" is here, sorry?

> Sorry for my confusable words.
> Takashi mentioned

> 	>     .dpcm_merged_foramt
> 	>     .dpcm_merged_rate
> 	>     .dpcm_merged_chan

> 	Better to have bit flags.

> I guess Takashi means like this

> 	u32 xxx_flags
> 	#define DPCM_xxxx_FORMAT	(1 << 0)
> 	#define DPCM_xxxx_RATE		(1 << 1)
> 	#define DPCM_xxxx_CHAN		(1 << 2)

> But, this .dpcm_merged_xxx is defined as

> 	unsigned int dpcm_merged_foramt:1;

> "flag control" here means #defined DPCM_xxxx_CHAN flag,
> and I think we don't need it.

OK, right.  Yes, we can probably live without.

--EqVOK5mkaJAMmtSx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUNWwAAoJECTWi3JdVIfQMjQH/1lh8u6NyZR9vH7VVzLyCmB2
uc+siM3B5oR4iDtDqkGYyEbiYssAp6VwW+WFhpArKc1KlaD5MQ0p+N8ERowg7qhn
1MULHoRe7v25N8sdqfUWKqZHDtlhuIMyfGjh1VuOxgPTHSL3MTVdJWNcnRCvvHGm
r28bMQUVBQM+DifQReT3AHqrF3EcjQ5Ttejn/Se80xZBZfS1A6FiWTquTwnYEGeY
35n1wGxJaBR0PhDSvMkV3iripQeHfNJXQzbmjeliSUEL60ohICPHXyi5FEUVHpcP
zUTVrBmYKPZ5d2dG+DCX2TAxr+kHCicPERyfpI/cN6MnE+ImMwjVSZSk8QbTvrs=
=NmKi
-----END PGP SIGNATURE-----

--EqVOK5mkaJAMmtSx--

--===============4308882204273584483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4308882204273584483==--
