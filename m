From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5645: Simplify
 rt5645_enable_push_button_irq
Date: Tue, 14 Jul 2015 11:28:33 +0100
Message-ID: <20150714102833.GP11162@sirena.org.uk>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
 <1436856687-31550-2-git-send-email-drinkcat@chromium.org>
 <20150714095247.GN11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70108A904@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3673455993893719499=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C46062606A3
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 12:28:48 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70108A904@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas Boichat <drinkcat@chromium.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--===============3673455993893719499==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AzvmocDWoflW00fe"
Content-Disposition: inline


--AzvmocDWoflW00fe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 10:09:44AM +0000, Bard Liao wrote:

> Thanks for the review. I think what we need is something like
> +		snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
> +		snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
> +		snd_soc_dapm_sync(dapm);
> +		if (!codec->component.card->instantiated) {
> +			regmap_update_bits(rt5645->regmap, RT5645_PWR_DIG1,
> +				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT,
> +				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT);
> +		}

Yes, that's more what I'd expect.  You could probably just do the regmap
update unconditionally since it shouldn't make any difference but it's a
bit neater this way.

--AzvmocDWoflW00fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpORQAAoJECTWi3JdVIfQRDAH/3wSTqAtWHIY+5rQstHDZKuj
xVqL1kP5X8mv3FD/UxdXRYDGH2l24Q4z5Sy/bYaGvAH+twGcan06x1WgAUvbSfRz
y2BEpNUSV2IwWyvFlmkNNRgFotz6YyK2t+04jRQJnXSKXfKXSkVSRFPpOhRCP6+n
RZz7MdL0htuPwvcrDhiSzlMsfqupqcY/UI28wqPkvIx9/YqU29xmgJth+PSDGYX/
hQFVNU+DmFNVMcd6YK4mrVeHk6TnTRbu+hdX4k+A09lmJBbKL+53vA9k67tXgei/
X2rIDSyK4TzHCxqDlnkD+TlPv7vVhm0wS30h+4ACFse1aW96je+hbiB7ya+OS6M=
=xjqJ
-----END PGP SIGNATURE-----

--AzvmocDWoflW00fe--

--===============3673455993893719499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3673455993893719499==--
