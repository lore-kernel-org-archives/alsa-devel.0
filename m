From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 1/4] ALSA: line6: Add toneport_has_source_select()
Date: Fri, 6 Feb 2015 09:07:40 -0600
Message-ID: <CAEUsAPa6+nmooA0DAt9dFTgaYqBCxRaLVPge71gWOfYY=P_yYw@mail.gmail.com>
References: <1423234272-7348-1-git-send-email-chris@rorvick.com>
	<1423234272-7348-2-git-send-email-chris@rorvick.com>
	<s5hioffw0kw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hioffw0kw.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 6, 2015 at 8:56 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri,  6 Feb 2015 08:51:09 -0600, Chris Rorvick wrote:
>> --- a/sound/usb/line6/toneport.c
>> +++ b/sound/usb/line6/toneport.c
>> @@ -343,6 +343,20 @@ static void toneport_remove_leds(struct usb_line6_toneport *toneport)
>>       }
>>  }
>>
>> +static bool toneport_has_source_select(struct usb_line6_toneport *toneport)
>> +{
>> +     switch (toneport->type) {
>> +     case LINE6_TONEPORT_UX1:
>> +     case LINE6_TONEPORT_UX2:
>> +     case LINE6_PODSTUDIO_UX1:
>> +     case LINE6_PODSTUDIO_UX2:
>> +             return 1;
>> +
>> +     default:
>> +             return 0;
>
> Please use true and false.

Thanks, I've fixed this up and will send in a v2.

Regards,

Chris
