From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: jack: Add support for GPIO
 descriptor defined jack pins
Date: Mon, 26 May 2014 15:27:15 +0100
Message-ID: <20140526142715.GH22111@sirena.org.uk>
References: <1401104077-25366-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1401104077-25366-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1120294875943214554=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CB60264F8F
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 16:27:32 +0200 (CEST)
In-Reply-To: <1401104077-25366-2-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1120294875943214554==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ie9RhXlkjyREuElA"
Content-Disposition: inline


--ie9RhXlkjyREuElA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 26, 2014 at 02:34:37PM +0300, Jarkko Nikula wrote:
> Allow jack GPIO pins be defined also using GPIO descriptor-based interface
> in addition to legacy GPIO numbers. This is done by adding two new fields to
> struct snd_soc_jack_gpio: idx and gpiod_dev.

Applied, thanks.  It's worth pointing out that the existing name field
is used to supply the connection ID for the gpiod API so we don't *only*
support index based lookups.

--ie9RhXlkjyREuElA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg09AAAoJELSic+t+oim9O8cP/0DtEwcRB1oScvpxse8fXNik
4y5Es4AiaRsq8lJOSUMzsIZ8UZxkKWrldQfRd1XLHBXtTlPI0lsgQotd//dArxXQ
l7CnE3lvDOnqnDThu+KPtxE5ZwKZVLr4jKrhyl56+Pa+jyRcDA2Mqw1EBJccGifg
e+3Q6N137LU4FDqto2p0NBJCHBhrp5Z0pR3HSfvjycM73jQM92CJGYgncvG/pgLO
SyOzYnokuMTiKsXK0hrD/yhMLilqZeSm7BmimwIK8WSHFXElnQqydyVYv3fKyA18
yLkJNRfDmFoH8Wcg/PQtWyWU7k529MIXnhWN8S4hDco/l+YKcBUvzib4kuIrmYIR
FD9IYVmzA9OrvIZctMGbK7X5Ag9I1NcbX2W0sEHNM/gCCMskv1xaFoYk5CffnhIB
DDCFbkjwvwIR2bayAyFO7wo87P5leX58oKBofoEnZu1AL0n2ZXlELcIPsYRt+1aF
RUoJ/Pr0RQb+VmJ8jwOnAaeNqGEhb6ou+S2wZHBhTqASRkKxmGv76C6uzou0nKqv
R5rtkyg1GyVMlpnI1wMwpLJU93Z2JW31SAQg0a7ABsYqu6etTIoU8dwlXcR27YVz
94jbAfk/cBZC5ZhZKt1xrT1fyWhtt9yIa5FVadjKfgCaw43HAn+h702DBBMYxSZL
j1aOCMI78fPrzs3Y3hDJ
=dWhk
-----END PGP SIGNATURE-----

--ie9RhXlkjyREuElA--

--===============1120294875943214554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1120294875943214554==--
