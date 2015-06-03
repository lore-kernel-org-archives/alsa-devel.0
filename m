From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [alsa-devel] [PATCH 5/7] ASoC: wm5100: remove bitwise operations
 involving GPIO level value
Date: Thu, 04 Jun 2015 01:58:37 +0300
Message-ID: <556F869D.6060601@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>	<1433200158-6890-5-git-send-email-vz@mleia.com>	<20150602194558.GI14071@sirena.org.uk>	<556E10CD.3090301@mleia.com>	<CA+7tXijtaM4tn3Mb+tbsd7JFbGjeh1yT=zTXPuCiFjqnvRjdvg@mail.gmail.com>	<556F51CF.1000807@mleia.com> <CA+7tXigF6LginxQGUBKqLZorecPp7B8wydzDA4jb4iKOi7CdBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CA+7tXigF6LginxQGUBKqLZorecPp7B8wydzDA4jb4iKOi7CdBA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, Linus Walleij <linus.walleij@linaro.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linux-gpio <linux-gpio@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello Trent,

On 04.06.2015 00:51, Trent Piepho wrote:
> On Wed, Jun 3, 2015 at 12:13 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>>>
>>> BTW, with a little C algebra:
>>> const unsigned int val = value ?  0x1 << WM5100_GP1_LVL_SHIFT : 0;
>>> const unsigned int val = (value ?  0x1 : 0) << WM5100_GP1_LVL_SHIFT;
>>> const unsigned int val = (!!value) << WM5100_GP1_LVL_SHIFT;  //
>>> definition of ! operator
>>>
>>> And now we're back to where we started, so I don't really see why this
>>> is even necessary.  The semantics of the ! operator will be changed in a
>>> future C version?
>>
>> I don't think it makes sense to discuss technical aspects of the
>> proposed change, as I mentioned in the discussion yesterday I see no
>> technical issues at this point, and my changes are described as
>> nonfunctional.
>>
>> The _nontechnical_ problem I see (well, may be I'm just blowing it up)
>> is a Linux kernel code style policy problem, to my knowledge the policy
>> of using bitwise and arithmetic operations on bool type variables and
>> constants is not defined, and since the policy is not yet defined I'm
>> glad to take part in its discussion now.
> 
> I don't believe this is the case.

please excuse me for possible misunderstanding, you don't believe that
I'm interested in discussing a _nontechnical_ problem stated above?

>  From C99, section 6.5.3.3, paragraph 5:

C99 is a strict superset over Linux coding style (e.g. remember //
comments or "register" specifier), so let's forget about.

--
With best wishes,
Vladimir
