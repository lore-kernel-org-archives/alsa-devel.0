From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH 1/2] slimbus: stream: add stream support
Date: Mon, 25 Jun 2018 21:51:56 +0530
Message-ID: <20180625162156.GC2404@vkoul-mobl>
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
 <20180622125050.GO27187@vkoul-mobl>
 <a922d359-2096-48ed-c442-affc5b0c4ccf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a922d359-2096-48ed-c442-affc5b0c4ccf@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, sdharia@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, ctatlor97@gmail.com
List-Id: alsa-devel@alsa-project.org

On 25-06-18, 11:11, Srinivas Kandagatla wrote:

> > > +struct slim_stream_runtime *slim_stream_allocate(struct slim_device *dev,
> > > +						 const char *name)
> > > +{
> > > +	struct slim_stream_runtime *rt;
> > > +	unsigned long flags;
> > > +
> > > +	rt = kzalloc(sizeof(*rt), GFP_KERNEL);
> > > +	if (!rt)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	rt->name = kasprintf(GFP_KERNEL, "slim-%s", name);
> > > +	if (!rt->name) {
> > > +		kfree(rt);
> > > +		return ERR_PTR(-ENOMEM);
> > > +	}
> > > +
> > > +	rt->dev = dev;
> > > +	rt->state = SLIM_STREAM_STATE_ALLOCATED;
> > > +	spin_lock_irqsave(&dev->stream_list_lock, flags);
> > > +	list_add_tail(&rt->node, &dev->stream_list);
> > > +	spin_unlock_irqrestore(&dev->stream_list_lock, flags);
> > 
> > Any reason for _irqsave variant? Do you expect stream APIs to be called
> > from ISR?We can move to non irqsave variant here, as i do not see a case
> > where
> this list would be interrupted from irq context.

That's interesting can you please describe how?
Also, won't it be modified from bottom half...

> > > +/*
> > > + * slim_stream_enable() - Enable a prepared SLIMbus Stream
> > 
> > Do you want to check if it is already prepared ..?
> Yep, I think most of the code needs similar state machine check, I will add
> this in next version.

so if you are tying to snd stream states then I don't think you need a
state machine here. ALSA already does that for you so you can skip it :D

-- 
~Vinod
