From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/8] ASoC: ep93xx: Setup dma data in DAI
 probe
Date: Mon, 13 May 2013 17:33:04 +0400
Message-ID: <20130513133304.GG6836@sirena.org.uk>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
 <1366478947-9377-5-git-send-email-lars@metafoo.de>
 <519095CD.3080606@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3585252803707804816=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BB4732617B6
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 15:33:10 +0200 (CEST)
In-Reply-To: <519095CD.3080606@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3585252803707804816==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2013 at 09:27:09AM +0200, Lars-Peter Clausen wrote:
> On 04/20/2013 07:29 PM, Lars-Peter Clausen wrote:
> > This allows us to access the DAI DMA data when we create the PCM. We'll use
> > this when converting ep39xx to generic DMA engine PCM driver.

> it looks like this patch was lost. The next one in this series which has a
> dependency on this one was applied though. Should I resend the patch?

You need to rebase it into the current code, if it's been discared it's
a result of the rebase into v3.10-rc1 - I didn't have to do any fixups
for ep83xx.

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkOuIAAoJELSic+t+oim9LL4P/2ef3cynJCBmxmL06hObXo2B
K/iehMwCeVGdD8DYNW+sdj9VZAUvgVq0Rwzlni6ItGbJ5gV0OpAVYjctzq/kb21/
+bot1UWVlY+HJogyrXzrqL0IRPNoAAFWLQPkvSEtfZafpKekMyW4D0AElk/7PEx/
AQu4dHslABXE9zojMq0nXa5u9mFi+fbcuYJf6y3EQjx0jo1uv0BjCQuEBSgh1DIT
sWrMYOrOM9t6SQc5u9YeVfHmxQPw/ftDiAQwRWLiw7aseQ44y6YdmcwgngcTNpch
sx+iwjPCcKccoMenMi3uH5AZC86BnzLwGdH5ADqUSJfm9b7e2iK0vla9/ch2rgIY
jlP3gLoVwQ1vN4rNRBFQH5FP97GPy0mjiZcINT1VmWpRISdsraILkAPoFnQ/uprq
UD8HqcwqjRZsXh5U87y3SUsPCfPhoOaq/ERwO1AiADd9lEruEGbyanWq6CvEUS23
C1i+uKMaUh6KWLxZiLuymmfRfTD4buNBe5PMaMntbdSES6EirsgRuRIilUw5eHYM
sjnjFBgvCqyEvkGYHP/CHLVM/FU5x1dvZteIYzuihDSuLhXz2AcUHnQihRCXLgqA
5kPQVtfa8Mn3w21miexgn36OHWXYJiwi4ZJuQRgMuW02VbQ9lMDuGRO3B9ngs6B9
RjTETDXfmdBEodVrAaNT
=pFVg
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--

--===============3585252803707804816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3585252803707804816==--
