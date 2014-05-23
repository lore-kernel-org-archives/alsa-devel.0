From: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: max98090: Add master clock handling
Date: Fri, 23 May 2014 17:32:45 +0530
Message-ID: <CAHbNUh2P7gdYPSdNRx8QbxuSc9n38yq3D_TWX2jdkcpE1_N8Rw@mail.gmail.com>
References: <1400750228-13750-1-git-send-email-tushar.behera@linaro.org>
	<1400750228-13750-2-git-send-email-tushar.behera@linaro.org>
	<20140522103039.GD12304@sirena.org.uk>
	<CAHbNUh2QHv8n7Y19qfO7BagX5AWe0i17MjDvr7yOpHf6YNGW4A@mail.gmail.com>
	<20140523111446.GA12304@sirena.org.uk>
	<CAHbNUh152xgyVxcCHiv0M6PLw8DE7KZ990WG7uRWWFBc8sPWRQ@mail.gmail.com>
	<20140523114113.GE12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140523114113.GE12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "jerry.wong" <jerry.wong-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 23 May 2014 17:11, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, May 23, 2014 at 05:06:27PM +0530, Tushar Behera wrote:
>> On 23 May 2014 16:44, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> > Should be clk_prepare_enable() and similarly for the disable and you
>> > should check the error codes but yes, that looks good.
>
>> I was planning to keep clk_prepare/clk_unprepare in probe/remove.
>
> Why - what purpose would it serve to leave the clock prepared but not
> enabled?

I was getting some kernel slow path warning initially while preparing
this code, but not able to reproduce that warning now.

-- 
Tushar Behera
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
