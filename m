From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH v6] media: Add stk1160 new driver
Date: Fri, 27 Jul 2012 13:50:33 -0300
Message-ID: <CALF0-+Ww6PxLCGA_YLMK+Kw9Oh1Qf3=KT5WdbRbyaR9wKy6Cvg@mail.gmail.com>
References: <1343348122-2215-1-git-send-email-elezegarcia@gmail.com>
	<s5hobn1r5qg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <s5hobn1r5qg.wl%tiwai@suse.de>
Sender: linux-media-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Fri, Jul 27, 2012 at 5:03 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>
>> This is achieved through snd_ac97_codec/ac97_bus drivers.
>> Mauro suggested that this ac97 handling should be put
>> inside -alsa tree, but I'm still not sure about it.
>> This approach is working well in practice, but I'm not 100%
>> confident so feedback is welcome (in particular from you alsa guys).
>
> Well, it's a pretty small stuff and ac97 isn't developed so much any
> longer, so I'm fine to put your code in the video tree.
>

Yes, I also feel the same way: it's very small code to be splitted.
Let's wait Mauro to hear his opinion.


> Looking through your patch, a remaining problem is that the dependency
> on the sound core is missing.  The "select" in Kconfig doesn't fulfill
> the dependencies automatically but forcibly sets the value.
>
> Selecting CONFIG_SND_AC97_CODEC will select most of other components
> but CONFIG_SND itself must be enabled beforehand.  Thus, you need to
> wrap CONFIG_VIDEO_STK1160 with "depends on SND".
> Or split the ac97 codec part and makes it depending on SND, and
> define dummy functions if not defined, e.g.
>
> #ifdef CONFIG_VIDEO_STK1160_AC97
> int stk1160_ac97_register(struct stk1160 *dev);
> int stk1160_ac97_unregister(struct stk1160 *dev);
> #else
> static inline int stk1160_ac97_register(struct stk1160 *dev) { return 0; }
> static inline int stk1160_ac97_unregister(struct stk1160 *dev) { return 0; }
> #endif
>

This looks nice.

Thanks a lot for the review,
Ezequiel.
