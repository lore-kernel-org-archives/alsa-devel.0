From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 07/13] slimbus: Add support for 'clock-pause' feature
Date: Fri, 24 Nov 2017 14:39:41 +0000
Message-ID: <4c0c8dae-fad2-8e95-c12f-cb5542fecb95@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-8-srinivas.kandagatla@linaro.org>
 <20171123072800.z2pkmelom374zr63@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171123072800.z2pkmelom374zr63-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Thanks for the Review,

On 23/11/17 07:28, Charles Keepax wrote:
> On Wed, Nov 15, 2017 at 02:10:37PM +0000, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> Per slimbus specification, a reconfiguration sequence known as
>> 'clock pause' needs to be broadcast over the bus while entering low-
>> power mode. Clock-pause is initiated by the controller driver.
>> To exit clock-pause, controller typically wakes up the framer device.
>> Since wakeup precedure is controller-specific, framework calls it via
>> controller's function pointer to invoke it.
>>
>> Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>> +/**
>> + * struct slim_sched: Framework uses this structure internally for scheduling.
> 
> Missing kernel doc for clkgear here.
Will add that in next version.

> 
>> + * @clk_state: Controller's clock state from enum slim_clk_state
>> + * @pause_comp: Signals completion of clock pause sequence. This is useful when
>> + *	client tries to call slimbus transaction when controller is entering
>> + *	clock pause.
>> + * @m_reconf: This mutex is held until current reconfiguration (data channel
>> + *	scheduling, message bandwidth reservation) is done. Message APIs can
>> + *	use the bus concurrently when this mutex is held since elemental access
>> + *	messages can be sent on the bus when reconfiguration is in progress.
>> + */
>> +struct slim_sched {
>> +	int			clkgear;
>> +	enum slim_clk_state	clk_state;
>> +	struct completion	pause_comp;
>> +	struct mutex		m_reconf;
>> +};
> 
> Thanks,
> Charles
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
