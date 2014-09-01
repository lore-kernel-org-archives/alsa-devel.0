From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v5 1/2] mfd: arizona: Add support for
	INn_Mode register control
Date: Mon, 1 Sep 2014 10:03:20 +0100
Message-ID: <20140901090320.GA12043@opensource.wolfsonmicro.com>
References: <1409365639-5320-1-git-send-email-ideal.song@samsung.com> <1409365639-5320-2-git-send-email-ideal.song@samsung.com> <20140901083233.GC7374@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140901083233.GC7374@lee--X1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 01, 2014 at 09:32:33AM +0100, Lee Jones wrote:
> On Sat, 30 Aug 2014, Inha Song wrote:
> 
> > Some boards need to set the INn_MODE[1:0] register to change
> > the input signal patch. This wlf,inmode property is optional.
> > If present, values must be specified less than or equal to
> > the number of input singals. If values less than the number
> > of input signals, elements that has not been specifed are set
> > to 0 by default.
> > 
> > Example:
> >    - wlf,inmode = <2 0 2>;	/* IN1, IN3 use DMIC */
> > 
> > Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> > ---
> >  drivers/mfd/arizona-core.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> 
> That looks better.
> 
> Applied, thanks.
> 
> Charles,
>   Can you confirm your Reviewed-by for this version of the patch
>   please?

Yeah all looks fine to me.

Reviewed-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
