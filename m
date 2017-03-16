From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Thu, 16 Mar 2017 14:09:46 +0000
Message-ID: <20170316140946.kikw2rjinafu6qo5@sirena.org.uk>
References: <20170316083951.11247-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6147172426839322889=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 919762666EC
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 15:09:55 +0100 (CET)
In-Reply-To: <20170316083951.11247-1-kai.heng.feng@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6147172426839322889==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="glg4eaxpqfcltgcj"
Content-Disposition: inline


--glg4eaxpqfcltgcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 16, 2017 at 04:39:51PM +0800, Kai-Heng Feng wrote:

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMD:
> +	case SND_SOC_DAPM_POST_PMD:
> +	case SND_SOC_DAPM_POST_PMU:
> +		snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE);
> +		break;
> +	case SND_SOC_DAPM_PRE_PMU:
> +		snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_UNMUTE);
> +		break;

After power up we mute the amplifier?  That's worthy of a comment...

> +	rt286->is_dell_dino = dmi_check_system(dmi_dell_dino) ? true : false;
> +

Just directly assign the boolean value, the ternery operator is just
making thins harder to read here.

--glg4eaxpqfcltgcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljKnKkACgkQJNaLcl1U
h9AXhgf+Kdu7GiyCqq4D+ltNz8Ka0Jlm2jr38KiZ3/nB0OH+mTc3e1AdMlbGOcTE
wqzKY6ZhfZs+fnhCAxfXky0A8aajnVHpLxkDknwzJknu09kVV59RQkpJXNr4yzba
/zs9o6rP8M2Qs9pZRCExA3M3NWChhArN5xjl9FWsc9lHxTYqdiaDh1F2oAKC/hHV
Ivq39iFqbN31Ve6g5wb+rhXXkXMi96qGo4vkJIj2CJg9DncSCcL1IvjklNf2NIsa
K3bfsG9lu4XW7kqxPupQ8H4QjsFRsQcJA2woHbN1rtzN3yNCtwkJo/uYQzavGFH4
atMoyEgdzX4ho4TgGdd+Bo3AxnWG5g==
=XS2B
-----END PGP SIGNATURE-----

--glg4eaxpqfcltgcj--

--===============6147172426839322889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6147172426839322889==--
