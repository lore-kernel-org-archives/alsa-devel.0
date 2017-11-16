From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix out-of-bound error
Date: Thu, 16 Nov 2017 09:42:38 +0900
Message-ID: <CAL6iAa+ntXgBO0OXkR+QiL2Mus-NSry64q7g=Bj4aDtVEkw9zw@mail.gmail.com>
References: <1510733261-28878-1-git-send-email-climbbb.kim@gmail.com>
 <CAL6iAaJTKi+S4izrrbjdceuqHMHOwqDEYO2Mx9-B4Z8F7GrohQ@mail.gmail.com> <s5hefozc36l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hefozc36l.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, stable <stable@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, Takashi

2017-11-15 18:16 GMT+09:00 Takashi Iwai <tiwai@suse.de>:
> On Wed, 15 Nov 2017 09:57:56 +0100,
> Jaejoong Kim wrote:
>>
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index e630813..5a83c2c 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -204,7 +204,8 @@ static int snd_usb_copy_string_desc(struct mixer_build
>> *state,
>>                                     int index, char *buf, int maxlen)
>>  {
>>         int len = usb_string(state->chip->dev, index, buf, maxlen - 1);
>> -       buf[len] = 0;
>> +       if (len > 0)
>> +               buf[len] = 0;
>>         return len;
>
> I'd rather put an explicit error bail-out, i.e.
>
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 91bc8f18791e..296a63a9d09c 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -204,6 +204,10 @@ static int snd_usb_copy_string_desc(struct mixer_build *state,
>                                     int index, char *buf, int maxlen)
>  {
>         int len = usb_string(state->chip->dev, index, buf, maxlen - 1);
> +
> +       if (len < 0)
> +               return len;
> +
>         buf[len] = 0;
>         return len;
>  }

OK.

I will resend v2 patch with your suggestion.

>
>
> thanks,
>
> Takashi

thanks,
Jaejoong
