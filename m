From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] dt/bindings: Add milivolt,
 milliamps, and nanohenry units
Date: Fri, 14 Oct 2016 11:03:11 +0100
Message-ID: <20161014100311.GE1952@localhost.localdomain>
References: <1476298410-1157-1-git-send-email-Paul.Handrigan@cirrus.com>
 <e4a605af-3b2d-4e29-a5c4-991e34f1205f@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e4a605af-3b2d-4e29-a5c4-991e34f1205f-XU/xxMRwCJnfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2016 at 01:53:30PM -0500, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org wrote:
> From: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> 
> Add millivolt, milliamp, and nanohenry units to the Electricity
> category.
> 
> Signed-off-by: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/property-units.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
> index 12278d7..92d6793 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -25,9 +25,12 @@ Distance
>  Electricity
>  ----------------------------------------
>  -microamp	: micro amps
> +-milliamp	: milli amps
>  -ohms		: Ohms
>  -micro-ohms	: micro Ohms
>  -microvolt	: micro volts
> +-millivolt	: micro volts
Typo here         ^^^^^

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
