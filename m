Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474B5C433C1
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 12:24:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFC3619B1
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 12:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFC3619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1244B1663;
	Tue, 23 Mar 2021 13:23:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1244B1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616502247;
	bh=p/tXYwHVjU2djPn2O4sCcsSvCKS/FvqUpiKq+wdUCKk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S93o1amcvlU7i56HpaR599WV3NHmSh50oe2JGXS8K6emRBgnUFFYSj89fgYmFjZ7V
	 JMxdSd8vGED4HODGb9Srn2V6yFqiVOzwi5ztWlcTLjC5qqKR6SMhSFuROp2gRWJ1jG
	 NhK+ql+ApGt+I5QeRTHtCO5L/W8Y38rYALXp8uRo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E538F80257;
	Tue, 23 Mar 2021 13:23:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87973F8025F; Tue, 23 Mar 2021 13:23:15 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC904F80104
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 13:22:59 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 2A899A003F;
 Tue, 23 Mar 2021 13:22:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 2A899A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1616502179; bh=xTRmwKDJSrqIhpE9YqgeBx4KARrcwVjF+0P8DBG49wQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=kiFTjoB2RE6ea/daqMajalvk8rHVBFY3KXiGKwVx5XEvHqmLLGOrFZoF3XRvGkGJa
 rzK0cfhZrYykf1uAkesowYr6rWm/ynudNpNu0fdTNTpe1HwRkbA1tOp5/C67taRueY
 OzzsWWN0tkOW7PnH93Gv8yY2/R2kkH5bYCAw0U/0=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 23 Mar 2021 13:22:52 +0100 (CET)
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
 <65943f72-6489-24fa-f6af-a2bae8824d90@perex.cz>
 <s5h35wmcfe4.wl-tiwai@suse.de>
 <eaabef5a-b8b5-0211-5394-8534dfd7432c@perex.cz>
 <s5hy2eeaysg.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <e9ff74df-4ca1-390b-b906-81019c0cf66d@perex.cz>
Date: Tue, 23 Mar 2021 13:22:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <s5hy2eeaysg.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Curtis Malainey <cujomalainey@google.com>, Perry Yuan <Perry.Yuan@dell.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Dylan Reid <dgreid@google.com>
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

Dne 23. 03. 21 v 12:34 Takashi Iwai napsal(a):

>>> The simpler implementation in the kernel side is always nicer, but of
>>> course only if it works sufficiently.  So it depends on how much we
>>> want to support this feature.  The parse of control name can be done
>>> by scripting, but it's cumbersome for now, indeed, so if the shell
>>> scripting is seen as the major usage, it'd be more convenient if the
>>> kernel parses the string, yeah.
>>>
>>>>> - Do we have to deal with binding with multiple controls to a single
>>>>>   mute LED?  Might a single exclusive binding make things easier?
>>>>>   Then we don't have to create sysfs entries per card, and it'll be
>>>>>   something like
>>>>>      echo 1:10 > /sys/devices/virtual/sound/ctl-led/mic/bind
>>>>>   which is equivalent with the API call above.
>>>>>   If multiple bindings are attempted, it can simply give an error.
>>>>>   In the driver side, it catches the unexpected binding, too.
>>>>
>>>> AMD ACP digital + HDA analog headset microphone. If we follow the standard HDA
>>>> behaviour, both inputs should trigger the mic LED. Two cards are in the game.
>>>
>>> And that brings yet another question.  If the Dell privacy thing comes
>>> to play here, for example, the mute LED is tied with the hardware
>>> control of the built-in mic.  Then do we influence on this depending
>>> on the headset mic mute state, too?
>>
>> What users expect? I think that both scenarios are valid, thus we should allow
>> them.
> 
> IMO, this is a hard part.  It's possible that user (or the system)
> wants two different scenarios:
> - LED indicates the built-in mic mute
> - LED indicates the mute state of the currently used input
> 
> The current code assumes the latter case, and that might conflict with
> the concept of Dell privacy stuff (as the built-in mic is still
> allowed while using the headset).
> 
> How would be a good way to switch to a different scenario?

[Adding Perry /Dell/ to the discussion]

It's an user space setup. We can manage some conditional settings in UCM and
the shell scripts can be written with conditional parts. Perhaps, a global
configuration file(s) in /etc/alsa may specify the requested scenario.

I would just start with a default behavior (which may be hw specific) and
refine this later.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
