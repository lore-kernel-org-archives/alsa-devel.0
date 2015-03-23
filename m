From: Howard Mitchell <hm-n6SlHCM0l+K9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] ASoC:pcm512x: Make PLL lock output selectable via device
 tree.
Date: Mon, 23 Mar 2015 09:43:59 +0000
Message-ID: <550FE05F.6070204@hmbedded.co.uk>
References: <1426886563-10936-1-git-send-email-hm@hmbedded.co.uk> <20150322162409.GG6643@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150322162409.GG6643-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 22/03/15 16:24, Mark Brown wrote:
> On Fri, Mar 20, 2015 at 09:22:43PM +0000, Howard Mitchell wrote:
>
>> +	if (pcm512x->pll_lock) {
>> +                if (of_property_read_u32(np, "pll-lock", &val) >= 0) {
>> +                        if (val > 6) {
>> +                                dev_err(dev, "Invalid pll-lock\n");
>> +                                ret = -EINVAL;
>> +                                goto err_clk;
>> +                        }
>> +                        pcm512x->pll_lock = val;
>> +                }
> This breaks existing boards which rely on GPIO 4 being set as the lock
> output.  This is very unfortunate since it's a silly thing for the
> driver to default to but nontheless we should really continue to support
> them - at a guess Peter's board is relying on this, and even if it isn't
> someone else's might.
I take your point, but the reason I pushed this patch was that I wanted 
to use GPIO4 for pll-out and unfortunately because the pll-lock 
configuration is after the pll-out configuration it stomps on it. If I 
modify the patch to provide a default for pll-lock I will then be 
obliged to specify pll-lock on another GPIO. The pcm5122 has limited IO 
so being forced to have a GPIO for pll-lock seems wrong to me. A future 
user of the device may well decide to use the GPIOs for other purposes 
and therefore not want a pll-lock signal at all. Surely we should allow 
for that possibility?

Given that Peter has indicated that he'd be happy with this solution and 
that this code hasn't reached a published kernel would it be reasonable 
to go ahead with my current patch (happy to clean up the indent issues 
that Peter pointed out of course)?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
