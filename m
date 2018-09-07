From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
Date: Fri, 7 Sep 2018 10:54:04 -0700
Message-ID: <CANEJEGtWeBY7TMctUUn6q67FF5A6zMB2y8TbRtXEKsBREYn7CQ@mail.gmail.com>
References: <20180907002728.112770-1-grundler@chromium.org>
 <20180907121128.GH17459@sirena.org.uk> <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: broonie@kernel.org, ryans.lee@maximintegrated.com, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

[resending as plain/text - sorry]
On Fri, Sep 7, 2018 at 10:52 AM Grant Grundler <grundler@chromium.org> wrote:
>
>
>
> On Fri, Sep 7, 2018 at 5:11 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Thu, Sep 06, 2018 at 05:27:28PM -0700, Grant Grundler wrote:
>> > Commit ca917f9fe1a0fab added use of usleep_range() but not
>> > the corresponding "include <linux/delay.h>". The result is
>> > with Chrome OS won't build because warnings are forced
>> > to be errors:
>> > mnt/host/source/src/third_party/kernel/v4.4/sound/soc/codecs/max98373.c:734:2: error: implicit declaration of function 'usleep_range' [-Werror,-Wimplicit-function-declaration]
>> >         usleep_range(10000, 11000);
>> >         ^
>>
>> Note that this isn't causing a warning upstream, presumably due to an
>> implicit inclusion that isn't present in the v4.4 kernel that you appear
>> to be using, or gets missed due to config differences.
>
>
> Ok. Is this just an observation or are these reasons to not accept the change?
>
> cheers,
> grant
