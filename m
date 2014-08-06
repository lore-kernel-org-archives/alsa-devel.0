From: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Date: Wed, 6 Aug 2014 10:42:37 +0800
Message-ID: <20140806024236.GA17879@MrMyself>
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
 <53E0B926.9010103@gmail.com> <20140805110735.GA16503@MrMyself>
 <53E0BC95.7040208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53E0BC95.7040208-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Varka,

On Tue, Aug 05, 2014 at 04:44:29PM +0530, Varka Bhadram wrote:
> On 08/05/2014 04:37 PM, Nicolin Chen wrote:
> >Hi Varka,
> >
> >On Tue, Aug 05, 2014 at 04:29:50PM +0530, Varka Bhadram wrote:
> >>>diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >>>index 0f4e238..77864f4 100644
> >>>--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >>>+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >>>@@ -24,6 +24,22 @@ Required properties:
> >>>  - big-endian-data: If this property is absent, the little endian mode will
> >>>    be in use as default, or the big endian mode will be in use for all the
> >>>    fifo data.
> >>>+- fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
> >>>+  that SAI will work in the synchronous mode (sync Tx with Rx) which means
> >>>+  both the transimitter and receiver will send and receive data by following
> >>>+  receiver's bit clocks and frame sync clocks.
> >>>+- fsl,sai-asynchronous: This is a boolean property. If present, indicating
> >>>+  that SAI will work in the asynchronous mode, which means both transimitter
> >>>+  and receiver will send and receive data by following their own bit clocks
> >>>+  and frame sync clocks separately.
> >>>
> >>Would be readable if it like this...
> >>
> >>fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
> >>			that SAI will work in the synchronous mode (sync Tx with Rx) which means
> >>			both the transimitter and receiver will send and receive data by following
> >>			receiver's bit clocks and frame sync clocks.
> >>- fsl,sai-asynchronous: This is a boolean property. If present, indicating
> >>			that SAI will work in the asynchronous mode, which means both transimitter
> >>			and receiver will send and receive data by following their own bit clocks
> >>			and frame sync clocks separately.
> >I agree, however, the doc was initialized in that format. Adding
> >indentations for these two appended lines makes the whole text
> >look weird. :(
> 
> Reading comfortably is important for us...  :-)
> see this:http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt#L46

I know how to write a binding doc with indentations to make it clear.

What I'm talking about is that the doc was created without indentations,
so I don't feel comfortable to add indentations starting from this patch
while leaving the old lines in totally a different style because It's not
helpful to make people read comfortably at all but only forcing people to
think why these two lines are so special to take some steps back here.

So personally I agree with your idea to make doc more readable. But what
I prefer to do is not having a conversation on the style within this patch
but to create an extra style-refinement patch later after this one.

Let's just focus on the function itself right now. We can later send a
patch to refine this entire doc. Won't you think it's a better idea? :)

Thank you
Nicolin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
