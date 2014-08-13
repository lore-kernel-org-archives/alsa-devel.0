From: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] mfd: arizona: Add support for	INn_MODE
 register control
Date: Wed, 13 Aug 2014 09:26:09 +0900
Message-ID: <20140813092609.35a98034@songinha-Samsung-DeskTop-System>
References: <20140809173138.767b97fd@songinha-Samsung-DeskTop-System>
 <20140812082811.GB15833@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20140812082811.GB15833-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi, Charles.

Thanks for your review.

On Tue, 12 Aug 2014 09:28:11 +0100
Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:

> On Sat, Aug 09, 2014 at 05:31:38PM +0900, Inha Song wrote:
> > Some boards need to set the INn_MODE[1:0] register to change
> > the input signal patch. This wlf,inmode property is optional.
> > If present values must be specified by the number of
> > ARIZONA_MAX_INPUT.
> > 
> > Example:
> >    - wlf,inmode = <2 0 2 0>;	/* IN1, IN3 use DMIC */
> > 
> > Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/mfd/arizona-core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> > index 10a0cb9..4b2eb73 100644
> > --- a/drivers/mfd/arizona-core.c
> > +++ b/drivers/mfd/arizona-core.c
> > @@ -560,6 +560,10 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
> >  			ret);
> >  	}
> >  
> > +	of_property_read_u32_array(arizona->dev->of_node,
> > +					 "wlf,inmode",
> > +					 arizona->pdata.inmode,
> > +					 ARRAY_SIZE(arizona->pdata.inmode));
> 
> Might be better to allow the device tree to be shorter than the
> array in pdata, should this get expanded on future devices.
> 

OK, I will fix in v2 to use "of_property_count_u32_elems" and "of_property_read_u32_index".

Best regards,
Inha Song.

> Thanks,
> Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
