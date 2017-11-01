From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch v6 1/7] slimbus: Device management on SLIMbus
Date: Wed, 1 Nov 2017 16:08:06 -0700
Message-ID: <20171101230806.GD28761@minitux>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171017062332.GS1165@minitux>
 <1a1d2777-be69-98ca-afba-0ffd0e3dd80f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1a1d2777-be69-98ca-afba-0ffd0e3dd80f-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gong.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kheitke-hxvC4TZJLZFWk0Htik3J/w@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed 18 Oct 09:38 PDT 2017, Srinivas Kandagatla wrote:
> On 17/10/17 07:23, Bjorn Andersson wrote:
> > On Fri 06 Oct 08:51 PDT 2017, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
[..]
> > > +static int slim_device_remove(struct device *dev)
> > > +{
> > > +	struct slim_device *sbdev;
> > > +	struct slim_driver *sbdrv;
> > > +	int status = 0;
> > > +
> > > +	sbdev = to_slim_device(dev);
> > > +	if (!dev->driver)
> > > +		return 0;
> > > +
> > > +	sbdrv = to_slim_driver(dev->driver);
> > > +	if (sbdrv->remove)
> > > +		status = sbdrv->remove(sbdev);
> > > +
> > > +	mutex_lock(&sbdev->report_lock);
> > > +	sbdev->notified = false;
> > > +	if (status == 0)
> > > +		sbdev->driver = NULL;
> > > +	mutex_unlock(&sbdev->report_lock);
> > > +	return status;
> > 
> > device_unregister() will call device_del() which will end up in
> > __device_release_driver() which will call this function. Upon returning
> > from this function the core expect the bus to have cleaned up after the
> > dev (normally by calling drv->remove(dev)).
> > 
> > It will completely ignore the return value and continue tearing down the
> > rest of the core resources, e.g. three lines down it will
> > devres_release_all().
> > 
> > 
> > So you have the option of sleeping, while waiting for stuff to be
> > aborted/finished and then you need to clean things up.
> > 
> > The slim_device object itself will stick around until all references are
> > dropped though.
> 
> So you are suggesting that we make slim_driver remove not return anything?
> 

Yes.

Having the opportunity of failing remove() causes driver writers to
expect that they can fail, with the result of things not being torn
down properly.

Note that right after remove() returns devm_* resources will be
released, so anything that is not torn down and for some reason later
access allocated resources would cause issues.

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
