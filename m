From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH v7] media: Add stk1160 new driver
Date: Mon, 6 Aug 2012 09:28:36 -0300
Message-ID: <CALF0-+XEStNrfdqYecKQHr=qkcFPtC5CyDC4DWWy_7+_oA0h=g@mail.gmail.com>
References: <1343485133-11090-1-git-send-email-elezegarcia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1343485133-11090-1-git-send-email-elezegarcia@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Ezequiel Garcia <elezegarcia@gmail.com>, alsa-devel@alsa-project.org, linux-media@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mauro,

On Sat, Jul 28, 2012 at 11:18 AM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> This driver adds support for stk1160 usb bridge as used in some
> video/audio usb capture devices.
> It is a complete rewrite of staging/media/easycap driver and
> it's expected as a future replacement.
>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
> ---
>

Did you take a look at this?

Perhaps we can discuss now you're previous comments:

1. Place for ac97 code: media or alsa? (see Takashis' comments)
2. current_norm usage (see Hans' comments)
3. vb2_dqbuf and O_NONBLOCK flag (also see Hans' comments)

I know it's a big patch*, so there is no need to rush.
I just wanted to discuss a bit about this before my brain-cache
flushes completely :-)

Thanks,
Ezequiel.

* Actually it's huge (12k lines) since I'm removing staging/easycap.
