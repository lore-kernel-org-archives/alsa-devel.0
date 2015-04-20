From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power amplifiers
Date: Mon, 20 Apr 2015 09:05:39 -0700
Message-ID: <CAL1qeaGo_nwxFxUB4fEj259WqKNBuhdBT9QHGpv4Rt9uhit0ZA@mail.gmail.com>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
	<1429134141-17924-2-git-send-email-cernekee@chromium.org>
	<20150418113632.GE26185@sirena.org.uk>
	<CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
	<20150418171137.GY26185@sirena.org.uk>
	<CAJzqFtZ97FjzDpgbSJbCkqNGnQx_QiGrzY1v1zV+croAL6_=qw@mail.gmail.com>
	<20150420122129.GC14892@sirena.org.uk>
	<CAJzqFtY3-jYTS-NmAE4UtsD+VXZHBUJUVuVQ=X4htB1akCThMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJzqFtY3-jYTS-NmAE4UtsD+VXZHBUJUVuVQ=X4htB1akCThMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Dylan Reid <dgreid@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Kevin,

On Mon, Apr 20, 2015 at 8:12 AM, Kevin Cernekee <cernekee@chromium.org> wrote:
> On Mon, Apr 20, 2015 at 5:21 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Sat, Apr 18, 2015 at 01:07:07PM -0700, Kevin Cernekee wrote:
>>> On Sat, Apr 18, 2015 at 10:11 AM, Mark Brown <broonie@kernel.org> wrote:
>>
>>> > Someone trying to use the atmel_wm8904 driver with something other than
>>> > a wm8904 shouldn't really be expecting a good experince...
>>
>>> The same check shows up in numerous other drivers, including the one
>>> for the audio controller on my board.
>>
>> Sounds like either that (undisclosed) driver has a problem or you're
>> using it inappropriately.
>
> I don't think this driver has been posted on the list yet, but the
> checks show up in these two functions:
>
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/sound/soc/img/concerto-audio.c#108
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/sound/soc/img/concerto-audio.c#147
>
> Any suggestions on what to change?

I think the card driver should be ignoring a return value of -ENOTSUPP
from snd_soc_dai_set_sysclk() in that case.
