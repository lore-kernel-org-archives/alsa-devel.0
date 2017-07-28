From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 3/6] ASoC: codecs: msm8916-wcd-analog: move codec reset
 to probe
Date: Fri, 28 Jul 2017 15:06:43 +0100
Message-ID: <064a5aa7-0a87-7e7b-f263-c24cf66f459a@linaro.org>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
 <20170726003512.18965-4-srinivas.kandagatla@linaro.org>
 <20170728134013.vsneppa35kra77ot@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728134013.vsneppa35kra77ot@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 28/07/17 14:40, Mark Brown wrote:
> On Wed, Jul 26, 2017 at 02:35:09AM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch move the codec reset code from dai ops to codec probe, so
>> that the codec is not held in reset when headset detection block is
>> still active.
> 
> This means that the CODEC will no longer be held in reset (which
> presumably has a power benefit or something) even if jack detection
> isn't in use.  What most devices do is have things like this be
> controlled via the bias level or other power management functions and
> then have jack detection hold the CODEC out of the lowest power states
> when it's active.

This chip has two power sources for MBHC logic, one from mic bias which 
is used when we have active audio usecase, and other from internal 
current source which is for low-power state when no audio use case is 
active.

By default with the existing code uses internal current source which 
puts chip in low power state.


> 
