Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D2BC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 11:43:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDE964E30
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 11:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDE964E30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1AD582E;
	Mon,  8 Feb 2021 12:42:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1AD582E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612784590;
	bh=ZACoo1qyRh5zcDjcCuczEomXmzbTINtkzCcV+y7J7IA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SKSUHwAl11sFZffpXh32pgBVmtvMBP/AdbB2uP99R37sSUhtiu2/3CZXC3Sdob1L4
	 WntYkbMyShATFpixa50jap99kdBpUl/EWnj7o1QOL8D0s8cCq3fmizzkPcTsGXUWgD
	 LfvW8D8Pr3xNa+sIWK2rUrabJhSo7NFWLlBizKbk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30AFEF80165;
	Mon,  8 Feb 2021 12:42:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 860B6F80169; Mon,  8 Feb 2021 12:42:16 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18C91F8013A
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 12:42:07 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 40272A003F;
 Mon,  8 Feb 2021 12:42:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 40272A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1612784522; bh=zeOgcVQri7TLAVoYAnTe4GIqO8jqium00kQMdrrQ44I=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=0cGtLq4uOWaRtQ+WyZOv6ccXNvTCJ20yysXIpHfXBQrXGUV25BeY90BnmJ4oXptMO
 QMGAb+UGSKwGQK3qBU1IpHuRl7q9N3zW+K+UjDmFvpfSBjkG+2lIlBkqQcByykYKTD
 z5tLGzabYhIl6/2uGfA7i74kKUW1Pef3Wor+ij78=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  8 Feb 2021 12:41:58 +0100 (CET)
Subject: Re: [PATCH] [RFC] ALSA: control - add generic LED API to sound core
 routines
To: Hans de Goede <hdegoede@redhat.com>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20210207201157.869972-1-perex@perex.cz>
 <3195f3b6-6294-d872-ce1c-6f1a9deb5a6f@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <cf6fc0bf-4eb6-c9f8-883f-4a48343cf6d9@perex.cz>
Date: Mon, 8 Feb 2021 12:41:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3195f3b6-6294-d872-ce1c-6f1a9deb5a6f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, Perry Yuan <Perry.Yuan@dell.com>
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

Dne 07. 02. 21 v 21:52 Hans de Goede napsal(a):
> Hi Jaroslav,
> 
> On 2/7/21 9:11 PM, Jaroslav Kysela wrote:
>> [DO NOT MERGE!]
>> [This is just an early proposal for comments]
>> [The code is not tested / debugged]
>>
>> The recent laptops have usually two LEDs assigned to reflect
>> the speaker and microphone mute state. This implementation
>> adds a tiny layer on top of the control API which calculates
>> the state for those LEDs using the driver callbacks.
>>
>> Two new access flags are introduced to describe the controls
>> which affects the audio path settings (an easy path for drivers).
>>
>> The LED resource can be shared with multiple sound cards with
>> this code. The user space controls may be added to the state
>> chain, too.
>>
>> This code should replace the LED code in the HDA driver and
>> add a possibility to easy extend the other drivers (ASoC
>> codecs etc.).
>>
>> Note: The snd_ctl_notify_one() changes should be moved to
>> a separate patch. I will do this, when this proposal is
>> agreed.
>>
>> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>> Cc: Perry Yuan <Perry.Yuan@dell.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
> 
> Nice I think that having this handled in a generic manner
> would be a great improvement.
> 
> I have 2 HP x2 models which are Bay Trail resp. Cherry Trail
> based, which means they use Intel's LPE (Low Power Engine)
> for audio which uses ASoC.
> 
> These come with detachable USB keyboard-docks which have
> a speaker mute LED. I have already added LED-class support to
> the HID driver for these, but I never got around to hooking
> up a trigger from the ASoC code.
> 
> So if I understand things correctly, then if I add this
> patch to a kernel and in the ASoC codec driver add
> SNDRV_CTL_ELEM_ACCESS_SPK_LED to one or more of the controls,
> and add .default_trigger = "audio-mute" to the led_class_dev
> for the LED, then if I toggle the control on / off in
> alsamixer this should then control the LED ?

Yes, the ALSA control code should do just the LED trigger.
The LED class driver is a separate thing.

> If I got that right I will certainly give this a try.
> 
> Any advice for which control would be the best to use?
> Looking at the code, it assumes that if a control is enabled
> that then there will be a route, which makes sense if there
> are e.g. headphones and speaker and lineout controls. But what
> about chained controls, e.g. separate volume + mute controls
> or multiple volume controls chained. With ASoC this is not
> unheard of. I guess the answer is to pick the control which
> we will also want to use for hw volume-control if/when UCM
> profiles grow hw volume-control support ?

The proposed implementation just goes through all marked controls
and if any of the marked controls is set to value greater than
the minimal value, then the path is evaluated as "on" (thus the mute LED
should be set to off).

The controls tied to the PCM stream (DAC / DMA) should be marked. The physical
inputs behind a multiplexer without a "global" volume / switch controls will
require a bit different handling. I would just start with something simple and
we can add the more complex things on demand.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> p.s. This would only / at least add proper support for these LEDs
> at the kernel level. ATM these devices which use UCM profiles don't
> actually use any kind of hw volume-control. So we would also need to
> fix that (in userspace) to get these LEDs to really work when an
> user hits the mute key, or lowers the volume to NIL.

There's already the hw volume support in UCM and in PA (I added this to PA
14.0). Some drivers like SOF HDA / SoundWire already set the PlaybackMixerElem
/ CaptureMixerElem values. It's true that the hw volume controls are missing
for the Intel SST hardware.

The similar situation is for the SoundWire codecs (missing LED controls,
missing hw volume configuration in UCM).

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
