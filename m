From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [alsa-devel] future of sounds/oss
Date: Fri, 12 May 2017 10:28:29 +0200
Message-ID: <20170512082829.GB29311@physik.fu-berlin.de>
References: <20170511082133.GA20304@lst.de>
 <s5hh90rhjbc.wl-tiwai@suse.de>
 <20170511091511.GA21055@lst.de>
 <s5hy3u32lhi.wl-tiwai@suse.de>
 <CAMuHMdXiXfU=1hf6twMXd1Jjy0J5KQt_eQqWr3vh2HqE_77SVw@mail.gmail.com>
 <s5hfuga35zc.wl-tiwai@suse.de>
 <CAMuHMdX_gzspdn0r37GWvdvYwomy7T1M9baxsxmX_jBmwUWhRg@mail.gmail.com>
 <s5hbmqy356r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hbmqy356r.wl-tiwai@suse.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>, Jaroslav Kysela <perex@perex.cz>, Linus Torvalds <torvalds@linuxfoundation.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 12, 2017 at 09:27:56AM +0200, Takashi Iwai wrote:
> But, looking at the tree again, I noticed that ALSA isn't built yet at
> all for m68k.  I don't remember why it's disabled.
> Jaroslav, do you know the reason behind it?

Might also just be because the m68k port had been dead in Debian for a
while due the lack of TLS support in glibc on m68k. However, the port
is active again and in pretty good shape now.

I'm currently working on fixing debian-installer on m68k, so that
people can install the port without having to resort to things like
debootstrap.

> And, dmasound is a completely different implementation from the other
> OSS, thus it doesn't suffer from set_fs() hack.  That is, we may still
> keep dmasound, while removing other OSS stuff.

Thanks! Highly appreciated.

> Meanwhile we'll try to support ALSA on m64k and eventually target to
> drop dmasound stuff.

Ooooh, that would be awesome. If you need any testers on m68k, please
let us know. I have plenty of m68k hardware for testing.

> Does it sound more feasible?

No idea whether it's feasible. But it sounds awesome :).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
