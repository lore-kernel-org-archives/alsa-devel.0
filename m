From: Simran Rai <ssimran-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: Add DT bindings for Broadcom
 Cygnus audio
Date: Fri, 6 Nov 2015 14:10:23 -0800
Message-ID: <563D254F.9090000@broadcom.com>
References: <1446502284-23907-2-git-send-email-ssimran@broadcom.com>
 <20151104140746.GE1717@sirena.org.uk> <563BB5B0.5040501@broadcom.com>
 <20151106103147.GZ18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151106103147.GZ18409-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arun Parameswaran <arunp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 11/6/2015 2:31 AM, Mark Brown wrote:
> On Thu, Nov 05, 2015 at 12:01:52PM -0800, Simran Rai wrote:
>> On 11/4/2015 6:07 AM, Mark Brown wrote:
>>> On Mon, Nov 02, 2015 at 02:11:23PM -0800, Simran Rai wrote:
>>>> +  Interfaces grouping of serial port. In multi-channel stereo, use
>>>> +  "2_0", in 3.1 multi-channel grouping, use "3_1" and in 5.1
>>>> +  multi-channel grouping, use "5_1".
>>> I don't really understand what this means or why this is not runtime
>>> configured.
>> By runtime configured, do you mean passing the channel grouping through
>> machine file? Is there any specific callback that I can use?
> No, this appears to just be setting the number of channels which is
> normally configured depending on how many channels userspace is playing.
This audio driver uses 'params_channels()' to determine the number of 
channels requested by userspace in TDM mode (multiple
channels on one audio port). Channel grouping is another mode where more 
than one audio ports are grouped together to form
3.1 or 5.1 surround sound and this feature has been implemented through 
device tree settings.
At this point, I will take out channel grouping functionality because it 
does not work as intended. In near future, once this feature
is fixed, how do you suggest implementing it in the driver?

Thanks,
Simran
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
