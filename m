From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 2/2] sound: asoc: Adding support for STA529
	Audio Codec
Date: Mon, 21 Mar 2011 16:59:35 +0530
Message-ID: <4D87369F.6020104@st.com>
References: <1300361016-26242-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-3-git-send-email-rajeev-dlh.kumar@st.com>
	<20110317151743.GH31411@opensource.wolfsonmicro.com>
	<4D82F7D1.3070704@st.com>
	<20110318113923.GA14017@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog110.obsmtp.com (eu1sys200aog110.obsmtp.com
	[207.126.144.129])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CA2A24422
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 12:32:42 +0100 (CET)
In-Reply-To: <20110318113923.GA14017@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark

On 3/18/2011 5:09 PM, Mark Brown wrote:
> On Fri, Mar 18, 2011 at 11:42:33AM +0530, rajeev wrote:
>> On 3/17/2011 8:47 PM, Mark Brown wrote:
>>> On Thu, Mar 17, 2011 at 04:53:36PM +0530, Rajeev Kumar wrote:
> 
>>>> +/* reading from register cache: sta529 register value */
>>>> +static inline unsigned int
>>>> +sta529_read_reg_cache(struct snd_soc_codec *codec, u32 reg)
> 
>>> Use the generic register cache code - this looks to be a very 8 bit data
>>> 8 bit address map.
> 
>> Could you please explain little bit more
> 
> See sound/soc/soc-cache.c.  You should use snd_soc_set_cache_io() and
> the relevant fields in the CODEC driver rather than open coding all
> this.
>
OK

 
>>>> +	cache = codec->reg_cache;
>>>> +	for (i = 0; i < ARRAY_SIZE(sta529_reg); i++) {
>>>> +		data[0] = i;
>>>> +		data[1] = cache[i];
>>>> +		codec->hw_write(codec->control_data, data, NUM_OF_MSG);
>>>> +	}
> 
>>> You should be using the chip defaults for the most part and therefore
>>> should have no reason to write back to hardware in probe()
> 
>> Actually the default values at INIT are not working for all possible
>> play and record combination. I have kept the STA529 register combinations that
>> work well here and write the same to HW. 
> 
>> However if you insist, I would try to change them at run-time, rather
>> than writing to HW in probe()
> 
> The main problem here is that you are unconditionally overwriting the
> entire register map with hard coded magic numbers.  This is bad for
> documentation and is going to mean you're setting values which it is
> more appropriate to customise per system - for example, you will be
> updating all volume and routing controls in the device but the settings
> that make sense for one system are likely to not work for all systems.
> 
> Your register defaults should reflect the default hardware state and you
> should update anything you need to change with explicit changes that
> show exactly what's being altered rather than blanket writing every
> register.
> 
> Doing some updates in probe is fine if that is appropriate for those
> updates but they should be specific changes where the intended meaning
> is clear.
>

I agree. So should V2 implement a way in which the register settings desired by
STA529 (other than the default values) for PLAY and RECORD functionality are programmed
by means of a hw_params() call?

>>
>>>> +		.name = "sta529-codec",
> 
>>> Drop the -codec.
> 
>> I am using stream_name  as "STA529" in  machine driver,so it will create confusion. 
> 
> It won't the CODEC name doesn't get used for a stream name.
> 
>>>> +#define SPEAR_PCM_RATES		SNDRV_PCM_RATE_48000
>>>> +#define SPEAR_PCM_FORMAT	SNDRV_PCM_FMTBIT_S16_LE
> 
>>> These are for your CPU not for your CODEC, even if they're the same they
>>> should have different names.
> 
>> Ok, will be replace with SPEAR_RATES
> 
> That's still a problem - these should be STA529_RATES or similar.
> .
>
OK
Best Regards
Rajeev
