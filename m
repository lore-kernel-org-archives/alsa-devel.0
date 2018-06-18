From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
Date: Mon, 18 Jun 2018 14:53:19 -0600
Message-ID: <CAL_JsqJti8JzQ7mVQ6Y2zaWD_Q5R9bK4XVh3mJPohXh4sgSQwQ@mail.gmail.com>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
 <20180614111138.8923-6-niklas.cassel@linaro.org> <20180618110642.GA6928@sirena.org.uk>
 <20180618123932.GA28476@centauri.lan> <CAL_JsqJQ0GbFtnpP9-YCEcVKHDdHbT5hshZGvNDQw=u5ZANdvg@mail.gmail.com>
 <20180618200848.GA32482@centauri.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180618200848.GA32482@centauri.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Andy Gross <andy.gross@linaro.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 18, 2018 at 2:08 PM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> On Mon, Jun 18, 2018 at 08:48:32AM -0600, Rob Herring wrote:
>> On Mon, Jun 18, 2018 at 6:39 AM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
>> > On Mon, Jun 18, 2018 at 12:06:42PM +0100, Mark Brown wrote:
>> >> On Thu, Jun 14, 2018 at 01:11:36PM +0200, Niklas Cassel wrote:
>> >> > of_platform_device_destroy is only defined when building
>> >> > with CONFIG_OF=y. Add a depends on OF.
>> >>
>> >> Is it sensible that of_platform_device_destroy() is only defined when
>> >> building with CONFIG_OF=y?
>> >
>> > I'm redirecting that question to the device tree maintainers.
>> >
>> > There are a few of_* functions in include/linux/of_platform.h
>> > that are only defined when CONFIG_OF=y:
>> >
>> > of_platform_device_create()
>> > of_platform_device_destroy()
>> > of_platform_bus_probe()
>> > of_device_alloc()
>> >
>> > Rob, Frank, do you want me to create static inline dummy versions of these?
>>
>> No, because generally you should not be using these functions
>> directly. Yes, there are some users, but if you look at the tree,
>> there are few or isolated (PowerPC) users. Using
>> of_platform_populate/of_platform_depopulate is preferred.
>
> of_platform_device_destroy() is also used by sound/soc/qcom/qdsp6/*
> which is why I suggested this patch:
> https://marc.info/?l=alsa-devel&m=152932497413567
> that adds "depends on OF" for SND_SOC_QDSP6 in sound/soc/qcom/Kconfig.
>
> Or do you think that a better solution would be to modify
> sound/soc/qcom/qdsp6/* so that it instead uses
> of_platform_populate()/of_platform_depopulate()?

Yes, that is preferred. However, that won't work here because the
child nodes don't have compatible strings. Maybe we should add them as
this all just went in. That would also allow DT based module
autoloading to work (which I don't think would currently). Really, as
is, of_platform_device_create isn't needed here and you could just use
platform_device_register_simple instead. The child driver would have
to get the DT node pointer from the parent device instead.

But if you want to add empty functions for just
of_platform_device_{create,destroy}, I guess that is fine.

Rob
