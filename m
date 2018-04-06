From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v3 3/3] ALSA: usb-audio: Add sanity checks
	in UAC3 clock parsers
Date: Fri, 6 Apr 2018 11:45:18 +0300
Message-ID: <CAB=otbRP4aJyacMHn4_ahDmrpL6KS1XyKcunpz686tK-s-1AYA@mail.gmail.com>
References: <20180405121113.551-1-tiwai@suse.de>
 <20180405121113.551-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 99B112676B2
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 10:45:20 +0200 (CEST)
Received: by mail-ot0-f193.google.com with SMTP id n40-v6so416972otd.3
 for <alsa-devel@alsa-project.org>; Fri, 06 Apr 2018 01:45:20 -0700 (PDT)
In-Reply-To: <20180405121113.551-4-tiwai@suse.de>
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

On Thu, Apr 5, 2018 at 3:11 PM, Takashi Iwai <tiwai@suse.de> wrote:
> The UAC3 clock parser codes lack of the sanity checks for malformed
> descriptors like UAC2 parser does.  Without it, the driver may lead to
> a potential crash.

Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

And also I tested this patch along with patch #1 and don't see any issue,
so feel free to add to both:

Tested-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

Thanks,
Ruslan

>
> Fixes: 9a2fe9b801f5 ("ALSA: usb: initial USB Audio Device Class 3.0 support")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/clock.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
> index cbf68ab01836..29b7c85635e3 100644
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
> +       return cs->bLength >= sizeof(*cs) && cs->bClockID == id &&
> +               cs->bLength == 11 + cs->bNrInPins;
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
