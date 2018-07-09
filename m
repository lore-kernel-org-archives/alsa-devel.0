From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
Date: Mon, 9 Jul 2018 13:34:42 +0100
Message-ID: <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709111437.GB16082@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/07/18 12:14, Mark Brown wrote:
>> +static const struct component_master_ops sdm845_ops = {
>> +	.bind = sdm845_bind,
>> +	.unbind = sdm845_unbind,
>> +};
> Why is this using the component stuff rather than the normal support for
> finding the components of audio cards?
Could you elaborate this please?
Do you mean something like snd_soc_lookup_component()?  Or in general 
audio card binding during startup.

AFAIU, The issue with that mechanism or EPROBEDEFER is that it works 
only for first time.. for the second time(restart usecase) there are no 
hooks like bind/unbind.

The reason why we chose to use component framework is because of bind 
and unbind functionality. Am more than happy to rework on this if there 
is already a alternative mechanism in ASoC which can provide this.

The design we are aiming at is:
1> audio card to deregister when any of the DSP audio services go DOWN.
2> re-register audio card only when all the DSP audio services are UP.

Usecase is something like DSP start-stop or restart due to fatal errors.

thanks,
srini
