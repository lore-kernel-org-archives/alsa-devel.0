From: Andrew Chant <achant@google.com>
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Refactor clock finder
	helpers
Date: Tue, 3 Apr 2018 10:18:33 -0700
Message-ID: <CANVWZtHAoBP1K6F0LfcMbGodQ0a0o33SGq+S1MDuJJAm5c6YHg@mail.gmail.com>
References: <20180403154808.21947-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id E6DD22675DB
 for <alsa-devel@alsa-project.org>; Tue,  3 Apr 2018 19:19:14 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id v21so35332803wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 03 Apr 2018 10:19:14 -0700 (PDT)
In-Reply-To: <20180403154808.21947-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Ruslan Bilovol <ruslan.bilovol@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 3, 2018 at 8:48 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
> There are lots of open-coded functions to find a clock source,
> selector and multiplier.  Now there are both v2 and v3, so six
> variants.
>
> This patch refactors the code to use a common helper for the main
> loop, and define each validator function for each target.
> There is no functional change.
>
> Fixes: 9a2fe9b801f5 ("ALSA: usb: initial USB Audio Device Class 3.0 support")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/clock.c | 127 +++++++++++++++++++++++-------------------------------
>  1 file changed, 53 insertions(+), 74 deletions(-)
>
> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
> index ab39ccb974c6..c5f0cf532c0c 100644
> --- a/sound/usb/clock.c
> +++ b/sound/usb/clock.c
> @@ -35,105 +35,84 @@
>  #include "clock.h"
>  #include "quirks.h"
>
> -static struct uac_clock_source_descriptor *
> -       snd_usb_find_clock_source(struct usb_host_interface *ctrl_iface,
> -                                 int clock_id)
> +static void *find_descriptor(struct usb_host_interface *iface, int id,
> +                            bool (*validator)(void *, int), u8 type)

this comment isn't very important, and might be wrong:
find_descriptor is a very generic name, it might make grepping a
little confusing.
Could you use find_clock_descriptor? find_uac_clock_descriptor?

>  {
> -       struct uac_clock_source_descriptor *cs = NULL;
> +       void *cs = NULL;
>
> -       while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
> -                                            ctrl_iface->extralen,
> -                                            cs, UAC2_CLOCK_SOURCE))) {
> -               if (cs->bLength >= sizeof(*cs) && cs->bClockID == clock_id)
> +       while ((cs = snd_usb_find_csint_desc(iface->extra, iface->extralen,
> +                                            cs, type))) {
> +               if (validator(cs, id))
>                         return cs;
>         }
>
>         return NULL;
>  }
>
> -static struct uac3_clock_source_descriptor *
> -       snd_usb_find_clock_source_v3(struct usb_host_interface *ctrl_iface,
> -                                 int clock_id)
> +static bool validate_clock_source_v2(void *p, int id)
>  {
> -       struct uac3_clock_source_descriptor *cs = NULL;
> -
> -       while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
> -                                            ctrl_iface->extralen,
> -                                            cs, UAC3_CLOCK_SOURCE))) {
> -               if (cs->bClockID == clock_id)
> -                       return cs;
> -       }
> -
> -       return NULL;
> +       struct uac_clock_source_descriptor *cs = p;
> +       return cs->bLength >= sizeof(*cs) && cs->bClockID == id;
>  }
>
> -static struct uac_clock_selector_descriptor *
> -       snd_usb_find_clock_selector(struct usb_host_interface *ctrl_iface,
> -                                   int clock_id)
> +static bool validate_clock_source_v3(void *p, int id)
>  {
> -       struct uac_clock_selector_descriptor *cs = NULL;
> -
> -       while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
> -                                            ctrl_iface->extralen,
> -                                            cs, UAC2_CLOCK_SELECTOR))) {
> -               if (cs->bLength >= sizeof(*cs) && cs->bClockID == clock_id) {
> -                       if (cs->bLength < 5 + cs->bNrInPins)
> -                               return NULL;
> -                       return cs;
> -               }
> -       }
> -
> -       return NULL;
> +       struct uac3_clock_source_descriptor *cs = p;
> +       return cs->bClockID == id;

uac3_clock_source_descriptor has a fixed size (12).
Consider a sizeof() check here to be consistent?

