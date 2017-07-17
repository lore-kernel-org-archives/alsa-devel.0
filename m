From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/3] ASoC: codecs: msm8916-wcd-digital: add support to
 set_sysclk
Date: Mon, 17 Jul 2017 15:52:40 +0100
Message-ID: <47b03a33-a981-a27a-562e-af4d665cd219@linaro.org>
References: <20170717135410.26812-1-srinivas.kandagatla@linaro.org>
 <20170717135410.26812-2-srinivas.kandagatla@linaro.org>
 <20170717144450.lk7xfnwtkvt26qvw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717144450.lk7xfnwtkvt26qvw@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 17/07/17 15:44, Mark Brown wrote:
> On Mon, Jul 17, 2017 at 03:54:08PM +0200, srinivas.kandagatla@linaro.org wrote:
> 
>> +static int msm8916_set_dai_sysclk(struct snd_soc_dai *dai,
>> +				 int clk_id, unsigned int freq, int dir)
>> +{
>> +	struct msm8916_wcd_digital_priv *p = dev_get_drvdata(dai->codec->dev);
>> +
>> +	clk_set_rate(p->mclk, freq);
> 
> This is ignoring the return value.
> 
Thanks, I will take care of it in next version.

--srini
