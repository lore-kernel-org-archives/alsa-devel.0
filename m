From: Kailang <kailang@realtek.com>
Subject: Re: Set eapd to follow stream on or off
Date: Tue, 20 May 2014 16:52:43 +0800
Message-ID: <72897913D05F4C12BCED9FF890C77D61@realtek.com.tw>
References: <3143A3763CC94AB9AAD48E43EA2B4DFC@realtek.com.tw>
 <s5h8upw6gf6.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 124F3261B36
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 10:52:52 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> At Tue, 20 May 2014 15:15:49 +0800,
> Kailang wrote:
>>
>> Hi Takashi,
>>
>> HP machine had pop noise via speaker.
>> If EAPD on or off, speaker will have pop noise.
>> So, they want to set eapd to follow with stream on or off.
>
> I can apply this as is, but still I wonder whether this results in
> other problems.  Doing EAPD on/off there means that it happens far
> more often.  For example, what happens if you do like below?
>
>     while true; do
>       echo -n > /dev/snd/pcmC0D0p
>     done
>
> And, what if the device is resumed from power-saving by an audio
> playback?  Immediately after the power up, it'll start the streaming,
> so it'll turn on EAPD.
>
> That said, isn't it just a need for some delay before EAPD on/off?

No, eapd on or off will cause pop noise.
Our customer just want to do eapd on when stream is open.
The pop noise will not clear. Because music gain was biger than pop noise.

>
> thanks,
>
> Takashi
>
>>
>> Many Thanks.
>>
>> BR,
>> Kailang
>> [2 0000-set-eapd-follow-stream-on-off.patch <application/octet-stream 
>> (quoted-printable)>]
>>
>
> ------Please consider the environment before printing this e-mail. 
