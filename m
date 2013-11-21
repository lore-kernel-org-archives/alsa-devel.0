From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: acceptable noise level for mic boost
Date: Thu, 21 Nov 2013 17:26:52 +0100
Message-ID: <528E344C.2030503@rempel-privat.de>
References: <528E2838.8050208@rempel-privat.de> <s5ha9gxoj7f.wl%tiwai@suse.de>
 <528E2B7D.6080305@rempel-privat.de> <s5h7gc1oiq9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 0331E260376
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 17:26:54 +0100 (CET)
Received: from [192.168.1.138] ([93.218.98.132]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M5a9E-1VUKcn2fsm-00xau3 for
 <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 17:26:53 +0100
In-Reply-To: <s5h7gc1oiq9.wl%tiwai@suse.de>
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

Am 21.11.2013 16:52, schrieb Takashi Iwai:
> At Thu, 21 Nov 2013 16:49:17 +0100,
> Oleksij Rempel wrote:
>>
>> Am 21.11.2013 16:41, schrieb Takashi Iwai:
>>> At Thu, 21 Nov 2013 16:35:20 +0100,
>>> Oleksij Rempel wrote:
>>>>
>>>> Hello Takashi,
>>>>
>>>> what is acceptable noise level for mic boost?
>>>> My laptop has three levels of mic boost (+36dB). Level 3 is useless
>>>> since noise level will be about 0db. With level 1 i get -12dB noise, so
>>>> there is almost 12dB room for data... but it is not enough for normal
>>>> speech, which is about 20dB.
>>>>
>>>> Are there any ALSA guide for HW designers, which will say some thing
>>>> like acceptable levels are 90-20dB?
>>>> There are some Skype and Microsoft prescriptions for certification.
>>>> For example M$ prescribe 18dB or more for speech to noise ration for
>>>> build in mics. It sound like good number to start.
>>>
>>> We have no concrete guideline.  Ask anyone's common sense :)
>>> Actually we already disabled the high mic boost on some machines that
>>> don't make much sense.
>>
>> Suddenly no one answered this question on IRC or mailing list. It will
>> save some time to have some sort of recommendation ;)
>> This issue is not dramatic for normal use. But with VoIP and automatic
>> gain control it make no really noise effects.
>>
>>>> In my case, i need to remove mic boost completely to guarantee minimum
>>>> 18dB SpNR. Suddenly i didn't found correct way to do it.
>>>> I will be thankful for some tip.
>>>
>>> You can add a fixup to override the amp cap.  Take a look at
>>> patch_realtek.c, e.g. alc269_fixup_limit_int_mic_boost().
>>
>> I started with this function, but if i set number of steps to 0,
>> alsamixer will fail and pulseaudio just ignore this pin.
> 
> Give it 1, just like the function above does.

Hmm... patch_ca0132.c avoid mic boost for dmics. May be it is better way?


-- 
Regards,
Oleksij
