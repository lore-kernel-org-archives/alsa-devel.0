From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v2 07/15] ASoC: qcom: q6asm: Add support to memory
 map and unmap
Date: Wed, 3 Jan 2018 11:39:16 -0800
Message-ID: <20180103193916.GZ478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-8-srinivas.kandagatla@linaro.org>
 <20180102054852.GP478@tuxbook>
 <4d1d17df-71a4-2896-29c1-9d033a2f3711@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4d1d17df-71a4-2896-29c1-9d033a2f3711-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed 03 Jan 08:26 PST 2018, Srinivas Kandagatla wrote:

> Thanks for your review comments.
> 
> On 02/01/18 05:48, Bjorn Andersson wrote:
> > On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
[..]
> > > +int q6asm_unmap_memory_regions(unsigned int dir, struct audio_client *ac)
> > > +{
> > > +	struct audio_port_data *port;
> > > +	int cnt = 0;
> > > +	int rc = 0;
> > > +
> > > +	mutex_lock(&ac->cmd_lock);
> > > +	port = &ac->port[dir];
> > > +	if (!port->buf) {
> > > +		mutex_unlock(&ac->cmd_lock);
> > > +		return 0;
> > 
> > Put a label right before the mutex_unlock below and return rc instead of
> > 0, then you can replace these two lines with "goto unlock"
> > 
> > > +	}
> > > +	cnt = port->max_buf_cnt - 1;
> > 
> > What if we mapped 1 period? Why shouldn't we enter the unmap path?
> > 
> It would enter into unmap path, as cnt  would be 0 for 1 period.
> 

You're right, I missed the = in the comparison, but I don't see a reason
to subtract 1. It seems like the max_buf_cnt might have been used
differently in the past?

I suggest that you drop the - 1 and change the comparison to cnt > 0, if
nothing else to not confuse me if I read this code again ;)

> > > +	if (cnt >= 0) {
[..]
> > > +int q6asm_map_memory_regions(unsigned int dir, struct audio_client *ac,
> > > +			     dma_addr_t phys,
> > > +			     unsigned int period_sz, unsigned int periods)
[..]
> > > +		ac->port[dir].max_buf_cnt = 0;
> > > +		kfree(buf);
> > > +		ac->port[dir].buf = NULL;
> > 
> > These operations are done without holding cmd_lock.
> > 
> I will revisit such instances where the buf is not protected.
> 

NB. I got the impression that cmd_lock was actually the port_lock in
most places.

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
