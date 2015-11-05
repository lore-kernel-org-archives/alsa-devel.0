From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Power up the RC clock to
 make sure the speaker volume adjust properly
Date: Thu, 5 Nov 2015 12:12:30 +0000
Message-ID: <20151105121230.GD18409@sirena.org.uk>
References: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5297410195155055648=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A2F7265A01
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:12:42 +0100 (CET)
In-Reply-To: <1446724551-27762-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5297410195155055648==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 07:55:51PM +0800, Oder Chiou wrote:

> +static int rt5645_spk_put_volsw(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	cancel_delayed_work_sync(&rt5645->rcclock_work);
> +
> +	regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
> +		RT5645_PWR_CLK25M_MASK, RT5645_PWR_CLK25M_PU);
> +
> +	ret = snd_soc_put_volsw(kcontrol, ucontrol);
> +
> +	queue_delayed_work(system_power_efficient_wq, &rt5645->rcclock_work,
> +		msecs_to_jiffies(200));

A more idiomatic way of doing this is to just have the
queue_delayed_work() - there's no need to cancel a work item before
requeuing it, the workqueue code will do the right thing.  Can you
please submit a followup patch cleaning that up?

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO0etAAoJECTWi3JdVIfQYzcH/18OFukMlJrifxm58xVrPakz
sXCpA7VVP5EL2k4OC167JSxJy81Sw+14rPcPWFOx3R6+/gfkvklwSiYsgGu+up1g
JkflpinkrhieaI5Ecsj7ktO37NvYVBlmSHGDEu/wEGVEKfaxQYoaPtZf1fny3U2R
WlMQdUECKitsK9+7LpH+Z5O0pJxH0tSyhWJqXNoN+QHHqqUBbn3kimwwcFipi11V
QHGxU4QYXYUVcCBSIYB0xOUjEdkkd+wuxdiXKLZxhwmEilcG9h135mwDrOWm8ezQ
GRTLai1hvo71AALhVg56E8zR8xqlB+4qqrMRK59qrsmUfzJ7oPvvnSPGJTzsve0=
=6h9j
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--

--===============5297410195155055648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5297410195155055648==--
