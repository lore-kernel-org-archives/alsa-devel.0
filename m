From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [alsa-devel] future of sounds/oss
Date: Fri, 12 May 2017 09:17:35 +0200
Message-ID: <CAMuHMdX_gzspdn0r37GWvdvYwomy7T1M9baxsxmX_jBmwUWhRg@mail.gmail.com>
References: <20170511082133.GA20304@lst.de> <s5hh90rhjbc.wl-tiwai@suse.de>
 <20170511091511.GA21055@lst.de> <s5hy3u32lhi.wl-tiwai@suse.de>
 <CAMuHMdXiXfU=1hf6twMXd1Jjy0J5KQt_eQqWr3vh2HqE_77SVw@mail.gmail.com> <s5hfuga35zc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <s5hfuga35zc.wl-tiwai@suse.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jaroslav Kysela <perex@perex.cz>, Linus Torvalds <torvalds@linuxfoundation.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Iwai-san,

On Fri, May 12, 2017 at 9:10 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 12 May 2017 09:03:07 +0200,
> Geert Uytterhoeven wrote:
>> On Thu, May 11, 2017 at 10:21 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > From: Takashi Iwai <tiwai@suse.de>
>> > Subject: [PATCH] sound: Disable the build of OSS drivers
>> >
>> > OSS drivers are left as badly unmaintained, and now we're facing a
>> > problem to clean up the hackish set_fs() usage in their codes.  Since
>> > most of drivers have been covered by ALSA, and the others are dead old
>> > and inactive, let's leave them RIP.
>> >
>> > This patch is the first step: disable the build of OSS drivers.
>> > We'll eventually drop the whole codes and clean up later.
>> >
>> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> > ---
>> >  sound/Kconfig | 26 ++++++++++++++------------
>> >  1 file changed, 14 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/sound/Kconfig b/sound/Kconfig
>> > index ee2e69a9ecd1..41eda578d08e 100644
>> > --- a/sound/Kconfig
>> > +++ b/sound/Kconfig
>> > @@ -54,7 +54,8 @@ config SOUND_OSS_CORE_PRECLAIM
>> >
>> >           If unsure, say Y.
>> >
>> > -source "sound/oss/dmasound/Kconfig"
>> > +### TO-BE-REMOVED
>> > +# source "sound/oss/dmasound/Kconfig"
>>
>> Please note the dmasound drivers do not have ALSA equivalents.
>
> These belong to the latter, "dead old and inactive" ones :)
>
> Are these driver still used with the latest kernel?  If users are

I believe so.

> willing to help, we can provide the port to ALSA drivers, too.

That would be great, thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
