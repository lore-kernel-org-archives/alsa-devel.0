From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH] ASoC: MAX9860: new driver
Date: Thu, 12 May 2016 10:24:11 +0200
Message-ID: <6fc2f0ed-6193-c99f-bcf7-7898029dab73@axentia.se>
References: <1462892797-1147-1-git-send-email-peda@axentia.se>
 <20160511152950.GL6261@sirena.org.uk>
 <be1f0f5c-5dbe-65f8-d55c-df07a92a558e@axentia.se>
 <20160511205353.GV6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160511205353.GV6261-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 2016-05-11 22:53, Mark Brown wrote:
> On Wed, May 11, 2016 at 10:28:12PM +0200, Peter Rosin wrote:
>> On 2016-05-11 17:29, Mark Brown wrote:
>>> On Tue, May 10, 2016 at 05:06:37PM +0200, Peter Rosin wrote:
> 
>>>> +		if (master) {
>>>> +			switch (max9860->pclk_rate) {
>>>> +			case 12000000:
>>>> +				sysclk = MAX9860_FREQ_12MHZ;
>>>> +				break;
>>>> +			case 13000000:
>>>> +				sysclk = MAX9860_FREQ_13MHZ;
>>>> +				break;
>>>> +			case 19200000:
>>>> +				sysclk = MAX9860_FREQ_19_2MHZ;
>>>> +				break;
>>>> +			}
> 
>>> What if we have another PCLK rate?
> 
>> In that case the sysclk variable will remain cleared (0) and the
>> code that follows will trigger the PLL section with the N divider
>> for clock master mode (that mode is always used in clock slave mode).
> 
> The code needs to make it clear that this is an intentional fallthrough,
> an explicit default case would help a lot.

There was this comment above the two if statements leading into the switch
statement:

+	/*
+	 * Check if Integer Clock Mode is possible, but avoid it in slave mode
+	 * since we then do not know if lrclk is derived from pclk and the
+	 * datasheet mentions that the frequencies have to match exactly in
+	 * order for this to work.
+	 */
+	if (params_rate(params) == 8000 || params_rate(params) == 16000) {
+		if (master) {
+			switch (max9860->pclk_rate) {

Maybe it wasn't clear that this comment applied to the whole if-if-switch
block? Will it be good enough to extend that comment like this:

	/*
	 * Check if Integer Clock Mode is possible, but avoid it in slave mode
	 * since we then do not know if lrclk is derived from pclk and the
	 * datasheet mentions that the frequencies have to match exactly in
	 * order for this to work.
	 * If Integer Clock Mode is not possible, fall through to the code
	 * below utilizing PLL mode (using sysclk == 0 as trigger).
	 */

>>> We didn't go into cache only mode on suspend?  I'd also expect to see
>>> the regulators disabled over suspend and some system PM ops.
> 
>> Ooops, that is a leftover, and I think it can be removed. However, your
>> comment suggests that I have misunderstood the workings of
>> SND_SOC_DAPM_REGULATOR_SUPPLY. I thought dapm would take care of the
>> regulators (and the clocks for SND_SOC_DAPM_CLOCK_SUPPLY) so that
>> disabling regulators over suspend was handled by the asoc core?
> 
> It will disable the regulators but that's not going to end well if
> you're including core supplies required to maintain the register map,
> it'll disable before runtime suspend and enable after runtime resume.
> The regulator supply widget is intended for supplies that power
> particular components on the CODEC.

It is the DVDDIO supply that kills register content. I carefully left
that one out, and only added widgets for the AVDD and DVDD supplies.
If/when someone adds DVDDIO it indeed needs to be handled like you
suggest. Is DVDDIO support required to have an acceptable driver?

>>>> +	ret = clk_prepare_enable(mclk);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Failed to enable MCLK: %d\n", ret);
>>>> +		clk_put(mclk);
>>>> +		return ret;
>>>> +	}
> 
>>>> +	*mclk_rate = clk_get_rate(mclk);
> 
>>>> +	clk_disable_unprepare(mclk);
> 
>>> This is definitely confused too.  Enabling the clock to read the
>>> programmed frequency is at best odd, and obviously if we do get the rate
>>> this will ensure that MCLK is disabled which probably isn't ideal.
> 
>> This is the same situation as for the regulators, I thought dapm
>> handled it and would prep/enable clocks when they were needed?
> 
> That still doesn't explain the bouncing on and off here.

I just read the comment for clk_get_rate() in include/linux/clk.h

 * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
 *                This is only valid once the clock source has been enabled.

The driver needs to know the mclk rate, and it only needs the clock to
be running when the codec is in use, so do you suggest instead?

Cheers,
Peter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
