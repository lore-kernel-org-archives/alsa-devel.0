From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [alsa-devel] future of sounds/oss
Date: Tue, 16 May 2017 09:45:04 +0200
Message-ID: <CAMuHMdUfMt_HMybx9T0mUSCaNqhJSstqXaWYC7jhnzo36iBHKA@mail.gmail.com>
References: <20170511082133.GA20304@lst.de> <s5hh90rhjbc.wl-tiwai@suse.de>
 <20170511091511.GA21055@lst.de> <s5hy3u32lhi.wl-tiwai@suse.de>
 <CAMuHMdXiXfU=1hf6twMXd1Jjy0J5KQt_eQqWr3vh2HqE_77SVw@mail.gmail.com>
 <s5hfuga35zc.wl-tiwai@suse.de> <CAMuHMdX_gzspdn0r37GWvdvYwomy7T1M9baxsxmX_jBmwUWhRg@mail.gmail.com>
 <s5hbmqy356r.wl-tiwai@suse.de> <CAMuHMdW5WFhX=wEiCfHCReXSeedPAshc_3D=ULx6PFeb9tEd-w@mail.gmail.com>
 <s5ha86ifqre.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <s5ha86ifqre.wl-tiwai@suse.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jaroslav Kysela <perex@perex.cz>, Linus Torvalds <torvalds@linuxfoundation.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Iwai-san,

On Fri, May 12, 2017 at 10:01 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > But, looking at the tree again, I noticed that ALSA isn't built yet at
>> > all for m68k.  I don't remember why it's disabled.
>> > Jaroslav, do you know the reason behind it?
>>
>> Because ALSA doesn't have any drivers that can be used on m68k platforms?
>
> But we have virtual and generic drivers (such as UART support), so
> there seems no reason to stop it.  Maybe the lack of proper MMU

It seems to date back to the move of sound from arch/*/Kconfig
to sound/Kconfig. I guess at that time there was just no use for ALSO on
m68k.

> support was the reason?  Let's try to cross-build...

Building seems to work fine...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
