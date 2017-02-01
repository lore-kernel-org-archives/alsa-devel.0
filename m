From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: add HS ground control
Date: Wed, 1 Feb 2017 11:47:13 +0000
Message-ID: <20170201114713.osuuhyomfuswnrgt@sirena.org.uk>
References: <1482999827-14705-1-git-send-email-bardliao@realtek.com>
 <s5hwpdceuns.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4271829035762124554=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 28D53267441
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 12:47:25 +0100 (CET)
In-Reply-To: <s5hwpdceuns.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4271829035762124554==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2x3o2vvr5dlwyjim"
Content-Disposition: inline


--2x3o2vvr5dlwyjim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2017 at 10:58:31AM +0100, Takashi Iwai wrote:
> On Thu, 29 Dec 2016 09:23:47 +0100,

> > Some project use external circuit to prevent the headset ground noise.
> > It will need to use GPIO to control it. Dell Wyse 3040 is the only project
> > that has the external circuit so far and it uses GPIO2 for that. This patch
> > provide the support fot it.

> Mark, this seems overlooked?

No, it's complicated.  IIRC it's not *actually* doing GPIO management,
it's adding an option to wiggle a pin on the one board you've so far
that happens to have this issue but if someone finds a GPIO from
somewhere else it'll run into trouble.  But now when I go look at it
again you sent a content free ping so...

--2x3o2vvr5dlwyjim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliRysAACgkQJNaLcl1U
h9AYyAf+IuD5MYLyIclZFDbSfqqvWIITxniZn5XDf0qjCequjS3OqdbhINrPpFh+
LqHmvtD7Op0BeYMPflPwPcBiZ9Fc8JGZqWHBr+tduWpVGwvlOXBFpVmCaJDQC9Nz
jUnzvCfojQ1wqH0Zb2TXpZCi0uDFqAsgDrypyLIFubdGZvKAIM8MzicMZYY/u//8
6mfFzJYYyZn0SrJtsatWkNmp7jj+O/zaEkm3nn246l/iP+vkXZKfZal1flMSjsCc
VWB7/r1mblu+WOQQFyjxyOiJZJ9noDGxBlR0+Fr+48QD/eV7uve7KIYfyVYyL80B
F8VoXurVCn+lRS+MwpNL1fM1jpWBSg==
=CpKQ
-----END PGP SIGNATURE-----

--2x3o2vvr5dlwyjim--

--===============4271829035762124554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4271829035762124554==--
