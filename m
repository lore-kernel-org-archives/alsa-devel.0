From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add a debug log to track DAPM widget
	power up/down
Date: Tue, 28 May 2019 16:20:08 +0100
Message-ID: <20190528152008.GM2456@sirena.org.uk>
References: <1558684467-11333-1-git-send-email-bgoswami@codeaurora.org>
 <20190524112931.GB2456@sirena.org.uk>
 <e65750b3-1fa6-e982-e695-4566f5e51e0c@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5181915899872714336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83B73F8065A
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 17:20:10 +0200 (CEST)
In-Reply-To: <e65750b3-1fa6-e982-e695-4566f5e51e0c@codeaurora.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Banajit Goswami <bgoswami@codeaurora.org>
Cc: alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org, plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============5181915899872714336==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9JSHP372f+2dzJ8X"
Content-Disposition: inline


--9JSHP372f+2dzJ8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 27, 2019 at 06:15:20PM -0700, Banajit Goswami wrote:

> having the dev_dbg here are-

> 1. Do not need to enable trace, which helps collecting logs, without much
> know-how

> about audio or kernel

That approach results in kernel logs that are really hard to use and
wrap round far too fast - if everything starts spamming the logs it does
nothing for readability.

> 2. Dynamic debug (using /sys/kernel/debug/dynamic_debug) can be enabled for

> either just this line of code, or, for the function containing this debug
> statement.

> This way, logs can be collected just for the DAPM widget enable/disable, and
> thereby

> avoid having the output logs filled with unwanted logs.

That's into needing to learn about the kernel at which point there's no
real advantage of this approach.

> 3. Though I agree with you about the additional DAPM debug logs being
> present for

> someone who may not be specifically working on Audio, based on the number of

> widgets in the audio path used, the number of prints should be limited to
> only widget

> power on/off.

Some devices are *much* bigger than others, and some systems will start
and stop audio much more frequently than others (things like noises for
taps for example) both of which will massively amplify the noise.  Even
when actively working on audio with those systems logging everything
gets old really fast.

--9JSHP372f+2dzJ8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlztUacACgkQJNaLcl1U
h9Cyjgf8CWtiazxsjURSZVITlZIn8HIXUYWIfesweLZSJN3RINF0Cyz/cTXUZEe5
8gMjchjbLW15cSTHH5ekJhKaA5TzuSv/+p6JKcV+G0v9QPF9tib3/ycmQBPwYIAs
q9bgZuKa88r8awOEYDgPRjrYlp3GoxSwbU26FIjVVtFNbKw3sveNH0AWUaSolmEl
l6FYsG12SqDj8uX9t/uPCzbB4cEu+3mYg8fI1h6rG+MCh57+Uq67/NvqQPR/U8DV
BxXOzP8VKWTBRz9NgJ3i9LPeRA7GXasH30W0HjFCAfcvtpJjhReHh+STKveLWZeH
Btj2Ds6I2a3Q6VEZCiuKoHh4vIg5WA==
=SFB6
-----END PGP SIGNATURE-----

--9JSHP372f+2dzJ8X--

--===============5181915899872714336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5181915899872714336==--
