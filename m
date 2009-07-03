From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add tristate callbacks for
	HiFi and Voice
Date: Fri, 3 Jul 2009 07:45:33 +0300
Message-ID: <200907030745.34488.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E39685527@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id D810424775
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 06:45:51 +0200 (CEST)
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E39685527@dlee04.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Friday 03 July 2009 06:11:40 ext Lopez Cruz, Misael wrote:
> Add "set_tristate" callbacks for HiFi and Voice DAIs.
> Machine drivers can enable and disable tristate for each
> DAI with "snd_soc_dai_set_tristate" function provided by
> SoC core.
>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>

> +static int twl4030_set_tristate(struct snd_soc_dai *dai, int tristate)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +	u8 reg =3D twl4030_read_reg_cache(codec, TWL4030_REG_VOICE_IF);

I think you wanted to read the TWL4030_REG_AUDIO_IF register here...

> +
> +	if (tristate)
> +		reg |=3D TWL4030_AIF_TRI_EN;
> +	else
> +		reg &=3D ~TWL4030_AIF_TRI_EN;
> +
> +	return twl4030_write(codec, TWL4030_REG_AUDIO_IF, reg);
> +}
> +

-- =

P=E9ter
