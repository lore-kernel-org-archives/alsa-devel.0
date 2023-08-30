Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7817C83F01
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Aug 2023 08:19:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A097E74C;
	Wed, 30 Aug 2023 10:18:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A097E74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693383566;
	bh=OpyThzqQMUDdgPlYIftPOGh9hMJBUOEGRW0UkItoZC0=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QY5IQnsMf0LV5L2OLpoTpD+PAgeL6BlpdavLHZayFwMOuB8ECN4DZ0Enx56XDnxZm
	 8/PSN5ogmxh0+PJpwWqiwpHkbYZGNUH0TwNovZq/dqDMQ7kZCQvLE6PrgdLkpN/J1f
	 3fjR76ObhovAyEv7ynKq/AA0Erw+4aAm42WYh/NY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C8E33F8025F; Wed, 30 Aug 2023 10:18:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D4ABF80094;
	Wed, 30 Aug 2023 10:18:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68157F80155; Wed, 30 Aug 2023 10:17:25 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D2B2AF800D1
	for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2023 10:17:16 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6D8A111D4;
	Wed, 30 Aug 2023 10:17:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6D8A111D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1693383435; bh=ZrJpZXEs5ce1EbbIUO6H1hWIThaKd+D/ua2GkGmk9oY=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
	b=HyAm6d9da8OueaNj0IrgRra6bvMNQnHwl4FPhm89t+5YXbW9QUFHhTSA7wrrqGPbR
	 TQJv26/HWzoud8t8vjPJi80DaTBUcErCDJLL9jWOffv8rvBiJnmEOFLhr+6FyVqIZQ
	 9Z2qyX+hn1WBTijscSHH3k04MQK5aQ6A2ThVnbfo=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Wed, 30 Aug 2023 10:17:09 +0200 (CEST)
Message-ID: <108247ea-5c28-9fc0-ebaf-b8fd706ac23e@perex.cz>
Date: Wed, 30 Aug 2023 10:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Curtis Malainey <cujomalainey@google.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 cujomalainey@chromium.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 ethan.geller@gmail.com
References: <20230824213312.1258499-1-cujomalainey@chromium.org>
 <ce20d02b-56ed-acd1-411b-8c68d8cabea8@perex.cz>
 <CAOReqxiDZOAEYYb5c73AHu+Nd2vZinLR5qdMAVJnEcV8TS6=Nw@mail.gmail.com>
 <6d498d35-841d-4ea4-2fd9-990f9b02563e@linux.intel.com>
 <6fc8a33a-52f2-0cd1-6259-b2b974548602@perex.cz>
 <CAOReqxh2-m5QmHJz-iN0eeuGFfuo0WqAHDcKKXs4ZB4AwK-qrg@mail.gmail.com>
 <CAOReqxh8fMQVbG6qmfG=vTQUJ0=SH95CvO9hTyQJfLVZKu16fA@mail.gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/2] ucm: docs: Add EchoReferenceDev
In-Reply-To: 
 <CAOReqxh8fMQVbG6qmfG=vTQUJ0=SH95CvO9hTyQJfLVZKu16fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WID6TY2OQ6H3E6RGFHZLHHYXMWLTAGD3
X-Message-ID-Hash: WID6TY2OQ6H3E6RGFHZLHHYXMWLTAGD3
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WID6TY2OQ6H3E6RGFHZLHHYXMWLTAGD3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 30. 08. 23 0:57, Curtis Malainey wrote:
> On Tue, Aug 29, 2023 at 12:17 PM Curtis Malainey
> <cujomalainey@google.com> wrote:
>>
>> On Tue, Aug 29, 2023 at 8:37 AM Jaroslav Kysela <perex@perex.cz> wrote:
>>>
>>> Modifiers are an extra layer on top of devices. I don't think that we have any
>>> default relation between the modifier PCM device and the original PCM device
>>> (from the UCM device definition). A new value to describe this (like
>>> "ReplacePlaybackPCM 1") may be introduced. Another issue is when multiple
>>> modifiers with this description are active - they conflict, so it should be
>>> described somewhere, too. Perhaps, "ConflictingModifier" array may be added to
>>> API. But those extensions are not required for the "Echo Reference" modifier.
> 
> What is the expectation for naming and relationship to the devices? Is
> the Modifier a suffix to the device name to associate it?

Verbs, devices and modifiers should be named according use-case.h:

https://www.alsa-project.org/alsa-doc/alsa-lib/group__ucm.html

The relation is defined using SupportedDevices or ConflictingDevices array. 
Those arrays are available in modifiers, too.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

