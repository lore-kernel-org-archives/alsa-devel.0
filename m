From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/6] media: dt-bindings: Add bindings for TDA1997X
Date: Tue, 26 Dec 2017 13:03:11 -0600
Message-ID: <20171226190311.fkarrmgrytbirfgq@rob-hp-laptop>
References: <1513447230-30948-1-git-send-email-tharvey@gateworks.com>
 <1513447230-30948-4-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1513447230-30948-4-git-send-email-tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Steve Longerbeam <slongerbeam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Hans Verkuil <hansverk-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 16, 2017 at 10:00:27AM -0800, Tim Harvey wrote:
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Acked-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
> ---
> v5:
>  - added Sakari's ack
> 
> v4:
>  - move include/dt-bindings/media/tda1997x.h to bindings patch
>  - clarify port node details
> 
> v3:
>  - fix typo
> 
> v2:
>  - add vendor prefix and remove _ from vidout-portcfg
>  - remove _ from labels
>  - remove max-pixel-rate property
>  - describe and provide example for single output port
>  - update to new audio port bindings
> ---
>  .../devicetree/bindings/media/i2c/tda1997x.txt     | 179 +++++++++++++++++++++
>  include/dt-bindings/media/tda1997x.h               |  78 +++++++++
>  2 files changed, 257 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/tda1997x.txt
>  create mode 100644 include/dt-bindings/media/tda1997x.h

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
