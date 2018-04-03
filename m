From: Andrew Chant <achant@google.com>
Subject: Re: [PATCH 2/2] ALSA: usb-audio: Add sanity checks in
 v3 clock parsers
Date: Tue, 3 Apr 2018 10:23:19 -0700
Message-ID: <CANVWZtHhZRZoQYr8moY2oWKmCadegSdhQgE+fpD_iu2HbZhC9Q@mail.gmail.com>
References: <20180403154808.21947-1-tiwai@suse.de>
 <20180403154808.21947-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4877F2675FA
 for <alsa-devel@alsa-project.org>; Tue,  3 Apr 2018 19:24:01 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id p53so19461067wrc.10
 for <alsa-devel@alsa-project.org>; Tue, 03 Apr 2018 10:24:01 -0700 (PDT)
In-Reply-To: <20180403154808.21947-2-tiwai@suse.de>
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
> index c5f0cf532c0c..169fb3ac3715 100644
> --- a/sound/usb/clock.c
> +++ b/sound/usb/clock.c
> @@ -58,7 +58,7 @@ static bool validate_clock_source_v2(void *p, int id)
>  static bool validate_clock_source_v3(void *p, int id)
>  {
>         struct uac3_clock_source_descriptor *cs = p;
> -       return cs->bClockID == id;
> +       return cs->bLength >= sizeof(*cs) && cs->bClockID == id;
>  }
>
>  static bool validate_clock_selector_v2(void *p, int id)
> @@ -71,7 +71,8 @@ static bool validate_clock_selector_v2(void *p, int id)
>  static bool validate_clock_selector_v3(void *p, int id)
>  {
>         struct uac3_clock_selector_descriptor *cs = p;
> -       return cs->bClockID == id;
> +       return cs->bLength >= sizeof(*cs) && cs->bClockID == id &&
> +               cs->bLength >= 5 + cs->bNrInPins;
>  }
>
>  static bool validate_clock_multiplier_v2(void *p, int id)
> @@ -83,7 +84,7 @@ static bool validate_clock_multiplier_v2(void *p, int id)
>  static bool validate_clock_multiplier_v3(void *p, int id)
>  {
>         struct uac3_clock_multiplier_descriptor *cs = p;
> -       return cs->bClockID == id;
> +       return cs->bLength >= sizeof(*cs) && cs->bClockID == id;
>  }
>
>  #define DEFINE_FIND_HELPER(name, obj, validator, type)         \
> --
> 2.16.2
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

These address all the comments I had on patch 1. sorry for the noise.
