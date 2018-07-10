From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
Date: Tue, 10 Jul 2018 11:59:26 +0100
Message-ID: <ed7aa899-c8c8-f878-61ce-21af07b50fa7@linaro.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
 <20180709124117.GG16082@sirena.org.uk>
 <887331ff-8892-66a7-20bc-0fce447c792f@linaro.org>
 <20180709163326.GI16082@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709163326.GI16082@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/07/18 17:33, Mark Brown wrote:
> On Mon, Jul 09, 2018 at 03:02:11PM +0100, Srinivas Kandagatla wrote:
>> On 09/07/18 13:41, Mark Brown wrote:
>>>> AFAIU, The issue with that mechanism or EPROBEDEFER is that it works only
> 
>>> This is not the case, the card will be unbound at the ASoC level when
>>> any of the components are removed and then probed again when they
>>> reappear.
> 
>> I did try this and It works only for first time! May be am missing
>> something!
> 
>> snd_soc_component_del_unlocked() unregisters the sound card totally. so for
>> the second time (After DSP stop) there is no registered sound card in
>> place.. Am not sure how this is supposed to work?
> 
>> The reason I think it works for the first time is because of EPROBEDEFER
>> from the machine driver.
> 
> Ugh, right - we ripped out that code because there's no sensible use
> case for it so now we don't keep the cards on a list.  The expectation
> is that if someone is going around removing bits of the card they can
> probably figure out that they should be removing the card first.
> 
> In any case the place to implement this is in the core, there's nothing
> special about your cards here.  Either the core should be using the
> component framework or the card list should be resurrected and we open
> code it.  This isn't something that's unique to your device.
I totally agree with you, this functionality belongs to core!

I will explore both options and see how it goes.

thanks,
srini
> 
