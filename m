From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 03/11] ASoC: core: Add widget
	SND_SOC_DAPM_CLOCK_SUPPLY
Date: Wed, 9 May 2012 09:55:54 +0200
Message-ID: <4FAA230A.7060407@stericsson.com>
References: <1336485400-27150-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120508154027.GY15893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id A7E4D2454E
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 09:56:10 +0200 (CEST)
In-Reply-To: <20120508154027.GY15893@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 05/08/2012 05:40 PM, Mark Brown wrote:

> On Tue, May 08, 2012 at 03:56:40PM +0200, Ola Lilja wrote:
> 
>> +{
>> +	if (SND_SOC_DAPM_EVENT_ON(event))
>> +		return clk_enable(w->priv);
>> +	else {
>> +		clk_disable(w->priv);
>> +		return 0;
> 
> Coding style - you need more { }.   This also all needs to be
> conditionally complied for the many platforms that don't provide the
> clock API.


if (clk_enable)
	return clk_enable(w->priv);
else
	return <some error>;

?

> 
> 
>> +	case snd_soc_dapm_clock_supply:
>> +		w->priv = (w->shift) ? clk_get_sys(w->name, NULL) :
>> +				clk_get(dapm->dev, w->name);
> 
> I don't think supporting clk_get_sys() is a particularly good idea
> here...  Also, I think Liam was wanting to add per-user data to the
> widget rather than reuse the priv pointer.


OK, so how can I solve the fact that we have one clock that is gotten with
clk_get_sys()?
The priv-pointer was reused for the delay in the regulator-supply, so I assumed
that it was ok here as well. How should I do it so that it is OK with you, then?

> 
>> + /**
>> + * snd_soc_dapm_get_power_status - get widget power status
>> + * @dapm: DAPM context
>> + * @pin: Widget name
>> + *
>> + * Get widget power status - Enabled or disabled.
>> + *
>> + * Returns -1 for failure.
>> + * Returns 0 if disabled.
>> + * Returns 1 if enabled.
>> + */
>> +int snd_soc_dapm_get_power_status(struct snd_soc_dapm_context *dapm,
>> +				const char *pin)
> 
> This appears to be *nothing* to do with the rest of the patch!  It's
> also not clear what it's for.


It is for the debugging in our driver, using it to get the status of our clocks
so that we can make sure that the correct clocks are enabled/disabled at certain
points that we find useful.
I named it get_power_status instead of get_clock_status, just because I thought
you would complain that get_clock_status was using the ->power, which is not
specific to just clock-widgets.
