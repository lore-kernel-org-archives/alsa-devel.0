From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2][RFC] snd_soc_codec include
	snd_soc_component
Date: Mon, 2 Sep 2013 11:55:01 +0100
Message-ID: <20130902105501.GM3084@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <52244B11.10207@metafoo.de>
 <878uzfsj08.wl%kuninori.morimoto.gx@renesas.com>
 <52245B97.3000900@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8941479160859908914=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CAEC26512A
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 12:55:06 +0200 (CEST)
In-Reply-To: <52245B97.3000900@metafoo.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============8941479160859908914==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i6vqABX3nJKXLk01"
Content-Disposition: inline


--i6vqABX3nJKXLk01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 02, 2013 at 11:34:15AM +0200, Lars-Peter Clausen wrote:
> On 09/02/2013 10:52 AM, Kuninori Morimoto wrote:

> > As my previous email said, this patch cares only codec <-> component,
> > but we re-consider about "component"
> > if component will be used from "platform" (and "card" too ?) ?
> > (since it is controlling "dai" inside)
> > Or is it 2nd step like above ?

> I think it can be done as a second step, as long as we keep in mind that we
> want to do this eventually and don't built up any road blocks that will
> prevent us form doing so.

Yes, this is the approach I'd take too - just move things into the
component drivers gradually.  So long as we don't cause problems for
ourselves further down the road any improvements we make now mean less
work later.

--i6vqABX3nJKXLk01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJG6CAAoJELSic+t+oim9UaYP/3Q9uP+IoDiT6BMQ02GbQema
vLbuprQbq4jAP4tMKRXBA+n/7R1G8rfERpZRQZy8klW66hQ3Zjkv7fKF5X2GjaBS
R+qjCsckaCf7iofwt9qWKxN28aQsyRC+f2gu7ENXKTXSX6i6yTPHeYVsaAEFlaFH
SN9MIs+FJolR7K/mWolyRP+tmVBTBMQUB91/ldebJiPn7S26R9LZwHGgBbyGsczJ
P12ZCcHXtsqZTXn0Qp5/mfMebtQlMvMEa7lh7jmyFBe0IYf+FjqxvZfsQgsvj5l2
nAkMnw36cqIJEmQowddltbo1StPkNgLnOqaVFrs1C35EQ9MFpf38R0v5Y+Fj2y0l
MD0s1GTSaeBzPO9/fT3ewpCX2+xnU36iXwizorhzCsytKwBJk/NCYHk8DhtP14PU
A28ZC5a+n0p2nBb50wfsBQFVzyWGMav+ZxV5z/1G7DWH8PARfmRu9C1TNpAAamu4
xuvYcu3FaQd3nAU00ChbPqM0jMRvtlzyZj4zX4lKBVIbZpxU003ye6DyZSZVvFAD
vCm3erdGTsUfOR+dlrU9mEu4SZ8DFfnWEMk7JpKiayNNQFUHQp59oR54ZLpclpIx
//JrhuxOetJ9VNiINrr82/nQz39zQ4W6zp6ToRzRHu8oBtO5UFg3emPsqDydkPqh
jBxl6iALRxZ7DHtftQnh
=fbzh
-----END PGP SIGNATURE-----

--i6vqABX3nJKXLk01--

--===============8941479160859908914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8941479160859908914==--
