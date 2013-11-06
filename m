From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/31] ASoC: dapm: Use WARN_ON() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 11:15:29 +0000
Message-ID: <20131106111529.GH11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-22-git-send-email-tiwai@suse.de>
 <20131106102431.GM11602@sirena.org.uk>
 <s5htxfpvlib.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0971620001400617417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 388B32619E7
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 12:15:32 +0100 (CET)
In-Reply-To: <s5htxfpvlib.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0971620001400617417==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KiOS11rrlPLUJaFM"
Content-Disposition: inline


--KiOS11rrlPLUJaFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2013 at 12:05:00PM +0100, Takashi Iwai wrote:

> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Please fix the comment about BUG_ON() being useless; it does exactly
what it's supposed to do.

> Also another WARN_ON() check is added in dapm_seq_run_coalesced()
> since now the show goes on after the first WARN_ON().

Why?

>  	list_for_each_entry(w, pending, power_list) {
> +		if (WARN_ON(reg != w->reg))
> +			continue;
>  		dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMU);
>  		dapm_seq_check_event(card, w, SND_SOC_DAPM_POST_PMD);
>  	}

We're not using reg here...

--KiOS11rrlPLUJaFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSeiTOAAoJELSic+t+oim9/LwP/RCcAXkp0U2cH2FWDaM3wcII
yS8TQmgIQPWCJfDqzz7uwmepc6thjyHdh2LIVG+vQoAiR8NtKGutxRraUJIYSgQF
0hrPhDghXpKG4OTpQbcHM2po+XQ9k1ghIqiVZ84W2jFW44ks6nDV1ErExriyVYvG
nnswKcv/cZn0I4Moe/wQ10BY37vbpEMa994oZt/PAhOhiEzUJws0toHKXE85pWKT
uC9o8tQmxsXf0UcO8mfSYVOS8McZ/nxe2s+BQLPQKcOXGuCP4rgL3hu9R4jKFQHe
6g8G7qculfk2NFDE2HdUV9G8xQDoLhIHB+7qw7ZygvWrnr3RasnveP5g4XTM7xMn
CjSP75cim+gnS0JGMj1epOaXcAiAj1sFLKZvxIiFyEpvrie153bOJAGoV+hXrydi
LbukpjEQQccVd2TAfgH9ZMo5+ZJ8p3ZIYxwZUEU7Jb+I3HombPWMd7qG9vgjm4bU
BHRhFunrLv9Sw01h+y0coz3LaR3y9BgtQbzCWGLABaGWxZf0R6fl9PFqhlX+nKai
vhhuMljBwc4HvvpRjAAWMKZ7ZttzL8bId+o9sUe66OX4roCc90Vuw2oIXXacojnn
kBfikstaz5CBK4hynoyjl1CG72T/YLh8h42gh7/Zg5r4L+9huawdA+pBLfY8FWo4
ZpKj7wMVhrTuopRiLdnr
=/ouE
-----END PGP SIGNATURE-----

--KiOS11rrlPLUJaFM--

--===============0971620001400617417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0971620001400617417==--
