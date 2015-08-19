From: Yao-Wen Mao <yaowen@google.com>
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Add a volume scale
 quirk for AudioQuest DragonFly
Date: Wed, 19 Aug 2015 11:00:15 +0800
Message-ID: <CAHjFKHzUTyZXZGmbw7+pZdwS_HYDGejZvsCvMYXST=asvwnSBw@mail.gmail.com>
References: <1439729413-30804-1-git-send-email-anssi.hannula@iki.fi>
 <s5hmvxqj904.wl-tiwai@suse.de> <55D20548.2060004@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D3D35261B36
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 05:00:16 +0200 (CEST)
Received: by lbbpu9 with SMTP id pu9so115317971lbb.3
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 20:00:16 -0700 (PDT)
In-Reply-To: <55D20548.2060004@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 18, 2015 at 12:01 AM, Anssi Hannula <anssi.hannula@iki.fi>
wrote:

> Hi,
>
> 17.08.2015, 17:16, Takashi Iwai kirjoitti:
> > On Sun, 16 Aug 2015 14:50:12 +0200,
> > Anssi Hannula wrote:
> >>
> >> AudioQuest DragonFly DAC reports a volume control range of 0..50
> >> (0x0000..0x0032) which in USB Audio means a range of 0 .. 0.2dB, which
> >> is obviously incorrect and causes software using the dB information in
> >> e.g. volume sliders to have a massive volume difference in 100..102%
> >> range.
> >>
> >> The actual volume mapping seems to be neither linear volume nor linear
> >> dB scale, but instead quite close to the cubic mapping e.g. alsamixer
> >> uses, with a range of -53...0 dB.
> >>
> >> Add a quirk for DragonFly to use a custom dB mapping, based on my
> >> measurements, using a 10-item range TLV (so it still fits in alsa-lib
> >> MAX_TLV_RANGE_SIZE).
> >>
> >> Tested on AudioQuest DragonFly HW v1.2. The quirk is only applied if the
> >> range is 0..50, so if this gets fixed/changed in later HW revisions it
> >> will no longer be applied.
> >>
> >> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> >> Cc: <stable@vger.kernel.org>
> >> ---
> >>  sound/usb/mixer_quirks.c | 37 +++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 37 insertions(+)
> >>
> >> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> >> index 337c317ead6f..39d7f34e44e6 100644
> >> --- a/sound/usb/mixer_quirks.c
> >> +++ b/sound/usb/mixer_quirks.c
> >> @@ -37,6 +37,7 @@
> >>  #include <sound/control.h>
> >>  #include <sound/hwdep.h>
> >>  #include <sound/info.h>
> >> +#include <sound/tlv.h>
> >>
> >>  #include "usbaudio.h"
> >>  #include "mixer.h"
> >> @@ -1733,6 +1734,38 @@ static int snd_microii_controls_create(struct
> usb_mixer_interface *mixer)
> >>      return 0;
> >>  }
> >>
> >> +static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface
> *mixer)
> >> +{
> >> +    struct usb_mixer_elem_list *list;
> >> +    struct usb_mixer_elem_info *cval;
> >> +    static const int unit_id = 7;
> >> +
> >> +    /* approximation using 10 ranges based on output measurement on hw
> v1.2 */
> >> +    static const DECLARE_TLV_DB_RANGE(scale,
> >> +             0,  1, TLV_DB_MINMAX_ITEM(-5300, -4970),
> >> +             2,  5, TLV_DB_MINMAX_ITEM(-4710, -4160),
> >> +             6,  7, TLV_DB_MINMAX_ITEM(-3884, -3710),
> >> +             8, 14, TLV_DB_MINMAX_ITEM(-3443, -2560),
> >> +            15, 16, TLV_DB_MINMAX_ITEM(-2475, -2324),
> >> +            17, 19, TLV_DB_MINMAX_ITEM(-2228, -2031),
> >> +            20, 26, TLV_DB_MINMAX_ITEM(-1910, -1393),
> >> +            27, 31, TLV_DB_MINMAX_ITEM(-1322, -1032),
> >> +            32, 40, TLV_DB_MINMAX_ITEM(-968, -490),
> >> +            41, 50, TLV_DB_MINMAX_ITEM(-441, 0),
> >> +    );
> >> +
> >> +    for (list = mixer->id_elems[unit_id]; list; list =
> list->next_id_elem) {
> >> +            cval = (struct usb_mixer_elem_info *)list;
> >> +            if (cval->control == UAC_FU_VOLUME &&
> >> +                cval->min == 0 && cval->max == 50) {
> >> +                    usb_audio_info(mixer->chip, "applying DragonFly dB
> scale quirk\n");
> >> +                    list->kctl->tlv.p = scale;
> >> +                    list->kctl->vd[0].access |=
> SNDRV_CTL_ELEM_ACCESS_TLV_READ;
> >> +                    list->kctl->vd[0].access &=
> ~SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
> >> +            }
> >> +    }
> >
> > Instead of looking through the list, just hooking at
> > build_feature_ctl() would be simpler in the end, I think.
> > E.g. something like:
> >
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -1334,6 +1334,7 @@ static void build_feature_ctl(struct mixer_build
> *state, void *raw_desc,
> >                               SNDRV_CTL_ELEM_ACCESS_TLV_READ |
> >                               SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
> >               }
> > +             mixer_fu_apply_quirk(state->mixer, cval, unitid, kctl);
> >       }
> >
> >       range = (cval->max - cval->min) / cval->res;
> >
> > ... and the quirk implementation in mixer_quirks.c like
> >
> > static void snd_dragonfly_quirk_db_scale(mixer, kctl)
> > {
> >       usb_audio_info(mixer->chip, "applying DragonFly dB scale quirk\n");
> >       kctl->tlv.p = scale;
> >       kctl->vd[0].access |=  SNDRV_CTL_ELEM_ACCESS_TLV_READ;
> >       list->kctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
> > }
> >
> > void mixer_fu_apply_quirk(mixer, cval, unitid, kctl)
> > {
> >       switch (mixer->chip->usb_id) {
> >       case USB_ID(0x21b4, 0x0081): /* AudioQuest DragonFly */
> >               if (unitid == 7 && cval->min == 0 && cval->max == 50)
> >                       snd_dragonfly_quirk_db_scale(mixer, kctl);
> >               break;
> >       }
> > }
>
> OK, seems like a good idea.
>
> However, I just noticed another volume quirk for DragonFly has already
> been merged since I started looking into this:
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=2d1cb7f658fb9c3ba8f9dab8aca297d4dfdec835
>
> It sets a fixed dB linear range map of 0...50dB via mixer_maps.c, which
> doesn't seem 100% right to me. While it is much better than the
> unquirked 0...0.2dB, it causes e.g. pulseaudio mixer to show the nearly
> inaudible raw 0 as the "base" level. And, unless I made some silly
> mistake, the volume scale is not actually linear dB AFAICS.
>
> Yao-Wen, did you have some basis for the assumption "dB conversion
> factor is 1" on DragonFly other than that it sounded approximately right?
>

No. I used this assumption because I didn't have a good measuring
instrument.
You can just remove my quirk and use yours. Thanks!


> Takashi, should I add removal of that "duplicate" quirk in the same
> commit (or a separate one)? (assuming my quirk turns out to be actually
> better/correct, of course)
>
> --
> Anssi Hannula
>
>
