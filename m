Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6929DC433EA
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:17:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F1D2070B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DUTFYTPJ";
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NbJTAbEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F1D2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AC1D169A;
	Mon, 27 Jul 2020 17:16:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AC1D169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595863019;
	bh=2PwgoyDP+WS5czBK2ycPrAM6J10v4quTUBrbxtWACHM=;
	h=References:From:To:Subject:In-reply-to:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DUTFYTPJ2SaYWAkVmuEA6hBsGY9ldXev/QIpJAFN36mENnlI91QTxrzvvU17VoEHw
	 cHwr4KpyK5rkn+jH8f8EPBwWKTZ16loZX+lW1uknkrkHqoyamq3gcEicd6UarhXNo3
	 7xDdJVOOj7V24t+nC+wjiJc9d0qfdNFJSjRigs8Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EED64F8013C;
	Mon, 27 Jul 2020 17:16:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 163CAF80171; Mon, 27 Jul 2020 17:16:08 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6CA76F8013C
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 17:15:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CA76F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="NbJTAbEq"
Received: by mail-wr1-x444.google.com with SMTP id f7so15299581wrw.1
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 08:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=agp2050WRs5/ihRoFqDj6urG6+e8GvKNH86TC83dqFg=;
 b=NbJTAbEqBWaTT/xKpNkrm7MB2kVwj2mhbzZke+Ml93TOibLmSiQVMrp1dKIdXaZhK0
 V74QVjC1OrOpeXzkKRdePjk4hJHspWwhKjQIJ/GCt0MIPdHD04+F4IHX4PD+EpmKVDbD
 sjAGSXjRBNF4BGaxhJTBigtuWfyqK0Rr46GrDaEmMj3zpoKOXX2CFuQUE5F0DDA5lg+L
 X/UrTHSZdsn5EnbJvV8Wv34Y54DfdCl2gZBeuz2wOlnTCw9NvKpg+L6pSrWw7AsbhYef
 d19UF7AziiV/hzoQtF3CunbTGZDbGuaYaRL4g0/hlJVI4YngHYlzsj5lqpyUDXjdvDWT
 P6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=agp2050WRs5/ihRoFqDj6urG6+e8GvKNH86TC83dqFg=;
 b=ScebXS/QUlyyu7kqJBXwapnCmBPLXPdPUbKgstq7PI4qCody2pmOnvsWUz2nypAguB
 ubyxgMZOXHkXEK08nKAxNDySOrccmjPt5xEOzVYr19EWJMKwZJW4R++0DonIxAXDqwY6
 OESTCeNBrahFWvflyr+WTxXTiozHbrfUDw0AiYQsnO8meaSv2aEM1rIh1Y8ywqEoRGdZ
 9N+YltZ+SVBACg+hfALiwSrTfvSCaqmIDpa1pBwsv6X2Db1riGVY6XTxGHx0nhUVJweb
 J1xrtOBYHdUqm9izBg8RhrVB7WjaoBYhuHOXfVKq4WJOxHeACTTIn5RElQJ+bAZZYr0R
 D/Qg==
X-Gm-Message-State: AOAM532g4CF6+HVpkv9wb3mzlcYONYJ+psAznCn1aehk/hB8V9S/KE0e
 Mxuoimt6p0kVMBR98Gc6iwOENQ==
X-Google-Smtp-Source: ABdhPJym3OI2WRkayQD1LQe5DRZpMqOO/MNYBC1ttPVtWxRJaI5L6RkR/94e7R5+ILOGMTMP9V6X+Q==
X-Received: by 2002:adf:de91:: with SMTP id w17mr20656107wrl.108.1595862955639; 
 Mon, 27 Jul 2020 08:15:55 -0700 (PDT)
Received: from localhost (sparrow.liltaz.com. [163.172.42.206])
 by smtp.gmail.com with ESMTPSA id q4sm19016175wme.31.2020.07.27.08.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 08:15:54 -0700 (PDT)
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
 <1jlfj98gb4.fsf@starbuckisacylon.baylibre.com>
 <576823fb-a8a8-1f74-b7e2-d33b734022a7@linux.intel.com>
 <1jk0yp8fb7.fsf@starbuckisacylon.baylibre.com>
 <ca2f73d4-d512-37a8-98db-cec2156690d5@linux.intel.com>
