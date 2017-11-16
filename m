From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v7 03/13] slimbus: Add SLIMbus bus type
Date: Thu, 16 Nov 2017 21:44:26 +0530
Message-ID: <20171116161426.GA3187@localhost>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-4-srinivas.kandagatla@linaro.org>
 <20171116131814.GV3187@localhost>
 <e2fa6b56-965d-74e7-af2f-77baf0f50901@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e2fa6b56-965d-74e7-af2f-77baf0f50901-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 01:40:05PM +0000, Srinivas Kandagatla wrote:
> On 16/11/17 13:18, Vinod Koul wrote:
> >On Wed, Nov 15, 2017 at 02:10:33PM +0000, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> >
> >>+menuconfig SLIMBUS
> >>+	tristate "Slimbus support"
> >>+	help
> >>+	  Slimbus is standard interface between System-on-Chip and audio codec,
> >>+	  and other peripheral components in typical embedded systems.
> >>+
> >>+	  If unsure, choose N.
> >>+
> >>+if SLIMBUS
> >>+
> >>+# SlIMbus controllers
> >
> >Slimbus perhaps?
> >
> slimbus is specified as "SLIMbus" in the mipi specs, so I should probably
> stay with it and make it consistent across the patchset.

Yeah this I though was a first use, so I though this was a typo. I think
Documentation should use the spec term (like SoundWire) and code should pick
anyone and just be consistent on it.

> >>+static int slim_device_match(struct device *dev, struct device_driver *drv)
> >>+{
> >>+	struct slim_device *sbdev = to_slim_device(dev);
> >>+	struct slim_driver *sbdrv = to_slim_driver(drv);
> >>+
> >>+	return slim_match(sbdrv->id_table, sbdev) != NULL;
> >
> >return !!slim_match() ?

I guess you missed this one..

> >>+struct slim_device_id {
> >>+	__u16 manf_id, prod_code;
> >>+	__u8 dev_index, instance;
> >>+
> >>+	/* Data private to the driver */
> >>+	kernel_ulong_t driver_data;
> >
> >As Takashi pointed out in SDW patches, this needs to be aligned.
> >
> Okay, I will make sure that driver_data is aligned.

You may want to look at comments and disucssion on the SoundWire patches

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
