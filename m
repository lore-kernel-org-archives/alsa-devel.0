From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 4/6] ASoC: Intel: Skylake: Register clock
 device and ops
Date: Fri, 8 Sep 2017 08:41:54 -0500
Message-ID: <77992acc-bf07-0c59-1429-74c5162dbd0e@linux.intel.com>
References: <1504794565-19168-1-git-send-email-subhransu.s.prusty@intel.com>
 <1504794565-19168-5-git-send-email-subhransu.s.prusty@intel.com>
 <6e21a038-96d4-b58d-b1c7-ba5a5f32e7a8@linux.intel.com>
 <20170908033135.GB19877@subhransu-desktop>
 <20170908050120.GC19877@subhransu-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170908050120.GC19877@subhransu-desktop>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, harshapriya.n@intel.com, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 9/8/17 12:01 AM, Subhransu S. Prusty wrote:
> On Fri, Sep 08, 2017 at 09:01:36AM +0530, Subhransu S. Prusty wrote:
>> On Thu, Sep 07, 2017 at 08:48:38PM -0500, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 09/07/2017 09:29 AM, Subhransu S. Prusty wrote:
>>>> From: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
>>>>
>>>> Create a platform device and register the clock ops. Clock
>>>> prepare/unprepare are used to enable/disable the clock as the IPC will be
>>>> sent in non-atomic context. The clk set_dma_control IPC structures are
>>>> populated during the set_rate callback and IPC is sent to enable the clock
>>>> during prepare callback.
>>>>
>>> [snip]
>>>> +
>>>> +static int skl_clk_prepare(void *pvt_data, u32 id, unsigned long rate)
>>>> +{
>>>> +	struct skl *skl = pvt_data;
>>>> +	struct skl_clk_rate_cfg_table *rcfg;
>>>> +	int vbus_id, clk_type, ret;
>>>> +
>>>> +	clk_type = skl_get_clk_type(id);
>>>> +	if (clk_type < 0)
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = skl_get_vbus_id(id, clk_type);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	vbus_id = ret;
>>>> +
>>>> +	rcfg = skl_get_rate_cfg(skl_ssp_clks[id].rate_cfg, rate);
>>>> +	if (!rcfg)
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = skl_send_clk_dma_control(skl, rcfg, vbus_id, clk_type, true);
>>>> +
>>>> +	return ret;
>>>> +}
>>> In this patchset, the clocks are configured from the machine driver,
>>> and the enable/disable conveniently placed in
>>> platform_clock_control() or hw_params(), where the DSP is most
>>> likely active.
>>> If you expose a clock, codec driver implementers may want to use
>>> them directly instead of relying on a machine driver. A number of
>>> existing codecs do use the clk API, so there could be a case where a
>>> codec driver calls devm_clk_get and clk_prepare_enable(), without
>>> any ability to know what state the DSP is in.
>>> What happens then if the DSP is in suspend? Does this force it back
>>> to D0? Does the virtual clock driver return an error? Or are you
>>> using the clk API with some restrictions on when the clock can be
>>> configured?
>>
>> No, clk enable will not force the DSP to D0. So if the DSP is not active,
>> the IPC will timeout and error will be propagated to the caller.
> 
> Or may be it makes sense to enable the runtime pm for clk driver so that it
> can activate the DSP. I will check this.

I was thinking of another case: we should not make the assumption that 
there is always a platform clock control and a hw_params callback, e.g. 
when an external component seen as a dummy codec needs the mclk/bitclock 
at all times to drive a second-level set of audio devices. In those 
cases the machine driver will get/enable the clock at startup and it 
needs to remain on no matter what the DSP state is. That's probably 
another case for disabling runtime-pm for as long as the machine driver 
wants the clock.
