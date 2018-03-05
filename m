From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH] ASoC: dapm: add support to pinctrl dapm
Date: Mon, 5 Mar 2018 20:35:48 +0000
Message-ID: <21635274-1d7b-5ed9-6832-2e12fd844f7a@linaro.org>
References: <20180305123213.2045-1-srinivas.kandagatla@linaro.org>
 <20180305155208.GK8588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305155208.GK8588@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 05/03/18 15:52, Mark Brown wrote:
> On Mon, Mar 05, 2018 at 12:32:13PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>> +int dapm_pinctrl_event(struct snd_soc_dapm_widget *w,
>> +		       struct snd_kcontrol *kcontrol, int event)
>> +{
>> +	struct snd_soc_dapm_pinctrl_priv *priv = w->priv;
>> +	struct pinctrl *p = w->pinctrl;
>> +	struct pinctrl_state *s;
>> +
>> +	if (!p || !priv)
>> +		return -EIO;
>> +
>> +	soc_dapm_async_complete(w->dapm);
> 
> This doesn't look right - we're trying to synchronize with the DAPM
> async queue from something that should be run inside that very queue.
> What is this supposed to be doing?

I thought this is supposed to ensure that any pending asynchronous I/O 
is completed before touching pinctrl framework.

TBH, I have done this inline with regulators/clk dapm events.

--srini
> 
