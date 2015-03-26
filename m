From: Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
Subject: Re: Low volume since linux 3.19
Date: Thu, 26 Mar 2015 16:48:21 +0100
Message-ID: <CAO_aot7JtMwcMB2R95-8RQZM0KZWCkbMpGFM7av=u25ror0_rQ@mail.gmail.com>
References: <CAO_aot5hLoXp1XkJ3SOSSBAYUbZWB63+VD2pGvVL=2gq6dJZUA@mail.gmail.com>
 <s5hiodndg1h.wl-tiwai@suse.de>
 <CAO_aot4w1Xhz652s+6XQwTHH8Bt6LLVYcrpdJPd9_xaBFVgDtg@mail.gmail.com>
 <s5h7fu3deby.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
 [209.85.217.182])
 by alsa0.perex.cz (Postfix) with ESMTP id A93D32657A5
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 16:48:21 +0100 (CET)
Received: by lbbsy1 with SMTP id sy1so44055861lbb.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 08:48:21 -0700 (PDT)
In-Reply-To: <s5h7fu3deby.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Yes, it works (only until next reboot). I assume the "k" after "set"
was a typo. I ran
% amixer amixer -c0 set 'Speaker+LO' 0dB

I have pulseaudio version 6.0

regards,

jhs

2015-03-26 15:26 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
> At Thu, 26 Mar 2015 15:22:28 +0100,
> Jan Hinnerk Stosch wrote:
>>
>> Thx for your quick reply.
>> I ran the script with linux 3.18.6 and 3.19.2 and attached the output
>> in compressed form.
>
> I guess running the following once should recover:
>    % amixer -c0 set k 'Speaker+LO' 0dB
>
> But still the question is who lowered it.  Which PulseAudio version
> are you running?
>
>
> Takashi
>
>>
>> regards,
>>
>> jhs
>>
>> 2015-03-26 14:50 GMT+01:00 Takashi Iwai <tiwai@suse.de>:
>> > At Thu, 26 Mar 2015 13:53:30 +0100,
>> > Jan Hinnerk Stosch wrote:
>> >>
>> >> Hi,
>> >>
>> >> I hope this is the right place to report my issue!?
>> >> Since linux 3.19 I have very low volume on my Fujitsu E753 headphone
>> >> even on highest volume level.
>> >> As I don't have much experience with audio configuration and it worked
>> >> before I did a kernel bisect and found out, that commit
>> >> "03ad6a8c93b6df2d65c305b5b5f9474068b45bfb" is "responsible" for this.
>> >
>> > Adding David to Cc.
>> >
>> >> Is there something that I have to change in my configuration? Or do
>> >> you need some further information?
>> >
>> > Please take alsa-info.sh outputs before and after the patch.  Run the
>> > script with --no-upload option, and attach two output files.  (Maybe
>> > better to compress when attaching.)
>> >
>> > The commit does basically only renaming some control elements.
>> > Possibly some volumes are set lower than before now.
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>> [2 alsainfo.tar.xz <application/x-xz (base64)>]
>>
