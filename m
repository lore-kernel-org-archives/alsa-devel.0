From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 04/13] slimbus: core: Add slim controllers support
Date: Mon, 27 Nov 2017 11:22:15 +0530
Message-ID: <20171127055215.GQ3187@localhost>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-5-srinivas.kandagatla@linaro.org>
 <20171116164233.GB3187@localhost>
 <55794ca5-b70a-4866-1e80-bc0e78880c50@linaro.org>
 <20171117044222.GK3187@localhost>
 <20171117081322.GF10671@kroah.com>
 <64797182-9244-e6e7-8044-dbc404cdda7c@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <64797182-9244-e6e7-8044-dbc404cdda7c-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 20, 2017 at 06:47:58AM +0000, Srinivas Kandagatla wrote:
> >>>thanks for the comments.
> >>>
> >>>
> >>>On 16/11/17 16:42, Vinod Koul wrote:
> >>>>On Wed, Nov 15, 2017 at 02:10:34PM +0000,srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org  wrote:
> >>>>
> >>>>>+static void slim_dev_release(struct device *dev)
> >>>>>+{
> >>>>>+	struct slim_device *sbdev = to_slim_device(dev);
> >>>>>+
> >>>>>+	put_device(sbdev->ctrl->dev);
> >>>>which device would that be?
> >>>This is controller device
> >>>
> >>>>>+static int slim_add_device(struct slim_controller *ctrl,
> >>>>>+			   struct slim_device *sbdev,
> >>>>>+			   struct device_node *node)
> >>>>>+{
> >>>>>+	sbdev->dev.bus = &slimbus_bus;
> >>>>>+	sbdev->dev.parent = ctrl->dev;
> >>>>>+	sbdev->dev.release = slim_dev_release;
> >>>>>+	sbdev->dev.driver = NULL;
> >>>>>+	sbdev->ctrl = ctrl;
> >>>>>+
> >>>>>+	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
> >>>>>+				  sbdev->e_addr.manf_id,
> >>>>>+				  sbdev->e_addr.prod_code,
> >>>>>+				  sbdev->e_addr.dev_index,
> >>>>>+				  sbdev->e_addr.instance);
> >>>>>+
> >>>>>+	get_device(ctrl->dev);
> >>>>is this controller device and you ensuring it doesnt go away while you have
> >>>>slaves on it?
> >>>Yes.
> >>I thought since you are marking ctrl->dev as parent, the device core should
> >>ensure that parent doesn't go off when you have child device?
> >>
> >>Greg, is that understanding correct, if so we may not need these calls.
> >That understanding should be correct, as the reference count is
> >incremented on the parent when a child is added.
> >
> >It would be trivial for this to be tested, and yes, I am pretty sure you
> >don't need this call.
> 
> Thanks for suggestion, I will remove this in next version.

I think it might be helpful to test the assumption as Greg noted :)

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
