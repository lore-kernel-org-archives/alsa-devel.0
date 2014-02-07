From: Hendrik-Jan Heins <hjheins@gmail.com>
Subject: Re: Sony Vaio Pro svp112a1cm
Date: Fri, 7 Feb 2014 19:23:39 +0100
Message-ID: <CAAU0D9eVs=QrrsznzWeGymF8ejSz_N-tCvGG1vqYVo+etmJaog@mail.gmail.com>
References: <CAAU0D9cXafhbUY9bOf9AK_uUpYszV5BuoM5d3vHJjhFQbifxqQ@mail.gmail.com>
 <s5h7g9ajagu.wl%tiwai@suse.de>
 <CAAU0D9ewA38Yqq0FhebF1DNtwGPaEv5kk1Pp3OBoeNrOz3zMnA@mail.gmail.com>
 <s5hob2jtbmt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com
 [209.85.217.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 36CC4265372
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 19:23:40 +0100 (CET)
Received: by mail-lb0-f177.google.com with SMTP id 10so1447823lbg.36
 for <alsa-devel@alsa-project.org>; Fri, 07 Feb 2014 10:23:39 -0800 (PST)
In-Reply-To: <s5hob2jtbmt.wl%tiwai@suse.de>
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
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Good to hear.
thanks a lot Takashi!

Hendrik-Jan

2014-02-07 12:17 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
> At Fri, 7 Feb 2014 08:47:18 +0100,
> Hendrik-Jan Heins wrote:
>>
>> Dear Takashi,
>>
>> I just went ahead and gave it a shot the way I hoped it should work.
>> The internal and the headphone microphone is now appearing in alsa,
>> and they are both working.
>>
>> The patch is indeed very simple as you said; I just changed the
>> deviceID to the correct one, and it works.
>
> OK, good to hear!
>
> Now I applied the fix patch to sound git tree.  It should be included
> in 3.14-rc3 (slipped from rc2 pull request that was already sent) and
> will be backported to stable kernels after that.
>
>
> thanks,
>
> Takashi
>
>>
>> please find it attached.
>>
>> best regards,
>>
>> Hendrik-Jan
>>
>> 2014-02-05 8:16 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
>> > At Tue, 4 Feb 2014 23:04:08 +0100,
>> > Hendrik-Jan Heins wrote:
>> >>
>> >> Dear list,
>> >>
>> >> to report the Spny Vaio Pro svp112a1cm
>> >> THe sound device in this notebook works, but the internal microphone not.
>> >> This seeems to be the same device as in teh 13 inch version of this
>> >> laptop, but they seem to have changed the ID of the device.
>> >> Maybe the same fix can be applied to fix?
>> >
>> > If adding your id makes it working, just let us know (or submit a fix
>> > patch).
>> >
>> > That fixup is basically to disable the pin detection at NID 0x18 where
>> > reports a bogus state due to the TRRS headset jack.
>> >
>> >
>> > Takashi
>> >
>> >> All details of the machine are available here:
>> >> http://www.alsa-project.org/db/?f=970d897015298925b86d4d2c68a106fba22eb184
>> >>
>> >> thank you.
>> >>
>> >> best regards,
>> >>
>> >> Hendrik-Jan
>> >> _______________________________________________
>> >> Alsa-devel mailing list
>> >> Alsa-devel@alsa-project.org
>> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>
