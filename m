From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/3] ASoC: SDP3430: Connect twl4030 voice
	DAI to McBSP3
Date: Mon, 18 May 2009 13:04:56 +0300
Message-ID: <200905181304.56360.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E8125@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 728312433E
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 12:05:42 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F69E8125@dlee07.ent.ti.com>
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
To: alsa-devel@alsa-project.org
Cc: "ext Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 18 May 2009 04:03:40 ext Lopez Cruz, Misael wrote:
> Connect twl4030 voice DAI to McBSP3 in sdp3430 machine driver.
> Audio and voice DAI init functions are enabling corresponding
> interface by writting directly to AUDIO_IF and VOICE_IF codec
> registers, respectively.

>  static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
>  {
> +	unsigned short reg;
>  	int ret;
>
>  	/* Add SDP3430 specific widgets */
> @@ -150,6 +194,11 @@ static int sdp3430_twl4030_init(struct snd_soc_codec
> *codec) /* Set up SDP3430 specific audio path audio_map */
>  	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
>
> +	/* Enable audio interface */
> +	reg =3D codec->read(codec, TWL4030_REG_AUDIO_IF);
> +	reg |=3D TWL4030_AIF_EN;
> +	codec->write(codec, TWL4030_REG_AUDIO_IF, reg);
> +

Well, this does not do anything (bad or good)... The Audio interface is =

permanently enabled by default (by the default register array in the =

twl4030.c).
I have plans to do it dynamically, but it needs some more thinking, since t=
he =

digital loopback on the audio path needs also the audio interface to be =

enabled.

Is there a reason to do this at all?


>  	/* SDP3430 connected pins */
>  	snd_soc_dapm_enable_pin(codec, "Ext Mic");
>  	snd_soc_dapm_enable_pin(codec, "Ext Spk");
> @@ -192,22 +241,45 @@ static int sdp3430_twl4030_init(struct snd_soc_codec
> *codec) return ret;
>  }
>
> +static int sdp3430_twl4030_voice_init(struct snd_soc_codec *codec)
> +{
> +	unsigned short reg;
> +
> +	/* Enable voice interface */
> +	reg =3D codec->read(codec, TWL4030_REG_VOICE_IF);
> +	reg |=3D TWL4030_VIF_DIN_EN | TWL4030_VIF_DOUT_EN | TWL4030_VIF_EN;
> +	codec->write(codec, TWL4030_REG_VOICE_IF, reg);
> +
> +	return 0;
> +}

Since you need to enable the voice interface, I think at the moment this is =

the only way to do it.
Later we can revisit this if we find a better way of doing it.

-- =

P=E9ter
