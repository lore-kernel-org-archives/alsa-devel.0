From: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 2/2] mfd: arizona: Update DT binding to
 support INn_MODE init_data
Date: Tue, 19 Aug 2014 10:46:11 +0900
Message-ID: <20140819104611.121c283b@songinha-Samsung-DeskTop-System>
References: <20140818200009.12a52dfa@songinha-Samsung-DeskTop-System>
 <20140818142945.GD7556@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20140818142945.GD7556-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi, Charles.
Thanks for your review.

On Mon, 18 Aug 2014 15:29:45 +0100
Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:

> On Mon, Aug 18, 2014 at 08:00:09PM +0900, Inha Song wrote:
> > This patch update DT binding to support INn_MODE init_data. Each
> > input signal path can be configurated either as a Analogue or
> > Digital using the INn_MODE registers.
> > 
> > Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/arizona.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
> > index 5c7e723..0064b21 100644
> > --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> > +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> > @@ -42,6 +42,14 @@ Optional properties:
> >      the chip default will be used.  If present exactly five values must
> >      be specified.
> >  
> > +  - wlf,inmode : A list of INn_MODE register values, where n is the number
> > +    of input signals. Each input signal path can be configurated either as a
> > +    Analogue or Digital using the INn_MODE registers. If absent, INn_MODE
> 
> I would replace the second sentence here with something like
> "Valid values are 0 (Differential), 1 (Single-ended) and 2 (Digital
> Microphone)."
> 

OK, I will fix it like this:

- wlf,inmode : A list of INn_MODE register values, where n is the number
  of input signals. Valid values are 0 (Differential), 1 (Single-ended) and
  2 (Digital Microphone). If absent, INn_MODE registers.........

Best regards,
Inha Song.

> Thanks,
> Charles
> 
> > +    registers set to 0 by default. If present, values must be specified less
> > +    than or equal to the number of input singals. If values less than the
> > +    number of input signals, elements that has not been specifed are set to 0
> > +    by default.
> > +
> >    - DCVDD-supply, MICVDD-supply : Power supplies, only need to be specified if
> >      they are being externally supplied. As covered in
> >      Documentation/devicetree/bindings/regulator/regulator.txt
> > -- 
> > 2.0.0.390.gcb682f8
> > 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
