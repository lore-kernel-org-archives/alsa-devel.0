From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] dt/bindings: Add milivolt, milliamps, and
 nanohenry units
Date: Fri, 14 Oct 2016 07:35:22 -0500
Message-ID: <CAL_JsqKdV7133oo5jECZn2SwVjMM3E_ZNr+JS=9Wtkx8BZVuEQ@mail.gmail.com>
References: <1476298410-1157-1-git-send-email-Paul.Handrigan@cirrus.com> <e4a605af-3b2d-4e29-a5c4-991e34f1205f@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e4a605af-3b2d-4e29-a5c4-991e34f1205f-XU/xxMRwCJnfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Handrigan <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2016 at 1:53 PM,  <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org> wrote:
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
>  -microamp      : micro amps
> +-milliamp      : milli amps

Please explain why you need need this. Is 2^32 uA not enough range for
you? While we do have multiple units for some, that's because people
picked arbitrary units for their properties before this doc existed.
Ideally, we only have 1 unit to prevent that problem.

>  -ohms          : Ohms
>  -micro-ohms    : micro Ohms
>  -microvolt     : micro volts
> +-millivolt     : micro volts

Same question.

> +-nanohenry     : nano henries
>
>  Temperature
>  ----------------------------------------
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
