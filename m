From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: RE: [PATCH 1/3] ASoC: max98927: Added support for DSP_A and DSP_B
 format
Date: Fri, 15 Sep 2017 00:30:13 +0000
Message-ID: <SN1PR11MB08476B6890CBC614DE9FB886E76C0@SN1PR11MB0847.namprd11.prod.outlook.com>
References: <1505146339-19380-1-git-send-email-ryans.lee@maximintegrated.com>
 <20170914184949.enuziddz27polfyf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170914184949.enuziddz27polfyf@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Thursday, September 14, 2017 11:50 AM
>To: Ryan Lee <RyanS.Lee@maximintegrated.com>
>Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com;
>kuninori.morimoto.gx@renesas.com; alsa-devel@alsa-project.org; linux-
>kernel@vger.kernel.org; ryan.lee.maxim@gmail.com
>Subject: Re: [PATCH 1/3] ASoC: max98927: Added support for DSP_A and
>DSP_B format
>
>On Mon, Sep 11, 2017 at 09:12:18AM -0700, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
>> ---
>
>Please make an effort to write changelogs that clearly describe the change
>you're making.  This is doing way more than just implementing DSP mode, it=
's
>also adding a fairly complicated set_tdm_slot() implementation which isn't
>mentioned at all.  It probably needs splitting into multiple patches as we=
ll.

I split this patch as two separated patches and sent again.
One is about adding DSP_A, DSP_B support.
Another is about TDM slot configuration.
I added more changelog inside.

>
>> @@ -414,6 +504,9 @@ static int max98927_dac_event(struct
>snd_soc_dapm_widget *w,
>>  	struct max98927_priv *max98927 =3D
>snd_soc_codec_get_drvdata(codec);
>>
>>  	switch (event) {
>> +	case SND_SOC_DAPM_PRE_PMU:
>> +		max98927->tdm_mode =3D 0;
>> +		break;
>>  	case SND_SOC_DAPM_POST_PMU:
>>  		regmap_update_bits(max98927->regmap,
>>  			MAX98927_R003A_AMP_EN,
>
>Why is an event associated with the DAC changing something related to the =
DAI
>format?  These things should be unrelated.

In TDM mode, BCLK is being configured inside 'max98927_dai_tdm_slot' becaus=
e TDM slot information(number of slots, slot width) is available in there.
In normal case, BCLK is being configured when 'hw_params' is called and TDM=
 slot information is not available in this function.
So I added 'tdm_mode' variable to avoid overwrite BCLK configuration when '=
hw_params' function is called after TDM slot configuration is done.
I wanted to clear this variable once playback is over so I added clear func=
tion when DAPM event is received.
I referred some codec driver change TDM related things when DAC event is re=
ceived after TDM slot configuration is done.