>  }
>
> -static struct uac3_clock_selector_descriptor *
> -       snd_usb_find_clock_selector_v3(struct usb_host_interface *ctrl_iface,
> -                                   int clock_id)
> +static bool validate_clock_selector_v2(void *p, int id)
>  {
> -       struct uac3_clock_selector_descriptor *cs = NULL;
> -
> -       while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
> -                                            ctrl_iface->extralen,
> -                                            cs, UAC3_CLOCK_SELECTOR))) {
> -               if (cs->bClockID == clock_id)
> -                       return cs;
> -       }
> -
> -       return NULL;
> +       struct uac_clock_selector_descriptor *cs = p;
> +       return cs->bLength >= sizeof(*cs) && cs->bClockID == id &&
> +               cs->bLength >= 5 + cs->bNrInPins;
>  }
>
> -static struct uac_clock_multiplier_descriptor *
> -       snd_usb_find_clock_multiplier(struct usb_host_interface *ctrl_iface,
> -                                     int clock_id)
> +static bool validate_clock_selector_v3(void *p, int id)
>  {
> -       struct uac_clock_multiplier_descriptor *cs = NULL;
> -
> -       while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
> -                                            ctrl_iface->extralen,
> -                                            cs, UAC2_CLOCK_MULTIPLIER))) {
> -               if (cs->bLength >= sizeof(*cs) && cs->bClockID == clock_id)
> -                       return cs;
> -       }
> -
> -       return NULL;
> +       struct uac3_clock_selector_descriptor *cs = p;
> +       return cs->bClockID == id;
clock cs->bLength should be 11+ bytes for a v3 clock selector descriptor.
consider an >= size check. (I don't know how sizeof works with
[]-terminated structs)

>  }
>
> -static struct uac3_clock_multiplier_descriptor *
> -       snd_usb_find_clock_multiplier_v3(struct usb_host_interface *ctrl_iface,
> -                                     int clock_id)
> +static bool validate_clock_multiplier_v2(void *p, int id)
>  {
> -       struct uac3_clock_multiplier_descriptor *cs = NULL;
> +       struct uac_clock_multiplier_descriptor *cs = p;
> +       return cs->bLength >= sizeof(*cs) && cs->bClockID == id;
> +}
>
> -       while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
> -                                            ctrl_iface->extralen,
> -                                            cs, UAC3_CLOCK_MULTIPLIER))) {
> -               if (cs->bClockID == clock_id)
> -                       return cs;
> -       }
> +static bool validate_clock_multiplier_v3(void *p, int id)
> +{
> +       struct uac3_clock_multiplier_descriptor *cs = p;
> +       return cs->bClockID == id;
uac3_clock_multiplier_descriptor has fixed size (11)

> +}
>
> -       return NULL;
> +#define DEFINE_FIND_HELPER(name, obj, validator, type)         \
> +static obj *name(struct usb_host_interface *iface, int id)     \
> +{                                                              \
> +       return find_descriptor(iface, id, validator, type);     \
>  }
>
> +DEFINE_FIND_HELPER(snd_usb_find_clock_source,
> +                  struct uac_clock_source_descriptor,
> +                  validate_clock_source_v2, UAC2_CLOCK_SOURCE);
> +DEFINE_FIND_HELPER(snd_usb_find_clock_source_v3,
> +                  struct uac3_clock_source_descriptor,
> +                  validate_clock_source_v3, UAC3_CLOCK_SOURCE);
> +
> +DEFINE_FIND_HELPER(snd_usb_find_clock_selector,
> +                  struct uac_clock_selector_descriptor,
> +                  validate_clock_selector_v2, UAC2_CLOCK_SELECTOR);
> +DEFINE_FIND_HELPER(snd_usb_find_clock_selector_v3,
> +                  struct uac3_clock_selector_descriptor,
> +                  validate_clock_selector_v3, UAC3_CLOCK_SELECTOR);
> +
> +DEFINE_FIND_HELPER(snd_usb_find_clock_multiplier,
> +                  struct uac_clock_multiplier_descriptor,
> +                  validate_clock_multiplier_v2, UAC2_CLOCK_MULTIPLIER);
> +DEFINE_FIND_HELPER(snd_usb_find_clock_multiplier_v3,
> +                  struct uac3_clock_multiplier_descriptor,
> +                  validate_clock_multiplier_v3, UAC3_CLOCK_MULTIPLIER);
> +
>  static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int selector_id)
>  {
>         unsigned char buf;
> --
> 2.16.2
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
