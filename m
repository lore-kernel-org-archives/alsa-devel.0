From: "Wu, Songjun" <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
Date: Wed, 9 Sep 2015 11:16:08 +0800
Message-ID: <55EFA478.1000109@atmel.com>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk> <55EC0AF5.8060403@atmel.com>
 <20150907162350.GV5313@sirena.org.uk> <55EEAC01.3080409@atmel.com>
 <20150908122322.GB9751@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150908122322.GB9751-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 9/8/2015 20:23, Mark Brown wrote:
> On Tue, Sep 08, 2015 at 05:36:01PM +0800, Wu, Songjun wrote:
>> On 9/8/2015 00:23, Mark Brown wrote:
>
>>> OK, so that's not actually what the code was doing - it had separate
>>> enums for bass, mid and treble.  If you make this a single enum with all
>>> the above options in it that seems like the best way of handling things.
>
>> A single enum seems not very friendly to user, there are tree EQs, bass,
>> medium and treble.
>> So I create tree enum controls to control three EQs.
>> The 'get' function is replaced by 'classd_get_eq_enum', if user operates one
>> of the tree EQ controls, the other two EQs will show 0 dB.
>
> If you want to have three controls you need to write code so that the
> user can only change one of them from 0dB at once, returning an error
> otherwise.  That was why it looked like they were three separate
> controls.
>
If user operates two or tree controls at the same time, for my 
understanding, these operations are serial actually in kernel, not 
parallel, and the last operation will be effective. I only write the 
function 'classd_get_eq_enum' to get the enumeration value, if user 
changes one of controls, the other controls will get 0dB. Is my 
understanding correct?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