User-agent: mu4e 1.3.3; emacs 26.3
From: Jerome Brunet <jbrunet@baylibre.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: core: use less strict tests for dailink capabilities
In-reply-to: <ca2f73d4-d512-37a8-98db-cec2156690d5@linux.intel.com>
Date: Mon, 27 Jul 2020 17:15:54 +0200
Message-ID: <1jh7tt7zv9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: tiwai@suse.de, broonie@kernel.org
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


On Mon 27 Jul 2020 at 16:13, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> On 7/27/20 4:42 AM, Jerome Brunet wrote:
>>
>> On Fri 24 Jul 2020 at 21:05, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>>> Again, this is changing the original meaning of the flag from "playback
>>>> allowed" to "playback required".
>>>>
>>>> This patch (or the orignal) does not explain why this change of meaning
>>>> is necessary ? The point I was making here [0] still stands.
>>>>
>>>> If your evil plan is to get rid of 2 of the 4 flags, why go through the
>>>> trouble of the changing the meaning and effect of one them ?
>>>
>>> My intent was to have a non-ambiguous definition.
>>
>> I still fail to understand how it was ambiguous and how throwing an
>> error for something that used to work well so far is making things better.
>>
>> Maybe there could be have been a better name for it, but what it did was
>> clear.
>>
>> The flag is even (briefly) documented:
>> 	/* DPCM capture and Playback support */
>> 	unsigned int dpcm_capture:1;
>> 	unsigned int dpcm_playback:1;
>>
>> "Support" means the dai_link supports it, not that it is required for it
>> work. This is what was implemented.
>>
>>>
>>> I don't know 'playback allowed' means. What is the point of using this flag
>>> if it may or may not accurately describe what is actually implemented? And
>>> how can we converge the use of flags since in the contrary 'playback_only'
>>> is actually a clear indication of what the link does. We've got to align on
>>> the semantics, and I really don't see the point of watering-down
>>> definitions. When things are optional or poorly defined, the confusion
>>> continues.
>>
>> The problem is that commit b73287f0b074 ("ASoC: soc-pcm: dpcm: fix
>> playback/capture checks") has changed the semantic:
>> * without actually warning that it was doing so in the commit description
>> * breaking things for other who relied on the previous semantics
>>
>> Previous semantics of the flag allowed to disable a stream direction on
>> a link which could have otherwise had it working, if the stream had it.
>> It added information/control on the link at least.
>>
>> New flag semantics forces the flag and stream capabilities to be somehow
>> aligned. This is not clearing the confusion, this is redundant
>> information. How is this helping the framework or the users ?
>>
>>>
>>> WFIW, my 'evil' plan was to rename 'dpcm_playback' as 'can_playback' (same
>>> for capture) and replace 'playback_only' by 'can_playback = 1; can_capture
>>> = 0'. So this first step was really to align them on the expected behavior
>>> and minimal requirements.
>>
>> IMO the previous flag semantics was inverted yes, but aligned:
>>
>> playback_only = 1 was the same as dpcm_capture = 0
>> capture_only = 1 was the same as dpcm_playback = 0
>>
>> Having both *_only set does not make sense for a stream, same as having
>> none of dpcm_*
>>
>> Having none of *_only flag means there is no restriction on the stream,
>> same as having both dpcm_* set.
>>
>> This seems aligned to me.
>
> Makes no sense to me to have information that's useless.

Maybe. That's not point
The point is
* No explanation has been provided so far about why throwing an error
  like done here (or in the previous change) makes it more usefull.
  The semantic change just make it redundant with the information
  coming from the DAI caps. The new semantic makes the flag even more
  useless.
  
* Throwing an error like break cards that used to work nicely for no
  gain
  
* This adds yet another level of complexity that was not necessary
  before (snd_soc_dai_link_set_capabilities())

> What does 'no restrictions' on a stream mean?

I thought the code was fairly simple but I can explain
- A dai_link has 2 stream directions. The direction can be enabled
  if the DAIs on the link supports it.
- A direction could be forcefully disabled at the dai_link level using
  those flags (restrict the direction). I suppose to give more control
  to the card driver.

I did not write that code, I have no idea if those flags are any use to
anyone. 

> 'anything goes' is not a scalable design principle.

What does scalability has to do with the matter ?

In the end, I'm just asking to drop the error condition you added.

You want to rework/remove some flags, I think it is a great idea.
I even willing to help out, but not in a way that makes things complex
and redundant.

