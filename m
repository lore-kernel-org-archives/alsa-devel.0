Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCDEC433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Nov 2022 12:19:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8D69167C;
	Wed,  2 Nov 2022 13:18:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8D69167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667391546;
	bh=tyZNlfK/1fkc8GNSZBy6JuS9KEVf+ZDtfdMUZ2lkuJQ=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1PGKWzrKrD52XzGRkKKg3w5HzGZWQ9LDHmoW057n3rXDVHbMOaetqU3GS9C7DMWM
	 hXC06qS5pL8AqcFsTMVDT4V3HSd6lZIU2fx9j5vXUC8j9mczvWx2xKT+JbLktpf3eD
	 BbyPXHYEiidPVukPr+XHiouxGjKs6Me9GzX58WY8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84B76F80155;
	Wed,  2 Nov 2022 13:18:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97F93F8026D; Wed,  2 Nov 2022 13:18:14 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D618CF801D5
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2022 13:18:08 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id DBAEBA003F;
 Wed,  2 Nov 2022 13:18:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz DBAEBA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1667391487; bh=TcRG5+xRiV+q9rszSCP2s0S2r/g2Xm/JVyWPLRFXRO8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KFex+owpxuEfI1faIHlXvtPmgZUMbL+k8YUg2P2d5O4DSzhVsrJ/x0QGz5m1aA40h
 pUrjF3jLeMfjSzVygm1Hz0l6abTUQAJh+sgecLzuzVlS0pHB+cum3TzQu5OHVYHxaw
 YW1QHGgi3lGju+2KfEUQDNwFkIpkzeIBrEc4HcqU=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  2 Nov 2022 13:18:05 +0100 (CET)
Message-ID: <8166d07d-804b-f81e-7b2b-c848da851527@perex.cz>
Date: Wed, 2 Nov 2022 13:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: usb-audio: Fix regression with Dell Dock jack
 detection
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
References: <20221102113404.11291-1-tiwai@suse.de>
 <9b0c4f2d-1856-a80d-ad9d-9b34436fdc1c@perex.cz> <877d0dtvm2.wl-tiwai@suse.de>
 <8735b1tvbs.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <8735b1tvbs.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 02. 11. 22 13:05, Takashi Iwai wrote:
> On Wed, 02 Nov 2022 12:59:49 +0100,
> Takashi Iwai wrote:
>>
>> On Wed, 02 Nov 2022 12:53:48 +0100,
>> Jaroslav Kysela wrote:
>>>
>>> On 02. 11. 22 12:34, Takashi Iwai wrote:
>>>> The recent commit added Jack controls to Dell Dock, but it added with
>>>> iface = SNDRV_CTL_ELEM_IFACE_CARD.  Unfortunately this doesn't match
>>>> with the changes in user-space UCM profile, which expects iface =
>>>> SNDRV_CTL_ELEM_IFACE_MIXER as default.  This mismatch resulted in the
>>>> non-working profile, and the Dell Dock is gone on pipewire /
>>>> PulseAudio after the kernel update.
>>>>
>>>> Fix the regression by adjusting the iface of the new ctl elements to
>>>> *_MIXER.
>>>
>>> Hi Takashi,
>>>
>>> UCM expects SNDRV_CTL_ELEM_IFACE_CARD for jacks by default. Which
>>> change do you refer? I would drop this patch.
>>
>> It's about ucm2/USB-Audio/Dell/WD15-Dock-HiFi.conf, the JackControl
>> entries.  For example,
>> 		JackControl "Headphone Jack"
>> expects the mixer element.  The bad thing is that the complete card
>> entry disappears because of inconsistency.
>> If you modify the entry as
>> 		JackControl "name='Headphone Jack',iface=CARD"
>> it would work.  But the fact that other JackControl stuff works, it's
>> better to align the USB-audio with IFACE_MIXER, I guess.
> 
> Hm, looking at the UCM code, UCM should treat IFACE_CARD as default,
> indeed.  Something went south.  Will take a deeper look.

Perhaps, it's this issue - 
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2744 . The 
configuration for the Dell's docking station has also defined all jacks. If 
only an output equipment is connected, the pipewire may set the profile as not 
available. My fix (MR1429) should work. No idea why this issue is not visible 
in PA.

 From alsa-info (from the OpenSuse bug), jack states:

	name 'Line Out Jack' 	value true
	name 'Headphone Jack' 	value false
	name 'Headset Mic Jack'	value false

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
