From: "Handrigan, Paul" <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 3/3] dt/bindings: Add milivolt, milliamps, and
 nanohenry units
Date: Tue, 18 Oct 2016 00:43:48 +0000
Message-ID: <6ca3d940-4822-42d5-8606-cfc4c815c7ad@EX4.ad.cirrus.com>
References: <CAL_JsqKdV7133oo5jECZn2SwVjMM3E_ZNr+JS=9Wtkx8BZVuEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKdV7133oo5jECZn2SwVjMM3E_ZNr+JS=9Wtkx8BZVuEQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <0FBAA3F91925EC48A6A977D0043C6FAC-BNO7SilVNoKakBO8gow8eQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Austin, Brian" <Brian.Austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org




>>  Electricity
>>  ----------------------------------------
>>  -microamp      : micro amps
>> +-milliamp      : milli amps
>
>Please explain why you need need this. Is 2^32 uA not enough range for
>you? While we do have multiple units for some, that's because people
>picked arbitrary units for their properties before this doc existed.
>Ideally, we only have 1 unit to prevent that problem.

2^32 would be enough, however, microamps would not be a good
representation for
this particular entry. For example, if the current limit is 2.1A the
entry will have to be 2100000.  Micro amps will not be the best
representation for this value from a scientific notation perspective.
Since the scale is in miiliamps as it is defined in the data sheet of
this device, it will be best to stay consistent since an error in
conversion
could cause serious problems.

Also, I really don¹t see why adding milliamps and millivolts as being a
major
problems since both of them are commonly used.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
