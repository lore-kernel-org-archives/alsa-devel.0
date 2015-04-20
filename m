From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] extcon: arizona: Add support for
	select accessory detect mode when headphone detection"
Date: Mon, 20 Apr 2015 09:29:18 +0100
Message-ID: <20150420082918.GF3480@opensource.wolfsonmicro.com>
References: <1429259579-16563-1-git-send-email-ideal.song@samsung.com> <1429259579-16563-2-git-send-email-ideal.song@samsung.com> <20150417090047.GC3480@opensource.wolfsonmicro.com> <20150420104514.5820fa93@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150420104514.5820fa93@songinha-Samsung-DeskTop-System>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 20, 2015 at 10:45:14AM +0900, Inha Song wrote:
> Hi,
> 
> Thanks for your comments,
> 
> 
> On Fri, 17 Apr 2015 10:00:47 +0100
> Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> 
> > On Fri, Apr 17, 2015 at 05:32:58PM +0900, Inha Song wrote:
> > > This patch add support for select accessory detect mode to HPDETL or HPDETR.
> > > Arizona provides a headphone detection circuit on the HPDETL and HPDETR pins
> > > to measure the impedance of an external load connected to the headphone.
> > > 
> > > Depending on board design, headphone detect pins can change to HPDETR or HPDETL.
> > > 
> > > Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > 
> > > +
> > >  	info->micvdd = devm_regulator_get(&pdev->dev, "MICVDD");
> > >  	if (IS_ERR(info->micvdd)) {
> > >  		ret = PTR_ERR(info->micvdd);
> > > @@ -1338,6 +1359,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
> > >  
> > >  	arizona_extcon_set_mode(info, 0);
> > >  
> > > +	if (arizona->pdata.hpdet_channel)
> > > +		info->hpdet_channel = ARIZONA_ACCDET_MODE_HPR;
> > > +	else
> > > +		info->hpdet_channel = ARIZONA_ACCDET_MODE_HPL;
> > > +
> > 
> > Just move the two defines in include/dt-bindings/mfd/arizona.h
> > and have the pdata get set directly to one of the values.
> 
> Ok, I agree. But I have a question.
> Should I also move ACCDET_MODE_MIC define to dt-bindings header?
> 

Yeah I think move that over too, there is a reasonable chance it
will be need as part of the binding at some point in the future.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
