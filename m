From: Denis Kup <dener.kup@gmail.com>
Subject: Re: Acer Aspire 7730G support
Date: Wed, 24 Jun 2009 21:52:48 +0400
Message-ID: <376f0d430906241052i1e37904bo9c90b98e0dca6077@mail.gmail.com>
References: <376f0d430906240509w7b8e23d4m92e3fc99fabd528@mail.gmail.com>
	<s5heit9ajvk.wl%tiwai@suse.de>
	<376f0d430906240941k699e494cr325f1c091a609f19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id A413924827
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 19:52:48 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so1146156fge.21
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 10:52:48 -0700 (PDT)
In-Reply-To: <376f0d430906240941k699e494cr325f1c091a609f19@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/6/24 Denis Kup <dener.kup@gmail.com>:
> 2009/6/24 Takashi Iwai <tiwai@suse.de>:
>> At Wed, 24 Jun 2009 16:09:58 +0400,
>> Denis Kup wrote:
>>>
>>> Hey, when i first installed alsa to my laptop, there no sound from
>>> subwoofer, jacks were map very strange (2 surrounds for ex.). I try
>>> all models from the list, but all don't support my subwoofer. After a
>>> weak of hard work i made a patch that enables ACER_ASPIRE_7730G model
>>> for my laptop. It have ALC888S, 3 jacks, 6 channels, stereo internal
>>> frontal speakers and internal subwoofer.You can see acer.com for more
>>> info about hardware and jacks.
>>>
>>> It's the changes i made to /alsa-kernel/pci/hda/patch_realtek.c:
>>
>> Can you try Emilio's patch recently posted (and pass
>> model=3Dacer-aspire-6530g) with the very latest alsa-driver-snapshot?
>> This essentially includes your changes. =A0It's in:
>> =A0From: Emilio L=F3pez <buhitoescolar@gmail.com>
>> =A0Subject: Re: [alsa-devel] Regarding Sound on Acer Aspire 6935G
>> =A0Date: Tue, 23 Jun 2009 22:32:45 -0300
>> =A0Message-ID: <d54969c50906231832w48ce7315uc5cf8b3f81534c76@mail.gmail.=
com>
>>
>>> After changing file i install driver, and it automatically detect its
>>> model (maybe there are old settings from previous install, so i dont
>>> 100% sure that it was detected). With this settings subwoofer works
>>> perfect, internal stereo and subwoofer mute when headphone are plugged
>>> all works, except 1 thing: subwoofer uses center channel instead LFE.
>>> To fix it i use such asound.conf file:
>> ...
>>> Is there any chance to swap Center and LFE in patch_realtek.c?
>>
>> Unlikely as ALC888* doesn't support the channel-swap feature (although
>> some other ALC codecs do).
>>
>>
>> thanks,
>>
>> Takashi
>>
>
> You are talking about that
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-June/018815.html
> ?? Its right link to drivers http://www.alsa-project.org/snapshot/ ??
> And there is easier way to apply patches than manually adding strings
> to files?
>

I manage with installing. I use alsa-driver-snapshot.tar.gz
http://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/alsa-driver/
and this Amilo changes
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-June/018815.html
.=A0 But this patch has smaller functionality against i have. There is
advantages and disadvantages of both patches:

My patch:
+ 1) when black jack plugged, internal speakers and subwoofer mute
+ 2) there is 3 maps for jacks: (black/pink/blue) 2ch: front/ext mic/
(something i dont know, it should be line in), 4ch: front/ ext mic/
side 6ch: front/ CLFE / side; (its changes in channel mode option in
mixer)
+ 3) internal mic works
+ 4) there are separate boost mic channels for internal and external mics
- 5) internal subwoofer controls with Center channel in mixer
? 6) i dont know how line in works (i will check it when reinstall to my pa=
tch)
? 7) i dont know how spdif works, because i have not any spdif speakers in =
house

Amilo patch:
- 1) when black jack pluged, only internal speaker mutes, subwoofer
continue to work (it has no meaning when i listen to music in
headphones)
- 2) there is only 1 map for jacks: front/ext mic/ (something i dont
know, it should be line in)
- 3) there no side and center channels
- 3) internal mic dont work
- 4) there no line in in input source menu in mixer
+ 5) Subwoofer controls with LFE channel in mixer
? 7) i dont know how spdif works, because i have not any spdif speakers in =
house
