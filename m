From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: uniphier: evea: add switch for
 changing source of line-in
Date: Wed, 14 Mar 2018 09:26:09 -0700
Message-ID: <20180314162609.GV2186@sirena.org.uk>
References: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2131670977028705637=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D0D1F267429
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 17:26:12 +0100 (CET)
In-Reply-To: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2131670977028705637==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yC91f7qSViS67v3c"
Content-Disposition: inline


--yC91f7qSViS67v3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2018 at 09:39:00PM +0900, Katsuhiro Suzuki wrote:
> This patch adds mixer switch for changing audio source of line-in.
> We can choose one of LIN1, 2, 3, default is LIN1.

I'll apply for now but this should really be a DAPM control so that we
can power down things connected to the disconnected line inputs when
recording.

--yC91f7qSViS67v3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqpTSAACgkQJNaLcl1U
h9C9rQgAgmE9TKBiE3nsqvlGYbZvo9M7OHd5IBS4MzV1cE62LKFZtwiNPqlblh0B
ODHwTtnjoYe/wceENo1Wu039D3on8lZH0jIwidq63+LDRcIabSzG444HNzkNB5Wh
Cg0PErPsyO8D3TCLLmjsFoUIbrgqcPYPq0BaFwIABy5vm/BkbL9TtDYoSG27uwbL
U+dD1qtYxA/UJ/oEN3M8QfO3XqiSmrWxDrNrCoy5tvR8Oi4K86xg0GLFbdaGnNKk
E4HMxHtqfIAbZyFb9uHJcq2sYdvffKyhAhj9rKBaFU22VOgc9Ih0UkR+8TJLrbAE
3WMJZ4kz/Y2oJdAxwkp8ANRGpa9k6A==
=2NzJ
-----END PGP SIGNATURE-----

--yC91f7qSViS67v3c--

--===============2131670977028705637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2131670977028705637==--
