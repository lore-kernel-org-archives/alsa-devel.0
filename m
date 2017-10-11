From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [Patch v6 2/7] slimbus: Add messaging APIs to
 slimbus framework
Date: Wed, 11 Oct 2017 15:54:36 +0530
Message-ID: <20171011102436.GH30097@localhost>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-3-srinivas.kandagatla@linaro.org>
 <20171011043814.GF30097@localhost>
 <aa117cb8-ba59-894c-5a82-1b38facfa841@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <aa117cb8-ba59-894c-5a82-1b38facfa841-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gong.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, kheitke-hxvC4TZJLZFWk0Htik3J/w@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 11, 2017 at 10:42:28AM +0100, Srinivas Kandagatla wrote:
> On 11/10/17 05:38, Vinod Koul wrote:
> >On Fri, Oct 06, 2017 at 05:51:31PM +0200, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> >
> >>  	mutex_init(&ctrl->m_ctrl);
> >>+	spin_lock_init(&ctrl->tx.lock);
> >>+	spin_lock_init(&ctrl->rx.lock);
> >
> >locks galore :) My assumption is that you want to optimize these? But given
> >that audio user is going to be serialized do we practically need two locks?
> >
> If we remove the locking, It will be issue if we have multiple devices in a
> component, which is common atleast with the codec which am looking at.

can you explian what you mean by a "device" here?

> >>+	switch (mc) {
> >>+	case SLIM_MSG_MC_REQUEST_VALUE:
> >>+	case SLIM_MSG_MC_REQUEST_INFORMATION:
> >
> >what does MC refer to?
> 
> Message Code.

isnt SLIM_MSG enough :D I think we cna get rid of MC here..

> >>+struct slim_val_inf {
> >>+	u16			start_offset;
> >>+	u8			num_bytes;
> >>+	u8			*rbuf;
> >>+	const u8		*wbuf;
> >
> >can we do read and write, if not it can be a buf which maybe rbuf or wbug
> >based on type
> With REQUEST_CHANGE_VALUE single command we can read old value at the same
> time we can write new value.

so that is a read modify write, correct? Is that implemented in HW, if so we
need to provide only write value

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
