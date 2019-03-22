From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ALSA: hda/ca0132: work around clang -Wuninitialized warning
Date: Fri, 22 Mar 2019 16:12:42 +0100
Message-ID: <CAK8P3a0DdQ2dgbgCDvwD37uu=_iU7VGOWHN+6tp=CxeSzz8GtQ@mail.gmail.com>
References: <20190322140649.197027-1-arnd@arndb.de> <s5hr2az9cos.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr2az9cos.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Connor McAdams <conmanx360@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, Nathan Chancellor <natechancellor@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, Jaroslav Kysela <perex@perex.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 22, 2019 at 4:00 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 22 Mar 2019 15:06:28 +0100,
> Arnd Bergmann wrote:
> >
> > When CONFIG_PCI is disabled, clang gets confused about the
> > control flow of the switch() statement always ending up
> > in the default case, and warns:
> >
> > sound/pci/hda/patch_ca0132.c:7558:6: error: variable 'fw_entry' is used uninitialized whenever 'if' condition is false
> >       [-Werror,-Wsometimes-uninitialized]
> >         if (!spec->alt_firmware_present) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7565:42: note: uninitialized use occurs here
> >         dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
> >                                                 ^~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7558:2: note: remove the 'if' if its condition is always true
> >         if (!spec->alt_firmware_present) {
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > sound/pci/hda/patch_ca0132.c:7521:33: note: initialize the variable 'fw_entry' to silence this warning
> >         const struct firmware *fw_entry;
> >                                        ^
> >                                         = NULL
> >
> > Adding an explicit check for CONFIG_PCI avoids the issue.
> > Unfortunately this is not very intuitive here.
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=41197#c1
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Any suggestions for other workarounds appreciated. If you can think
> > of a better fix, please treat this as a reported-by:
>
> Can it be addressed by the code simplification like below, instead?
>

Yes, I confirmed this works as well, and it's probably more
obvious what's going on, so let's use your version.

Thanks,

      Arnd
