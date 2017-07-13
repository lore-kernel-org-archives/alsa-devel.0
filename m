From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
Date: Thu, 13 Jul 2017 11:16:30 +0100
Message-ID: <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
References: <20170713072351.GA1485@embeddedgus> <s5hlgnsiyg6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7511140960797908957=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B78726648D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 12:17:36 +0200 (CEST)
In-Reply-To: <s5hlgnsiyg6.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============7511140960797908957==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f6ufjioalak4igbi"
Content-Disposition: inline


--f6ufjioalak4igbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 09:32:41AM +0200, Takashi Iwai wrote:

> please stop posting in this style.  It's really annoying to see
> spontaneously popping-up almost same patch for more than two hours
> long.

> If you have a series of the same fix patches, send them as a patch
> set in a shot with a thread.  git-send-email does it right.

> I don't mind a couple of patches posted separately, but this is over
> the limit.

Or at least just collect them up and send them all at one time even if
not as a single thread (you don't want to CC everyone affected by a
single patch in the set on everything, that's harder to avoid when
sending a series via git, but it can be confusing to get one item in a
large patch series without context). =20

--f6ufjioalak4igbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllnSH0ACgkQJNaLcl1U
h9Bf8Qf6AzXqrmxUZfLyUvE72qUb3AwmnIzLONclZSgwG2VD3VTL65vc3ZAehIMr
AWgSWL0laBKJhAiCdQ6ZQ5r3CQmui27gyIHagZ8GXrVSrgw2/lZOzwPkmTGQA/Ya
OSrRnYVmK/ClSkV12NDYS4uvBRGSho275Y7mfI/rdlqYJMBjgI1uzz2HQn8bQ7iM
QKZ8FIXhjH9Qait3bVYL7m6uYHhAOW7opBnVGOH2m+X30AuD6Wec9XU72Q1/pGvA
GYJmGiImxQtRBV+OK0STvQxO4RJ0INfXL1ZT7b8UY8frMMFx9Mu7CpIidWdtP1jO
ZIzvA0T3+aqq/EALntQqjBHBfp9j/Q==
=nlTK
-----END PGP SIGNATURE-----

--f6ufjioalak4igbi--

--===============7511140960797908957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7511140960797908957==--
