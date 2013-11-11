From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/2] dt: binding: sound cs42l52 driver
Date: Mon, 11 Nov 2013 10:29:29 -0600
Message-ID: <alpine.DEB.2.10.1311111021200.4415@heelrod.ad.cirrus.com>
References: <1383855737-8499-1-git-send-email-brian.austin@cirrus.com> <1383855737-8499-2-git-send-email-brian.austin@cirrus.com> <20131111101621.GB21201@e106331-lin.cambridge.arm.com> <0CBF9AAF3CF9714282149D6CA9B22CF302329016@ex1.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0CBF9AAF3CF9714282149D6CA9B22CF302329016-n9jNCKTBNvvfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: "Austin, Brian" <Brian.Austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

>
> Nit: device tree convention is to use '-' rather than '_'. So this should be reset-gpio rather than reset_gpio.
>
> s/_/-/ for the later property names too.
>

Will do, thanks

> s/GPIO spec/phandle + gpio-specifier/

OK, Same here


>
>> +  - chgfreq    : Charge Pump Frequency values 0x00-0x0F
>
> In general, longer but more easily understood names are preferred (e.g.
> "clock-frequency"). This could be "charge-pump-frequency".
>
As Mark Brown pointed out, I would prefer to leave this as a reference to 
a register in the device. In general I was hoping to keep the original 
platform data names as carried over to dt.

> When you say "values 0x00-0x0F" you mean the value is in that range?
> Inclusive?
>
I'll be more specific, Thanks

> Due to punctuation, upon first reading I read this as being an array of values.  It would be nice to have some clarification to prevent others maknig the smae mistake.
>
>> +  - mica_sel   : MIC A single ended input select MIC1/MIC2
>> +  - micb_sel   : MIC B single ended input select MIC1/MIC2
>
> Is this a boolean? What values are expected?
>
> Could you elaborate on what this describes?
>
>> +  - mica_cfg   : MIC A single-ended or differential select
>> +  - micb_cfg   : MIC A single-ended or differential select
>
> Could you elaborate on what these describe, what values are expected, etc?
>

I will explain values better, Thanks


>> +  - micbias_lvl: Set the output voltage level on the MICBIAS Pin
>> +		 0x00 = 0.5 x VA
>> +		 0x01 = 0.6 x VA
>> +		 0x02 = 0.7 x VA
>> +		 0x03 = 0.8 x VA
>> +		 0x04 = 0.83 x VA
>> +		 0x05 = 0.91 x VA
>
> Is this not something we'd want to change at runtime instead? Why does this need to be in the dt?
>

This is set based on the system design so it usually will be a one time 
setting at boot.

I'll send a v2 shortly,

Thank you for the review and tips for the next ones.

Regards,
Brian

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
