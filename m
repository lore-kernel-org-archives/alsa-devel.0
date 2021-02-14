Return-Path: <SRS0=fPON=HQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B832C433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Feb 2021 18:56:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADA964E12
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Feb 2021 18:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADA964E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CFBC1680;
	Sun, 14 Feb 2021 19:55:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CFBC1680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613328985;
	bh=3m63rQe0SS3Mir9T8iT928yZzOD+uADvnGnER8GsJGo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rUck2eYWcjBBYHGEEI23jSdhvG7SuBWNnuIDZC3Pk0k6GMhDLrmLAAlUXLYht4NYD
	 xVWGa712iVydYMSLa43y73kEEeQ2xS/b3RL0FZRAq8BDT0btVMxvub7GuSqRh/V1vi
	 WoemQtad6icNDOhhedsoLYE6jZCkBg+wImpDUnu0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D897FF800B2;
	Sun, 14 Feb 2021 19:55:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DFB2F80155; Sun, 14 Feb 2021 19:55:33 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AB66F800F0
 for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2021 19:55:27 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id F0156A003F;
 Sun, 14 Feb 2021 19:55:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz F0156A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1613328926; bh=+DsCoJ+Hl4WPEzEte5CdLw4SzttzuAKkEwURBP4EpOk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=htBFAGs+wgxI99mpu3FtdqzC5Agi7CwW58TElVebX4udqQex2qHx7i/33CbIH+E7/
 X5Evq/iZ2uB1Lrf4Eu0NIw2jFstgeffbtoxOFOMHa8y5Q5BXLTkW8tKEIHb0AlZlOr
 1fJWyS+7qM4qvMK/FbKLCVIduTEMpPmor2aGRz88=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sun, 14 Feb 2021 19:55:21 +0100 (CET)
Subject: Re: [PATCH 0/5] ALSA: control - add generic LED trigger code
To: Takashi Iwai <tiwai@suse.de>
References: <20210211111400.1131020-1-perex@perex.cz>
 <s5h1rdmfrvo.wl-tiwai@suse.de>
 <3c84c275-0c62-d2f4-38ad-be6accb3b159@perex.cz>
 <s5hblcpej13.wl-tiwai@suse.de>
 <b1bc4135-25b9-26aa-323d-23bea15e164c@perex.cz>
 <s5hwnvdcvwf.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <15cd340d-6359-b0fd-d4b1-8aa8c3563bf8@perex.cz>
Date: Sun, 14 Feb 2021 19:55:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <s5hwnvdcvwf.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Hans de Goede <hdegoede@redhat.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Perry Yuan <Perry.Yuan@dell.com>
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

Dne 12. 02. 21 v 13:28 Takashi Iwai napsal(a):
> On Fri, 12 Feb 2021 11:32:38 +0100,
> Jaroslav Kysela wrote:
>>
>> Dne 12. 02. 21 v 10:23 Takashi Iwai napsal(a):
>>> On Thu, 11 Feb 2021 18:53:20 +0100,
>>> Jaroslav Kysela wrote:
>>>>
>>>> Dne 11. 02. 21 v 18:15 Takashi Iwai napsal(a):
>>>>
>>>>>> Jaroslav Kysela (5):
>>>>>>   ALSA: control - introduce snd_ctl_notify_one() helper
>>>>>>   ALSA: control - add layer registration routines
>>>>>>   ALSA: control - add generic LED trigger module as the new control
>>>>>>     layer
>>>>>>   ALSA: HDA - remove the custom implementation for the audio LED trigger
>>>>>>   ALSA: control - add sysfs support to the LED trigger module
>>>>
>>>>> One thing I still miss from the picture is how to deal with the case
>>>>> like AMD ACP.  It has no mixer control to bundle with the LED trigger.
>>>>> Your idea is to make a (dummy) user element and tie the LED trigger
>>>>> with it?
>>>>
>>>> Yes, the user-space code which guarantee the silence stream should create an
>>>> user space control with the appropriate LED group access bits. The alsa-lib's
>>>> softvol PCM plugin can do this silencing for example.
>>>
>>> What control would it create?  In the case of softvol, it's a volume
>>> control that really changes the volume.  For the mute LED, it's a
>>> control turn on/off the mute?  If so, I wonder what makes better than
>>> creating it from the kernel driver.  (Of course, we can list up like
>>> "flexibility", etc, but it has a flip side of "complexity" and
>>> "fragility"...)
>>
>> The current code handles both switch / volume for the marked control (assuming
>> that the minimal value - usually zero - is full mute). And actually, there are
>> snd_pcm_areas_silence() calls in the softvol plugin, so we know that the PCM
>> stream is not passed to the application at this point.
>>
>> Condition:
>>
>>       if (info.type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
>>           info.type == SNDRV_CTL_ELEM_TYPE_INTEGER)
>>           ... value.value.integer.value[i] != info.value.integer.min
>>
>> The softvol plugin may be extended to add the mute switch control, of course.
> 
> Well, my question was what kind of mixer control will be added at all,
> although the chip does neither volume nor mute function.  Would we add
> a fake volume/switch like softvol, or would we add rather a control
> that is directly tied with the LED state?

I don't understand your question. If the user space marks the own vol/sw
control with the LED group, then it's tied with the LED state. I believe that
the control should be created in the code which make sure that the PCM stream
is silenced (like alsa-lib's softvol plugin).

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
