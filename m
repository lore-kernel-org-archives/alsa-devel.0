From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: adau1761: Mark expected switch
 fall-though
Date: Thu, 9 Aug 2018 13:19:11 +0200
Message-ID: <4934d9ae-96df-288b-2a7c-76aaa89246fe@metafoo.de>
References: <20180808192213.GA27872@embeddedor.com>
 <20180809093100.GC6132@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809093100.GC6132@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 08/09/2018 11:31 AM, Mark Brown wrote:
> On Wed, Aug 08, 2018 at 02:22:13PM -0500, Gustavo A. R. Silva wrote:
> 
>> @@ -518,7 +518,8 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_component *component)
>>  			ARRAY_SIZE(adau1761_jack_detect_controls));
>>  		if (ret)
>>  			return ret;
>> -	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE: /* fallthrough */
>> +		/* fall through */
>> +	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE:
>>  		ret = snd_soc_dapm_add_routes(dapm, adau1761_no_dmic_routes,
>>  			ARRAY_SIZE(adau1761_no_dmic_routes));
>>  		if (ret)
> 
> Again, are you *sure* here?

Well, it says so in the comment next to it :)

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
