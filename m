Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D05DC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 10:32:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70807619BA
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 10:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70807619BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51926166A;
	Tue, 23 Mar 2021 11:31:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51926166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616495564;
	bh=UjGon8rBTdUQPulqYTpOxEGYRi7GrtOOC6OHhtWBGpE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h6v6B8C/GuySkWyu9CAI8b5WL3hw8SWAe/Xxjf8IuIW25VP1zS1BKPSVM5kcH8ZBv
	 4ivGYYWTHEx7QS4wfXzLTZBAw/k/KJr+WjzFoHDjWh5uzJIeclwvWAH5nUIcnQl3tr
	 +iXGD35GyIRiO5UBIZquQKdIRBxbQC6A/xULsh3c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAA13F80257;
	Tue, 23 Mar 2021 11:31:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B193EF8025F; Tue, 23 Mar 2021 11:31:51 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C816F80104
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 11:31:39 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 32665A003F;
 Tue, 23 Mar 2021 11:31:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 32665A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1616495498; bh=/gB3DldESz8ac/xjUxID2LwrUy5G3dMr8z6g1yoCW+M=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GtpO1TJhWQQ+UjsUBwff0n017DOx2uCAgRNo3ISz0aqUBVeTxgPyhuuJQdwrayyY0
 Q69q9M7ruSk0uadnov7tXQgq1AQvugcu/9osygMQWZtY0LHUzTkgFAQAqqyKHlA0yy
 ZaKxZSeRuvfPm5pdFn+AZ6yDXWwpSFzizN++3QnY=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 23 Mar 2021 11:31:30 +0100 (CET)
Subject: Re: [PATCH v4 6/6] ALSA: led control - add sysfs kcontrol LED marking
 layer
To: Takashi Iwai <tiwai@suse.de>
References: <20210317172945.842280-1-perex@perex.cz>
 <20210317172945.842280-7-perex@perex.cz>
 <a3ddb881-6580-cd25-ef3c-734e686e6942@redhat.com>
 <s5h5z1nf47r.wl-tiwai@suse.de>
 <3820909c-29ce-9f3f-d1e6-c4611e06abe4@redhat.com>
 <s5h35wqff1m.wl-tiwai@suse.de>
 <a2018c94-8731-de29-e447-92457176a1b4@redhat.com>
 <s5hy2eidul2.wl-tiwai@suse.de>
 <a9a62884-da5b-ef2a-10ec-e414e6784677@perex.cz>
 <s5hblbaciqh.wl-tiwai@suse.de> <s5ha6quci82.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <65943f72-6489-24fa-f6af-a2bae8824d90@perex.cz>
Date: Tue, 23 Mar 2021 11:31:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <s5ha6quci82.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Curtis Malainey <cujomalainey@google.com>,
 Hans de Goede <hdegoede@redhat.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@google.com>
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

Dne 23. 03. 21 v 10:49 Takashi Iwai napsal(a):
> On Tue, 23 Mar 2021 10:38:46 +0100,
> Takashi Iwai wrote:
>>
>> On Mon, 22 Mar 2021 15:16:30 +0100,
>> Jaroslav Kysela wrote:
>>>
>>> Dne 20. 03. 21 v 10:48 Takashi Iwai napsal(a):
>>>
>>>>> With other OS you mean e.g. Android?  Android has device-specific
>>>>> init-scripts which can either call alsactl or directly do the
>>>>> echo-s.
>>>>
>>>> Also ChromeOS.  I'd like to get a general consensus before moving
>>>> forward.
>>>
>>> Where are ChromeOS people? They could join to the discussion which is floating
>>> few months now. Perhaps, the gmail's spam filter does not allow them to
>>> communicate with us ;-)
>>
>> Also adding Dylan and Mark to Cc.
>>
>> FYI, the patch set is:
>>   https://lore.kernel.org/alsa-devel/20210317172945.842280-1-perex@perex.cz/
> 
> ... and now back to the topic.
> 
> So the primary question is whether we want the sysfs entries to allow
> user-space defining the mute-LED vs control binding externally.  With
> this, the mute LED is supposed to be set up via udev rules that
> triggers some alsactl stuff, and the rest is handled in an extension
> in UCM profile.  If this approach is acceptable on all platforms, we
> can go for it.  That was the question to other platforms like Android
> and ChromeOS.
> 
> 
> And, now looking into the details, I have a few more questions:
> 
> - The binding with SNDRV_CTL_ELEM_* bit flag is handy for some drivers
>   but not for everything; e.g. if we want to add the binding in ASoC
>   machine driver, an API like
>     snd_ctl_bind_mute_led(card, elem_id, inverted);
>   would be easier.  It'd be essentially an internal call of the sysfs
>   binding.

I would probably create more universal helper for the access field. It may be
handy to update other flags like INACTIVE or so. Something like:

  snd_ctl_update_access(card, elem_id, access_mask, access_bits);

If we decide to move this information out of access field, we can replace
those calls with another function.

For ASoC codecs, it may be difficult to do such calls in the init phase,
because the card is not bound to the component. But yes, I agree that this
setting should be handled in the upper layer (machine) than the component layer.

>  (I haven't checked, but might this be also more
>   straightforward conversion for HD-audio case, too?)

I don't think that it brings a simplification. The id composition is more
complex than 'if (codec->led_flag) access |= LED_GROUP'.

> - The binding in the kernel could (should?) be shown in the sysfs
>   output.  Currently it seems handled differently?

It isn't. The LED group is stored in the access field and my implementation
tracks those bits per elements. So, the sysfs LED code updates those bits,
too. The settings is preserved even if you reload the ctl-led module.

> - Specifying the numid may the code simpler in kernel side?
>   alsactl has already the string parser.

Yes, but it's not so handy for scripting / UCM. I can add find-ctl-numid
lookup to UCM, of course, but what about standard shell scripting?

> - Do we have to deal with binding with multiple controls to a single
>   mute LED?  Might a single exclusive binding make things easier?
>   Then we don't have to create sysfs entries per card, and it'll be
>   something like
>      echo 1:10 > /sys/devices/virtual/sound/ctl-led/mic/bind
>   which is equivalent with the API call above.
>   If multiple bindings are attempted, it can simply give an error.
>   In the driver side, it catches the unexpected binding, too.

AMD ACP digital + HDA analog headset microphone. If we follow the standard HDA
behaviour, both inputs should trigger the mic LED. Two cards are in the game.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
