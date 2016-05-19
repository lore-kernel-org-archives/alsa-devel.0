From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 5/7] ARM: DTS: da850: Fix wrong number of interrupts
Date: Thu, 19 May 2016 19:44:42 +0530
Message-ID: <573DCA52.9060007@ti.com>
References: <1461327617-11435-1-git-send-email-petr@barix.com>
 <1461327617-11435-6-git-send-email-petr@barix.com> <57289C99.2070208@ti.com>
 <57308739.6080800@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57308739.6080800-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Cc: khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Monday 09 May 2016 06:18 PM, Petr Kulhavy wrote:
> 
> On 03.05.2016 14:42, Sekhar Nori wrote:
>> On Friday 22 April 2016 05:50 PM, Petr Kulhavy wrote:
>>> The DA850 supports interrupts 0 to 100. The number of interrupts
>>> property "ti,intc-size" was wrongly set to 100. Corrected to 101.
>>>
>>> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
>> This patch is already in my tree and sent for inclusion in v4.7.
>>
>> Regards,
>> Sekhar
> Thanks, Sekhar, I didn't know that. Could you please just drop a message
> next time that it has been applied. Thanks!

Actually, the exact same change was submitted by David Lechner and I
ended up applying his patch.

https://lkml.org/lkml/2016/4/13/852

Regards,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
