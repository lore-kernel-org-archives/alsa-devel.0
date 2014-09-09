From: Mark Brown <broonie@kernel.org>
Subject: Re: question about two ASoC commits
Date: Tue, 9 Sep 2014 11:19:54 +0100
Message-ID: <20140909101954.GO2601@sirena.org.uk>
References: <540EBC14.6090002@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tzZdJ4yHDV5r1Akt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <540EBC14.6090002@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jiwang <jiada_wang@mentor.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "Frkuska, Joshua" <Joshua_Frkuska@mentor.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--tzZdJ4yHDV5r1Akt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 05:36:36PM +0900, jiwang wrote:

> Can anyone tell me what is the reasoning of the following two commits
> commit: 5d16333 ASoC: SND_SOC_DAIFMT_NB_NF become 0 as default settings
> commit: eef28e1 ASoC: SND_SOC_DAIFMT_GATED become 0 as default settings

> with these two commits, now we have
> #define SND_SOC_DAIFMT_GATED            (0 << 4)
> #define SND_SOC_DAIFMT_NB_NF            (0 << 8)
> in soc-dai.h
> what's the good to shift 0 with different numbers?
> no matter the number, they both equal to 0.

> IMO all bit flags which share same variable (in this case SND_SOC_DAIFMT)
> should have different value, isn't it?

As the commit message says this is so that we have a default value which
does something sensible.

--tzZdJ4yHDV5r1Akt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDtRGAAoJECTWi3JdVIfQA2IH/A8dAfkH0NtNNmcsbp0hPtTN
x5jX9TqWHRxm51/MYdFFmcS6PY6bRLv+cNcTBvqNaxpuBzfa/wiwdhIQ/m52cAmw
09Ws/1kX2eQmyhGiykj4bJVUWsXMAEfxcjt7s+TgBMAgQCHWfXuBqqOibY2ZBbuV
S2Gx12iggdvj5smdtMww99P6j5owTvbP7qDAaDBXV8YtnmXN4xWWHqGoIVPZJnBI
ZGIHwPbR2tiwHbVcQ1R0auSZuTWuebeG2AytHJ9y8tyickUL1TDxdLG1A7WxAfpt
b1kFFaUaJAUv9QO8QA5mtyOAYQTlTuRN26TIm0c0JPyDCDocH3h7tkAmueKSXMc=
=1OYb
-----END PGP SIGNATURE-----

--tzZdJ4yHDV5r1Akt--
