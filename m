From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/7] ASoC: davinci-mcbsp: add binding for McBSP
Date: Mon, 25 Apr 2016 07:42:34 -0500
Message-ID: <20160425124234.GA30766@rob-hp-laptop>
References: <1461327617-11435-1-git-send-email-petr@barix.com>
 <1461327617-11435-2-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461327617-11435-2-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 22, 2016 at 02:20:11PM +0200, Petr Kulhavy wrote:
> Add devicetree binding for the TI DA850/OMAP-L138/AM18xx
> MultiChannel Buffered Serial Port (McBSP)
> 
> The optional register range "dat" is not implemented at the moment.
> The current driver supports only DMA into RX/TX registers but no FIFO.
> Once the FIFO is implemented in the driver the "dat" range will be used.
> 
> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
> ---
> v1: initial
> v2: add missing TC channel in dmas properties (for compatibility with the new EDMA3 binding)
>     remove "-audio" postfix from the compatible string
>     remove "channel-combine" property
> v3: remove the index note from the "mpu" property.
>     specify exactly the supported platforms in compatible string
> v4: minor correction in the example ("interrupt names"), re-added index note to the "mpu" property.
> 
>  .../devicetree/bindings/sound/davinci-mcbsp.txt    | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
