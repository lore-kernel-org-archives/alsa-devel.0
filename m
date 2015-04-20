From: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power amplifiers
Date: Mon, 20 Apr 2015 08:12:36 -0700
Message-ID: <CAJzqFtY3-jYTS-NmAE4UtsD+VXZHBUJUVuVQ=X4htB1akCThMg@mail.gmail.com>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org> <20150418113632.GE26185@sirena.org.uk>
 <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
 <20150418171137.GY26185@sirena.org.uk> <CAJzqFtZ97FjzDpgbSJbCkqNGnQx_QiGrzY1v1zV+croAL6_=qw@mail.gmail.com>
 <20150420122129.GC14892@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150420122129.GC14892-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 20, 2015 at 5:21 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sat, Apr 18, 2015 at 01:07:07PM -0700, Kevin Cernekee wrote:
>> On Sat, Apr 18, 2015 at 10:11 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> > Someone trying to use the atmel_wm8904 driver with something other than
>> > a wm8904 shouldn't really be expecting a good experince...
>
>> The same check shows up in numerous other drivers, including the one
>> for the audio controller on my board.
>
> Sounds like either that (undisclosed) driver has a problem or you're
> using it inappropriately.

I don't think this driver has been posted on the list yet, but the
checks show up in these two functions:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/sound/soc/img/concerto-audio.c#108
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/sound/soc/img/concerto-audio.c#147

Any suggestions on what to change?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
