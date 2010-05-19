From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Define output pins with
	SND_SOC_DAPM_OUTPUT
Date: Wed, 19 May 2010 15:00:14 +0300
Message-ID: <201005191500.14607.peter.ujfalusi@nokia.com>
References: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 43EEF1038E3
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 14:00:31 +0200 (CEST)
In-Reply-To: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 19 May 2010 13:55:26 ext Jarkko Nikula wrote:
> Codec output pin should be defined with SND_SOC_DAPM_OUTPUT as otherwise
> external widgets doesn't alter the output state.
> =

> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
> I noticed this with a widget and audio map below where state of
> "Headphone Jack" wasn't changing the codec output.

This is intentional.
TPA is _not_ a codec, it is amplifier.

> SND_SOC_DAPM_HP("Headphone Jack", NULL),
> =

> {"Headphone Jack", NULL, "TPA6130A2 Headphone Left"},
> {"Headphone Jack", NULL, "TPA6130A2 Headphone Right"},
> {"TPA6130A2 Left", NULL, "LLOUT"},
> {"TPA6130A2 Right", NULL, "RLOUT"}

And this is how you should use it in a machine driver:
Connect the codec's outputs to TPA. The TPA code adds the HPs for you alrea=
dy, =

so you don't need to care about it...

 {"TPA6130A2 Left", NULL, "LLOUT"},
 {"TPA6130A2 Right", NULL, "RLOUT"}

If you want to turn off the headset path, which I suppose you want to do he=
re, =

than within the same kcontrol you will have for HS mute you can do this:

	if (jack_state) {
		snd_soc_dapm_enable_pin(codec, "TPA6130A2 Headphone Left");
		snd_soc_dapm_enable_pin(codec, "TPA6130A2 Headphone Right");
	} else {
		snd_soc_dapm_disable_pin(codec, "TPA6130A2 Headphone Left");
		snd_soc_dapm_disable_pin(codec, "TPA6130A2 Headphone Right");
	}

> ---
>  sound/soc/codecs/tpa6130a2.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
> index 100a747..99b70e5 100644
> --- a/sound/soc/codecs/tpa6130a2.c
> +++ b/sound/soc/codecs/tpa6130a2.c
> @@ -359,8 +359,8 @@ static const struct snd_soc_dapm_widget
> tpa6130a2_dapm_widgets[] =3D { 0, 0, tpa6130a2_supply_event,
>  			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
>  	/* Outputs */
> -	SND_SOC_DAPM_HP("TPA6130A2 Headphone Left", NULL),
> -	SND_SOC_DAPM_HP("TPA6130A2 Headphone Right", NULL),
> +	SND_SOC_DAPM_OUTPUT("TPA6130A2 Headphone Left"),
> +	SND_SOC_DAPM_OUTPUT("TPA6130A2 Headphone Right"),
>  };
> =

>  static const struct snd_soc_dapm_route audio_map[] =3D {

For now I'm not acking this.

-- =

P=E9ter
