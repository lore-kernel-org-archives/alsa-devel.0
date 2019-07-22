From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] ASoC: SOF: use __u32 instead of uint32_t in uapi headers
Date: Mon, 22 Jul 2019 23:35:53 +0900
Message-ID: <CAK7LNATSrD-toRZFmQw8cO4D2mRomc=Xw=topA1Ry-0yM=ackg@mail.gmail.com>
References: <20190721142308.30306-1-yamada.masahiro@socionext.com> <CAK8P3a01MzCTJnk_fuMgWsRBa3u_CEZegZqH37G7qLiquHWncA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a01MzCTJnk_fuMgWsRBa3u_CEZegZqH37G7qLiquHWncA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 22, 2019 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Jul 21, 2019 at 4:25 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> >  struct snd_sof_blk_hdr {
> >         enum snd_sof_fw_blk_type type;
> > -       uint32_t size;          /* bytes minus this header */
> > -       uint32_t offset;        /* offset from base */
> > +       __u32 size;             /* bytes minus this header */
> > +       __u32 offset;           /* offset from base */
> >  } __packed;
> >
>
> On a related note: Using an 'enum' in an ABI structure is not portable
> across architectures. This is probably fine in a UAPI as long as user
> and kernel space agree on the size of an enum, but if the same
> structure is used to talk to the firmware, it won't work on architectures
> that have a different size for the first field.

Both comments from Arnd make sense.

If this header does not need to be in uapi/,
moving it out is fine.

But, looks like Mark has already picked up this.
(His review is so quick)




--
Best Regards
Masahiro Yamada
