From: Caleb Crome <caleb-EebDDntmC0DYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Thu, 14 Jan 2016 20:56:31 -0800
Message-ID: <CAG5mAdyH1FOYCxYM14fknnRmaSBERMLx_k_D+RCUMiSjWMRvBA@mail.gmail.com>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia> <CAG5mAdwJ+VznMp5mUVTufa_wW-corc6qXGbqskz8LGqeG5Z1kw@mail.gmail.com>
 <20160115024534.GB29132@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160115024534.GB29132@Asurada-Nvidia>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Xiubo Li <Xiubo.Lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 6:45 PM, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jan 14, 2016 at 01:26:24PM -0800, Caleb Crome wrote:
>
>> As for optimal settings, I finally came to a setting of 4 for depth &
>> maxburst, which will result in more DMA requests, but it's the only
>> way that works at 48kHz for me.  The default settings is 13 (15 - 2)
>> for the ones of the 15 item fifo, which is a pretty dramatic
>> difference.  I just don't know if other chips will behave badly in
>> that case.
>
> What's your final configuration for TFWM0 bits, 4?

Yes, a value of 4 for my use case:  i.MX6 @ 768000 words/second (48khz
* 16 channels).

Also, works at 8kHz, 16kHz 32 kHz.

A setting of 8 does not work reliably at 48kHz but does work at 8, 16 and 32.

-caleb
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
