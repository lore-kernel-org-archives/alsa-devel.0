From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: Re: [PATCH v1 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
Date: Wed, 19 Jun 2019 10:00:30 +0000
Message-ID: <AM6PR05MB65351FF540C6CD22167A6F90F9E50@AM6PR05MB6535.eurprd05.prod.outlook.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
         <20190521103619.4707-2-oleksandr.suvorov@toradex.com>,<79fa1a0855bfcc1abad348aa047e7a69fffb8225.camel@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79fa1a0855bfcc1abad348aa047e7a69fffb8225.camel@toradex.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "festevam@gmail.com" <festevam@gmail.com>
Cc: Igor Opaniuk <igor.opaniuk@toradex.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> ________________________________________=0A=
> From: Marcel Ziswiler=0A=
> Sent: Thursday, June 13, 2019 12:05=0A=
> To: festevam@gmail.com; Oleksandr Suvorov=0A=
> Cc: Igor Opaniuk; linux-kernel@vger.kernel.org; alsa-devel@alsa-project.o=
rg=0A=
> Subject: Re: [PATCH v1 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp Co=
ntrol=0A=
> =0A=
> On Tue, 2019-05-21 at 13:36 +0300, Oleksandr Suvorov wrote:=0A=
> > SGTL5000_SMALL_POP is a bit mask, not a value. Usage of=0A=
> > correct definition makes device probing code more clear.=0A=
> >=0A=
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>=0A=
> =0A=
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>=0A=
> =0A=
> > ---=0A=
> >=0A=
> >  sound/soc/codecs/sgtl5000.c | 2 +-=0A=
> >  sound/soc/codecs/sgtl5000.h | 2 +-=0A=
> >  2 files changed, 2 insertions(+), 2 deletions(-)=0A=
> >=0A=
> > diff --git sound/soc/codecs/sgtl5000.c sound/soc/codecs/sgtl5000.c=0A=
> =0A=
> I'm not sure how exactly you generated this patch set but usually git=0A=
> format-patch inserts an additional folder level called a/b which is=0A=
> what git am accepts by default e.g.=0A=
=0A=
I just used patman to generate this set of patches. But my .gitconfig inclu=
ded diff option "noprefix".=0A=
Thanks for pointing me! Fixed. Should I resent regenerated patchset with th=
e prefix?=0A=
 =0A=
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c=0A=
> =0A=
> > index a6a4748c97f9..5e49523ee0b6 100644=0A=
> > --- sound/soc/codecs/sgtl5000.c=0A=
> > +++ sound/soc/codecs/sgtl5000.c=0A=
> =0A=
> Of course, the same a/b stuff applies here:=0A=
> =0A=
> --- a/sound/soc/codecs/sgtl5000.c=0A=
> +++ b/sound/soc/codecs/sgtl5000.c=0A=
> =0A=
> > @@ -1296,7 +1296,7 @@ static int sgtl5000_probe(struct=0A=
> > snd_soc_component *component)=0A=
> >=0A=
> >       /* enable small pop, introduce 400ms delay in turning off */=0A=
> >       snd_soc_component_update_bits(component,=0A=
> > SGTL5000_CHIP_REF_CTRL,=0A=
> > -                             SGTL5000_SMALL_POP, 1);=0A=
> > +                             SGTL5000_SMALL_POP,=0A=
> > SGTL5000_SMALL_POP);=0A=
> >=0A=
> >       /* disable short cut detector */=0A=
> >       snd_soc_component_write(component, SGTL5000_CHIP_SHORT_CTRL,=0A=
> > 0);=0A=
> > diff --git sound/soc/codecs/sgtl5000.h sound/soc/codecs/sgtl5000.h=0A=
> > index 18cae08bbd3a..a4bf4bca95bf 100644=0A=
> > --- sound/soc/codecs/sgtl5000.h=0A=
> > +++ sound/soc/codecs/sgtl5000.h=0A=
> > @@ -273,7 +273,7 @@=0A=
> >  #define SGTL5000_BIAS_CTRL_MASK                      0x000e=0A=
> >  #define SGTL5000_BIAS_CTRL_SHIFT             1=0A=
> >  #define SGTL5000_BIAS_CTRL_WIDTH             3=0A=
> > -#define SGTL5000_SMALL_POP                   1=0A=
> > +#define SGTL5000_SMALL_POP                   0x0001=0A=
> >=0A=
> >  /*=0A=
> >   * SGTL5000_CHIP_MIC_CTRL=0A=
> > --=0A=
> > 2.20.1=
