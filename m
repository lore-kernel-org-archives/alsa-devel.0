From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v3 2/3] ALSA: usb-audio: More strict sanity
 checks for clock parsers
Date: Fri, 6 Apr 2018 11:47:00 +0300
Message-ID: <CAB=otbQYG8AQtNxnn_h9mmOBjRe9BNGHzzrXHHTxfnCsevTryg@mail.gmail.com>
References: <20180405121113.551-1-tiwai@suse.de>
 <20180405121113.551-3-tiwai@suse.de>
 <CAB=otbS5cTc1jZ5rERZU=3BxaC9e4o07+O1sAyWTo--iS+A=fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B3A60266E30
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 10:47:02 +0200 (CEST)
Received: by mail-ot0-f194.google.com with SMTP id m22-v6so410296otf.10
 for <alsa-devel@alsa-project.org>; Fri, 06 Apr 2018 01:47:02 -0700 (PDT)
In-Reply-To: <CAB=otbS5cTc1jZ5rERZU=3BxaC9e4o07+O1sAyWTo--iS+A=fw@mail.gmail.com>
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

On Fri, Apr 6, 2018 at 2:41 AM, Ruslan Bilovol <ruslan.bilovol@gmail.com> wrote:
> Hi Takashi,
>
> On Thu, Apr 5, 2018 at 3:11 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> The sanity checks introduced for malformed descriptors loosely check
>> the given descriptor size, although the size greater than the defined
>> description is invalid.  It was due to a concern of any funky firmware
>> in the actual products.  But this doesn't look hitting, and any sane
>> products must have the defined descriptors.
>>
>> So in this patch, we make the validators more strict, allowing only
>> with the defined descriptor sizes.
>>
>> Suggested-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> ---
>>  sound/usb/clock.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
>> index 27c2275a2505..cbf68ab01836 100644
>> --- a/sound/usb/clock.c
>> +++ b/sound/usb/clock.c
>> @@ -52,7 +52,7 @@ static void *find_uac_clock_desc(struct usb_host_interface *iface, int id,
>>  static bool validate_clock_source_v2(void *p, int id)
>>  {
>>         struct uac_clock_source_descriptor *cs = p;
>> -       return cs->bLength >= sizeof(*cs) && cs->bClockID == id;
>> +       return cs->bLength == sizeof(*cs) && cs->bClockID == id;

Also I tested scenario which uses only this function (validate_clock_source_v2)
and it works fine to me.

>>  }
>>
>>  static bool validate_clock_source_v3(void *p, int id)
>> @@ -65,7 +65,7 @@ static bool validate_clock_selector_v2(void *p, int id)
>>  {
>>         struct uac_clock_selector_descriptor *cs = p;
>>         return cs->bLength >= sizeof(*cs) && cs->bClockID == id &&
>> -               cs->bLength >= 5 + cs->bNrInPins;
>> +               cs->bLength == 5 + cs->bNrInPins;
>
> This one still has an issue, here we should check it next way:
>                cs->bLength == 7 + cs->bNrInPins;
>
> This is because bLength is 7+bNrInPins as per UAC2 spec, not 5 :P
>
> Thanks,
> Ruslan
>
>>  }
>>
>>  static bool validate_clock_selector_v3(void *p, int id)
>> @@ -77,7 +77,7 @@ static bool validate_clock_selector_v3(void *p, int id)
>>  static bool validate_clock_multiplier_v2(void *p, int id)
>>  {
>>         struct uac_clock_multiplier_descriptor *cs = p;
>> -       return cs->bLength >= sizeof(*cs) && cs->bClockID == id;
>> +       return cs->bLength == sizeof(*cs) && cs->bClockID == id;
>>  }
>>
>>  static bool validate_clock_multiplier_v3(void *p, int id)
>> --
>> 2.16.2
>>



-- 
Best regards,
Ruslan Bilovol
