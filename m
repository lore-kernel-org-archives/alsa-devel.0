From: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] ALSA: hda: fix unused variable warning
Date: Tue, 11 Sep 2018 16:18:03 +0200
Message-ID: <CADYN=9JqdmfVfWWWB3VtDcdVDPD6bBfKOnemaKFLd4SRrKi33g@mail.gmail.com>
References: <20180911082559.24214-1-anders.roxell@linaro.org> <s5hbm941law.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hbm941law.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: perex@perex.cz, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Sep 2018 at 10:38, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 11 Sep 2018 10:25:59 +0200,
> Anders Roxell wrote:
> >
> > When CONFIG_X86=3Dn function azx_snoop doesn't use the variable chip it
> > only returns true.
> >
> > sound/pci/hda/hda_intel.c: In function =E2=80=98dma_alloc_pages=E2=80=
=99:
> > sound/pci/hda/hda_intel.c:2002:14: warning: unused variable =E2=80=98ch=
ip=E2=80=99 [-Wunused-variable]
> >   struct azx *chip =3D bus_to_azx(bus);
> >               ^~~~
> >
> > Create a inline function of azx_snoop.
> >
> > Fixes: a41d122449be ("ALSA: hda - Embed bus into controller object")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  sound/pci/hda/hda_controller.h | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_control=
ler.h
> > index 0053b704ddc4..aa20048742d0 100644
> > --- a/sound/pci/hda/hda_controller.h
> > +++ b/sound/pci/hda/hda_controller.h
> > @@ -170,11 +170,10 @@ struct azx {
> >  #define azx_bus(chip)        (&(chip)->bus.core)
> >  #define bus_to_azx(_bus)     container_of(_bus, struct azx, bus.core)
> >
> > -#ifdef CONFIG_X86
> > -#define azx_snoop(chip)              ((chip)->snoop)
> > -#else
> > -#define azx_snoop(chip)              true
> > -#endif
> > +static inline bool azx_snoop(struct azx *chip)
> > +{
> > +     return IS_ENABLED(CONFIG_X86) || (chip->snoop);
> > +}
>
> The idea is good, but the patch is obviously wrong; it should be
> !IS_ENABLED() :)

oops, right.

>
> Also, please remove the parentheses around chip->snoop.

OK.

Sending v2 shortly.

Cheers,
Anders
