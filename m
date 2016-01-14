From: Caleb Crome <caleb-EebDDntmC0DYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Thu, 14 Jan 2016 13:26:24 -0800
Message-ID: <CAG5mAdwJ+VznMp5mUVTufa_wW-corc6qXGbqskz8LGqeG5Z1kw@mail.gmail.com>
References: <1452788982-11583-1-git-send-email-caleb@crome.org> <20160114201858.GA17567@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160114201858.GA17567@Asurada-Nvidia>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Xiubo Li <Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 12:18 PM, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jan 14, 2016 at 08:29:42AM -0800, Caleb Crome wrote:
>> Tuning the SSI fifo watermark & maxburst settings needs to be
>> optimized differently depending on the demands on the system.  The
>> current default of 2 is too low for high data-rate systems.  This
>> patch maintains exactly the same behavior by default (i.e defaults to
>> 2), but adds device tree options to set maxburst & fifo depth from the
>> device tree.  This is necessary because a setting of 2 simply doesn't
>> work at higher data rates.
>
>> @@ -61,6 +61,16 @@ Optional properties:
>>  - fsl,mode:         The operating mode for the AC97 interface only.
>>                      "ac97-slave" - AC97 mode, SSI is clock slave
>>                      "ac97-master" - AC97 mode, SSI is clock master
>> +- fsl,fifo-watermark: Sets the fifo watermark.  The default is
>> +                    fifo_depth-2 words, meaning 'initiate dma transfer
>> +                    when 2 words are left in the fifo'.  At higher
>> +                    data rates (48kHz, 16-channels for example), this
>> +                    causes silent but deadly DMA xruns and channel
>> +                    slips.  For 15 word FIFOs (like on MX5, MX6) 8 is
>> +                    a good value when running at high data rates
>> +- fsl,dma-maxburst: sets the max number of words to transfer in DMA.
>> +                    This defaults to the same value as
>> +                    fsl,fifo-watermark.
>
> I think DT maintainers may not give a consent towards these two
> properties as they are not to describe the hardware but to hack
> software configurations. (And it seems you haven't CCed them.)
>

Yeah, I thought I'd just ask alsa first, rather than send to DT
maintainers.  Is it preferable to just send to everybody that
get_maintainers spits out even for an RFC?


> I forgot which values you've figured out for these two properties,
> but I think those two values should work for normal cases as well:
> as SSI only has limited FIFO depth, it won't hurt (increasing too
> much latency) even if using a higher watermark configuration imo.
> So it could be a good idea to use optimized settings for all use
> cases and let other users test it.
>
> Nicolin


As for optimal settings, I finally came to a setting of 4 for depth &
maxburst, which will result in more DMA requests, but it's the only
way that works at 48kHz for me.  The default settings is 13 (15 - 2)
for the ones of the 15 item fifo, which is a pretty dramatic
difference.  I just don't know if other chips will behave badly in
that case.

I'd be happy to just submit a patch that sets it to 4 if we think
that's the right way to go.

-Caleb
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
