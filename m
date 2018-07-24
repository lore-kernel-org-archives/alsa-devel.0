From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 07/12] ASoC: wcd9335: add CLASS-H Controller support
Date: Tue, 24 Jul 2018 13:05:27 +0100
Message-ID: <7c54601c-f445-99d6-9092-2fccf16cbd24@linaro.org>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-8-srinivas.kandagatla@linaro.org>
 <20180724115908.GC2414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724115908.GC2414@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review!

On 24/07/18 12:59, Mark Brown wrote:
> On Mon, Jul 23, 2018 at 04:54:05PM +0100, Srinivas Kandagatla wrote:
> 
>> +static inline int wcd_clsh_get_int_mode(struct wcd_clsh_ctrl *ctrl,
>> +					int clsh_state)
>> +{
>> +	int mode;
>> +
>> +	if ((clsh_state != WCD_CLSH_STATE_EAR) &&
>> +	    (clsh_state != WCD_CLSH_STATE_HPHL) &&
>> +	    (clsh_state != WCD_CLSH_STATE_HPHR) &&
>> +	    (clsh_state != WCD_CLSH_STATE_LO))
>> +		mode = CLS_NONE;
>> +	else
>> +		mode = ctrl->interpolator_modes[ffs(clsh_state)];
>> +
>> +	return mode;
> 
> This looks like it wants to be a switch statement.
Yep, Will do that in next version.

> 
>> +static void wcd_clsh_state_hph_lo(struct wcd_clsh_ctrl *ctrl, int req_state,
>> +				  bool is_enable, int mode)
>> +{
>> +	struct snd_soc_component *comp = ctrl->comp;
>> +	int hph_mode = 0;
>> +
>> +	if (is_enable) {
>> +		/*
>> +		 * If requested state is LO, put regulator
>> +		 * in class-AB or if requested state is HPH,
>> +		 * which means LO is already enabled, keep
>> +		 * the regulator config the same at class-AB
>> +		 * and just set the power modes for flyback
>> +		 * and buck.
>> +		 */
>> +		if (req_state == WCD_CLSH_STATE_LO)
>> +			wcd_clsh_set_buck_regulator_mode(comp, CLS_AB);
> 
> This seems like there's a pretty confusing state machine, or possibly
> that we might end up in different states depending on how we transition.
> Whatever is going on it really feels like this code is more complex than
> it needs to be.  Some of this is the use of lots of nested if statements,
> some of it is the lack of any clear description of what we're trying to
> achieve.  It's hard to tell if the code is doing what's expected because
> it's hard to tell what it is expected to do.

I agree, I will rework and simplify this code/state-machine before 
posting next version!
> 
>> +		else {
> 
> If there's braces on one side of an if/else there should be braces on
> both sides.
Opps! will fix that and any such instances in next version!

> 
>> +			if (req_state == WCD_CLSH_STATE_HPHL)
>> +				snd_soc_component_update_bits(comp,
>> +					WCD9XXX_A_CDC_RX1_RX_PATH_CFG0,
>> +					WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
>> +					WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
>> +			if (req_state == WCD_CLSH_STATE_HPHR)
>> +				snd_soc_component_update_bits(comp,
>> +					WCD9XXX_A_CDC_RX2_RX_PATH_CFG0,
>> +					WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
>> +					WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
>> +		}
> 
> Switch statement?
Okay!

thanks,
srini
> 
