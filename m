From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/5] ASoC: tas571x: chip type detection via I2C name
Date: Thu, 31 Mar 2016 18:32:25 +0200
Message-ID: <56FD5119.9000000@barix.com>
References: <1459425241-21941-1-git-send-email-petr@barix.com>
 <1459425241-21941-2-git-send-email-petr@barix.com>
 <20160331153626.GB2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160331153626.GB2350-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 31.03.2016 17:36, Mark Brown wrote:
> On Thu, Mar 31, 2016 at 01:53:58PM +0200, Petr Kulhavy wrote:
>> The chip selection was relying only on DT. It was not possible to use the
>> driver without DT.
>> This adds the chip type detection from the I2C name, which
>> allows to use the driver from the platform driver without DT.
>>
>> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
>> Reviewed-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Don't resubmit already applied patches, as covered in SubmittingPatches
> you should submit against the latest development tree.  Please resend
> with just the new stuff, if any changes are needed in already applied
> patches send incremental fixes.
Thanks for the remainder, I'm sorry, didn't know that.
I will resubmit them right now.

Petr
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
