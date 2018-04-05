From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: usb-audio: Add sanity checks
	in UAC3 clock parsers
Date: Thu, 5 Apr 2018 14:20:25 +0300
Message-ID: <CAB=otbSrxAZbr_QJP9yDZTpnFM6FQBLzdOTHGPnajdTL3qkcqg@mail.gmail.com>
References: <20180404053621.32539-1-tiwai@suse.de>
 <20180404053621.32539-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id BCB58267671
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 13:20:26 +0200 (CEST)
Received: by mail-oi0-f66.google.com with SMTP id q71-v6so22175609oic.6
 for <alsa-devel@alsa-project.org>; Thu, 05 Apr 2018 04:20:26 -0700 (PDT)
In-Reply-To: <20180404053621.32539-4-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Andrew Chant <achant@google.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Wed, Apr 4, 2018 at 8:36 AM, Takashi Iwai <tiwai@suse.de> wrote:
> The UAC3 clock parser codes lack of the sanity checks for malformed
> descriptors like UAC2 parser does.  Without it, the driver may lead to
> a potential crash.
>
> Fixes: 9a2fe9b801f5 ("ALSA: usb: initial USB Audio Device Class 3.0 support")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/clock.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
> index 5e533edfb092..177c6017e22c 100644
> --- a/sound/usb/clock.c
> +++ b/sound/usb/clock.c
> @@ -58,7 +58,7 @@ static bool validate_clock_source_v2(void *p, int id)
>  static bool validate_clock_source_v3(void *p, int id)
>  {
>         struct uac3_clock_source_descriptor *cs = p;
> -       return cs->bClockID == id;
> +       return cs->bLength == sizeof(*cs) && cs->bClockID == id;
>  }
>
>  static bool validate_clock_selector_v2(void *p, int id)
> @@ -71,7 +71,8 @@ static bool validate_clock_selector_v2(void *p, int id)
>  static bool validate_clock_selector_v3(void *p, int id)
>  {
>         struct uac3_clock_selector_descriptor *cs = p;
> -       return cs->bClockID == id;
> +       return cs->bLength == sizeof(*cs) && cs->bClockID == id &&
> +               cs->bLength == 5 + cs->bNrInPins;

Same comments as for UAC2 patch, but in this case bLength should
be "11 + bNrInPins", so finally it should looks like:

       return cs->bLength >= sizeof(*cs) && cs->bClockID == id &&
               cs->bLength == 11 + cs->bNrInPins;


Thanks,
Ruslan

>  }
>
>  static bool validate_clock_multiplier_v2(void *p, int id)
> @@ -83,7 +84,7 @@ static bool validate_clock_multiplier_v2(void *p, int id)
>  static bool validate_clock_multiplier_v3(void *p, int id)
>  {
>         struct uac3_clock_multiplier_descriptor *cs = p;
> -       return cs->bClockID == id;
> +       return cs->bLength == sizeof(*cs) && cs->bClockID == id;
>  }
>
>  #define DEFINE_FIND_HELPER(name, obj, validator, type)         \
> --
> 2.16.2
>
