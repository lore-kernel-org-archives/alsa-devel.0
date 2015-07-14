From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
 rt5645_enable_push_button_irq
Date: Tue, 14 Jul 2015 10:52:47 +0100
Message-ID: <20150714095247.GN11162@sirena.org.uk>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
 <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7669237293964367922=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA886260459
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 11:52:59 +0200 (CEST)
In-Reply-To: <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, koro.chen@mediatek.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7669237293964367922==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mD0xtj0tT7+BfWnY"
Content-Disposition: inline


--mD0xtj0tT7+BfWnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 02:51:25PM +0800, Nicolas Boichat wrote:

> +		if (codec->component.card->instantiated) {
> +			snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
> +			snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
> +			snd_soc_dapm_sync(dapm);
> +		} else {
> +			regmap_update_bits(rt5645->regmap, RT5645_PWR_DIG1,
> +				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT,
> +				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT);
> +		}

I don't understand why this isn't updating the DAPM state if the device
is not yet instantiated - this means that when the card instantiates the
pins will be turned off which presumably isn't what you want given the
manual register map futzing in the else case.  What's going on here?

--mD0xtj0tT7+BfWnY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpNvuAAoJECTWi3JdVIfQyoQH/02nb2LjGZHgxK9FKJAYz4B8
N92kY57F6+1ut20Sztb8FMhetXRqbzMyscLMoI46eB24v1HcnNn2SQntHHeLPTfo
9uxC5+Fq8T3U9xu60ZwmFyGk4dNf8HAb2epWvDUS1Kstlsy8dGdnztS9Sevcvxa1
sV+4R05PFjnwCc3gw/R8je80N7MbQf2FbjE6JaoacUp7rMifRf/Z87IlG9nrg5xa
yK7sxaM03uMWQYSksGAWhEexF14AiTFCsjGDf/e6wCKi1DISZST/g1E5Rh+N+917
Ayaa0FjI+XTs1seLT9ymy6pNX+UDypi8EU5/WEUCcx9VxlJyxK/H5jUPMcjUCPU=
=3wyr
-----END PGP SIGNATURE-----

--mD0xtj0tT7+BfWnY--

--===============7669237293964367922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7669237293964367922==--
