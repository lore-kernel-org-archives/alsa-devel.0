From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: msm8916-wcd-digital: Add sidetone support
Date: Thu, 6 Jun 2019 13:17:43 +0100
Message-ID: <db763118-b3d6-cddc-c8ea-965d67f8a798@linaro.org>
References: <20190606114002.17251-1-srinivas.kandagatla@linaro.org>
 <20190606115441.GB2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606115441.GB2456@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 06/06/2019 12:54, Mark Brown wrote:
> On Thu, Jun 06, 2019 at 12:40:02PM +0100, Srinivas Kandagatla wrote:
> 
>> +	default:
>> +		pr_err("%s: event = %d not expected\n", __func__, event);
>> +	}
> 
> dev_err() please (and a break; as well, it isn't strictly needed but
> stops people having to check that it isn't needed).
> 
Sure I will add break.
I think the message itself is not required here as we would never come 
to this path.
>> +	SOC_SINGLE_EXT("IIR1 Enable Band1", IIR1, BAND1, 1, 0,
>> +	msm8x16_wcd_get_iir_enable_audio_mixer,
>> +	msm8x16_wcd_put_iir_enable_audio_mixer),
> 
> The indentation here is *really* messed up.  What are these controls,
> with names like "Enable" they sound like on/off controls in which case
> they should be standard Switch controls.
Yes, Switch controls should work, I will try that.

--srini
> 
