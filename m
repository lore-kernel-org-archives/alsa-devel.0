From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/7] ASoC: davinci-mcbsp: add binding for McBSP
Date: Mon, 9 May 2016 15:49:39 +0200
Message-ID: <57309573.5010408@barix.com>
References: <1461327617-11435-1-git-send-email-petr@barix.com>
 <57289832.9050904@barix.com> <5728A030.1050802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5728A030.1050802-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Petr Kulhavy <brain-wDf7oJUeT2I@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



On 03.05.2016 14:57, Sekhar Nori wrote:
> On Tuesday 03 May 2016 05:53 PM, Petr Kulhavy wrote:
>> Hi,
>>
>> I'm just wondering if anybody is picking up on this.
>> Peter has reviewed the patch set (v3 where the code is identical to v4)
>> and Rob has acked the DT part.
> For the mach-davinci portions, I was actually waiting on the driver
> changes to be accepted first. I have already sent my pull request for
> v4.7. I am afraid these have to wait for v4.8.
>
> Also, I just noticed that linux-arm-kernel-xBCQruHUn5ppWr+L1FloEB2eb7JE58TQ@public.gmane.org was not
> copied on the submission. That list must be copied on all mach-davinci
> submissions.
>
> And looks like not all patches in the series depend on the driver
> changes (3/7 and even 7/7?). In such cases, it always helps to send them
> separately so they can be queued independently.
>
> Even now, can you please separate out such patches and resend them with
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org copied.
>
> Regards,
> Sekhar

Thanks a lot Sekhar for your time and comments. I'm re-basing the 
patches to your branch right now and I will submit patches 3 and 7 
separately. Then I will re-submit the rest without 5, which has been 
already applied.

Regards
Petr
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
