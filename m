From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: hdmi-codec: fix non static
	symbol warnings
Date: Tue, 28 Feb 2017 09:42:31 +0000
Message-ID: <20170228094231.5sztq62lehgymu7m@sirena.org.uk>
References: <20170206143830.6871-1-weiyj.lk@gmail.com>
 <4a2e36fb-8529-c86a-1d9c-2d85fd39d530@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6861936694721202964=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 53627267208
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 10:43:44 +0100 (CET)
In-Reply-To: <4a2e36fb-8529-c86a-1d9c-2d85fd39d530@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "Jon Medhurst (Tixy)" <tixy@linaro.org>, alsa-devel@alsa-project.org, Wei Yongjun <weiyj.lk@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, Philipp Zabel <p.zabel@pengutronix.de>, PC Liao <pc.liao@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--===============6861936694721202964==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y22kbzrbggvlxfzt"
Content-Disposition: inline


--y22kbzrbggvlxfzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2017 at 10:08:15AM +0900, Takashi Sakamoto wrote:
> On Feb 6 2017 23:38, Wei Yongjun wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>

I don't seem to have this patch?

> Unfortunately, this patch causes conflict to Mark's PR[0], due to a commit
> 8480ac567959 ("ASoC: hdmi-codec: remove HDMI device unregister")[1]. I think
> it better for you to post again with rebasing this on the PR, however it
> depends on Mark's maintenance policy (he could resolve the conflict by his
> hand and apply).

If it's in what went to Linus already I'd prefer a rebase as I'd have to
dig out an old tree, I will make some effort to do merges if I can find
a baseline to apply patches against though sometimes if things are
complicated enough I'll ask people to do that for me.

--y22kbzrbggvlxfzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli1RgYACgkQJNaLcl1U
h9Colgf6AgrXGin3LelXh0l3d3GXZVNNnbQO4vPEbyidwPWcL0hmnuXZTGzHXxJi
sPhZVNESIVYXFXfMkhX4ohSittDuVHboWVJFj7hYnAyzIGxdQ774FU/9+IvoC3sy
H+4pxzO1/3cVcgb4Ge5477VuNBj2V+MThJCDPb/E3RyUWKJkN9bumUyZgSiivnJ3
XQNU0pvYChFV/+11OMbPZAMJciJcc6XsMwYlC6VNQ4jJNRwhZays547A/JmsCevV
B1VJAPIA1ChJMV5iOnr9mvTnMj2VrfMInhUbnRKcrzo5Ter4F5tA/JVfyqHOFf+d
tOGQaY+sMI46W8al9eKepwVfninSqA==
=AfM7
-----END PGP SIGNATURE-----

--y22kbzrbggvlxfzt--

--===============6861936694721202964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6861936694721202964==--
