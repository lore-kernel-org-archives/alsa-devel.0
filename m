From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/4] ASoC: Davinci: McBSP: add device tree support for
 McBSP
Date: Wed, 11 May 2016 17:10:40 +0200
Message-ID: <57334B70.8000008@barix.com>
References: <1462804522-29544-1-git-send-email-petr@barix.com>
 <1462804522-29544-3-git-send-email-petr@barix.com>
 <20160511145717.GJ6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160511145717.GJ6261-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, brain-wDf7oJUeT2I@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 11.05.2016 16:57, Mark Brown wrote:
> On Mon, May 09, 2016 at 04:35:20PM +0200, Petr Kulhavy wrote:
>> This adds DT support for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx McBSP driver.
>>
>> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
>> Reviewed-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> How did this manage to get review but not the accompanying binding?
The whole set got reviewed by Peter in version 4 and the binding in v4 
got acked by Rob.
For the patches 2 and 3 which were taken over into version 5 without any 
modification I left the Reviewed-by tag there.
But since I made a (minor) modification in the binding example I removed 
Rob's ack.

Petr
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
