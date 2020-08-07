Return-Path: <SRS0=pDBX=BR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B741C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:28:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB4B221E5
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Aug 2020 17:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m7wq3ivg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alarmhandy.de header.i=@alarmhandy.de header.b="R+f20CTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB4B221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alarmhandy.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53F7811C;
	Fri,  7 Aug 2020 19:27:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53F7811C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596821290;
	bh=5NjdGEFNiahqTUOxV06mMG7DlqYpTgA34iTUECwB/W4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m7wq3ivgmjv5mvr3MWTvweiTtiZ//5/dXSXIsEs7ueIwUto9W4vNMw5UVUWcf3X4M
	 7+QzgoicKm3qq9z4kbNCO8XVTkhUFp93pMyveTCWHs6QjJQGBoSiCJ7X7RsUuR5Nqe
	 MJ32T8VHR+CJf/9FzgQ3PqFyejJ4iSyBOPJTI7BE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C64A0F8020B;
	Fri,  7 Aug 2020 19:27:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CD32F80218; Fri,  7 Aug 2020 19:27:17 +0200 (CEST)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25FACF800AB
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2020 19:27:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25FACF800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=alarmhandy.de header.i=@alarmhandy.de
 header.b="R+f20CTt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1596821226;
 s=strato-dkim-0002; d=alarmhandy.de;
 h=In-Reply-To:Date:Message-ID:Cc:From:References:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=A1ygXUSbZR1HuIK1An3p6OJ5rjcYbl3rSEb++hiTjvs=;
 b=R+f20CTtvtxhpghjy9LIabBw232pyl2JU32kLMyQ6nYJF4U3pW0wKXzwUPUABwTgAB
 CTHqkVSe7UvcQkg5BO7gk1ywzsPliIXwPWuDRlWZNg6qx/oKfXkqGGGmVnxJFij4sHuE
 xjaBNVt87ZDp1w3Rc4+mHU1qkjT98g0k2ZCTJCS4JuwaOmqe0Ie8i3X5NhEgZymCQMm1
 ISS69QiyW94KupLkxA3F4cMtL56wHBT3ZZ/ToTS1kZHQkz/szslLcP+qECYMyxJfR1B7
 geBtoby1fRBP0PyayeIAATrEc4L4lXEuN2CRAl9E9uuS24CcHxED1JjLVR+aFqitN2+Y
 nMjQ==
X-RZG-AUTH: ":LWABbWCpd/7F2tYDFKK/RTiu0TNXYdF7Mwi+q4wIVIrdnF+kUmjp/0vw2qvj/uWT+YVE+CFkfD3w/CUH8xio9mutdePZwArNcP9pRg=="
X-RZG-CLASS-ID: mo00
Received: from localhost by smtp.strato.de (RZmta 46.10.5 AUTH)
 with ESMTPSA id Y0a2fbw77HR6MbQ
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 7 Aug 2020 19:27:06 +0200 (CEST)
Subject: Re: [HDAudio][ALC285] Native speaker support for HP Spectre x360
 15-eb0xxx
To: alsa-devel@alsa-project.org
References: <e6a982a8-15c8-1fad-e412-fa5b9d289fd2@alarmhandy.de>
 <s5h7dua8mt1.wl-tiwai@suse.de>
From: Alexander Giese <alex@alarmhandy.de>
Message-ID: <1834da9d-0db1-df9a-3da0-3e378b8ad570@alarmhandy.de>
Date: Fri, 7 Aug 2020 19:27:05 +0200
MIME-Version: 1.0
In-Reply-To: <s5h7dua8mt1.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de
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

Hello again,

thank you for your fast reply!

I tried your solution and can confirm this:

 > To check the behavior, try the following:
 >
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x01
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x01
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x00
 >
 > this should enable the speaker, and the succeeding call
 >
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x01
 >
 > turns off the speaker.

Yes, that's exactly what happens.

 > Also,
 >
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x04
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x04
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x00
 >
 > turns on the mic-mute LED, and the succeeding call
 >
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x04
 >
 > turns off the LED.

This is right too. :)

 > If above is the confirmed, you can manage both in a shot by
 >
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x05
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x05
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x04
 >
 > will turn on the speaker but off the LED, and

This is right as well. But the succeeding call

 >
 >   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x05
 >

turns off mic-mute LED and speakers. However

hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x01

turns off speakers and turns mic-mute LED on. Following

hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x02

turns on both, speakers and mic-mute LED.

hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x04

turns off mic-mute LED and turns on speakers.

 > And, doesn't the machine have the playback mute LED?  Usually it's
 > controlled with the GPIO, too, but this case

Actually it has a playback-mute LED, but unfortunately I have not found 
the GPIO pin to activate it.
I tried by first doing SET_GPIO_DIR (with values 0x01, 0x02, 0x04). 
Foreach SET_GPIO_DIR I did SET_GPIO_MASK (with values 0x01, 0x02, 0x04) 
and foreach SET_GPIO_MASK I did SET_GPIO_DATA (with values 0x00, 0x01, 
0x02, 0x04).

I hope this test results help further understanding the pin layout.

Maybe you have some advice to find the playback-mute led?

Best regards

Alexander

Am 07.08.20 um 18:04 schrieb Takashi Iwai:
> On Fri, 07 Aug 2020 15:05:12 +0200,
> Alexander Giese wrote:
>>
>> Hello alsa-devel-team,
>>
>> I have a problem with the built-in speakers on the 2020 model of the
>> hp-spectre. From my unexperienced point of view, the audio sinks are
>> correctly identified and therefore I tried tweaking the GPIO pins with
>> success.
>>
>> Information from alsa-info is here:
>> http://alsa-project.org/db/?f=c8ee13e52fd6b2377573a7123c2887fe4d59c917
>>
>> When I use hda-verb with the following parameters 2 of 4 of my
>> built-in speakers start working:
>>
>> hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x02 (or 0x04)
>> hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x01
>> hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x01
> 
> So this means that GPIO pin#0 (0x01) is the amp, and it needs to be
> cleared.
> 
>> In addition, my mute-mic-led on the keyboard glows when:
>>
>> hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x01 (or 0x02)
>> hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x04
>> hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x04
> 
> And this means GPIO pin#2 being the mic-mute LED, inverted (0=on,
> 1=off).
> 
> To check the behavior, try the following:
> 
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x01
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x01
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x00
> 
> this should enable the speaker, and the succeeding call
> 
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x01
> 
> turns off the speaker.
> 
> Also,
> 
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x04
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x04
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x00
> 
> turns on the mic-mute LED, and the succeeding call
> 
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x04
> 
> turns off the LED.
> 
> If above is the confirmed, you can manage both in a shot by
> 
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x05
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x05
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x04
> 
> will turn on the speaker but off the LED, and
> 
>   hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x05
> 
> will turn on both speaker and LED.
> 
> And, doesn't the machine have the playback mute LED?  Usually it's
> controlled with the GPIO, too, but this case
> 
> 
>> Since I do not understand how the GPIO-settings are integrated and
>> applied in the upstream software for corresponding models, I would
>> very much appreciate any help to get this to work out of the box in
>> future releases so I do not have tweak my system all the time and
>> others can benefit as well.
>>
>> Any suggestions on getting all 4 speakers to work or the
>> mute-volume-led to glow are very much welcome alike!
> 
> The surround/bass speaker is often more difficult.  We need either the
> contact to the vendor or the reverse engineering.
> 
> 
> Takashi
> 
