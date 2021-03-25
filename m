Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4596DC433C1
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 20:49:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA9861A28
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 20:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA9861A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B845415E0;
	Thu, 25 Mar 2021 21:48:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B845415E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616705337;
	bh=71AUndTKLHldPBFkrJAkV15MjUjxkf9E5PJ0BjtSUIA=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zkbto2Ky73iB2g0hwefmEJwyi2RkB7rr1xMXy3X/D8+a/4QwaywHnka4HbkN4ldq7
	 y9aDFyVYTeZPDNIDmBsEZWP3SeH2HdtvMLIseI9aLe9k5F+HGaptfdvVnkg+EtQ72H
	 DfQUsfU3omDHEk4LSUUF/JbEX7mI98I2Lw3wJUB0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 349B6F80257;
	Thu, 25 Mar 2021 21:48:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE7FDF8025F; Thu, 25 Mar 2021 21:48:05 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9FF52F80104
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 21:47:57 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 20FC5A003F;
 Thu, 25 Mar 2021 21:47:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 20FC5A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1616705276; bh=vTTiBGeVgdhJBnBnAFNXTB578XpoiAaxRfq6fqp2l1o=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=VddqUusJnicVR0A2Fk0wldq+lJnOcgwTTRLqDaSvyVvx2vFXpEBzzivhUmbcgLCg2
 Cy9N2UwnZCGE8OoCZfv0cIOPyTr3uKwLCjDGGGDyS8Qg6YK4BQrsxt+u2ZB9Lmq/s/
 TzapG9RIzIuLtf0tgOvkjQ78NyoIsdSsQ+ubclhQ=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 25 Mar 2021 21:47:53 +0100 (CET)
Subject: Re: [PATCH 1/1] sound: rawmidi: Add framing mode
To: David Henningsson <coding@diwic.se>, alsa-devel@alsa-project.org,
 tiwai@suse.de
References: <20210324053154.34107-1-coding@diwic.se>
 <20210324053154.34107-2-coding@diwic.se>
 <a0812386-d916-4cdb-a230-4c56e0b8952e@perex.cz>
 <c456e5a2-66aa-4390-6968-1e030e8962e7@diwic.se>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <ca984b7a-bb0b-c1fb-e2ce-537e7e1775b5@perex.cz>
Date: Thu, 25 Mar 2021 21:47:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <c456e5a2-66aa-4390-6968-1e030e8962e7@diwic.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 24. 03. 21 v 17:17 David Henningsson napsal(a):
> 
> On 2021-03-24 17:06, Jaroslav Kysela wrote:
>> Dne 24. 03. 21 v 6:31 David Henningsson napsal(a):
>>> This commit adds a new framing mode that frames all MIDI data into
>>> 16-byte frames with a timestamp from the monotonic_raw clock.
>> I would add support for monotonic timestamps, too. The NTP drifts are usually
>> small, so it may make sense to support those timestamps, too. It may be handy
>> for the synchronization among multiple machines (timing sources).
>>
>> The timestamp mode should be selected separately than the framing mode.
> Okay, noted for v3.
>>
>>> +#define SND_RAWMIDI_FRAMING_DATA_LENGTH 7
>>> +
>>> +struct snd_rawmidi_framing_tstamp {
>>> +	unsigned int tv_sec;	/* seconds */
>>> +	unsigned int tv_nsec;	/* nanoseconds */
>>> +	unsigned char length;
>>> +	unsigned char data[SND_RAWMIDI_FRAMING_DATA_LENGTH];
>>> +};
>> Perhaps, we should consider to have a fixed header and variable data length
>> here. For MIDI, the standard messages have only few bytes usually. It would be
>> better to use this space for the seconds field:
>>
>> header {
>> 	unsigned long long tv_sec;
>> 	unsigned int tv_nsec;
>> 	unsigned int len;
>> 	unsigned char data[0];
>> };
> 
> I considered that, but it has problems with alignment. If you have a 
> normal midi message of 3 bytes, now your second tv_sec will end up 
> starting on an odd byte, unless you add padding, and then that padding 
> needs to be specified and so on. In addition, half of the header could 
> end up in the end of the ring buffer and the other half in the 
> beginning. So I found the 16 byte fixed version to be simpler and easier 
> to implement correctly.

I see. I agree that the fixed frame is easier to handle.

> However if you like we could change the tv_sec to 64 bit and end up with:
> 
> #define SND_RAWMIDI_FRAMING_DATA_LENGTH 3
> 
> struct snd_rawmidi_framing_tstamp {
> 	unsigned long long tv_sec;	/* seconds */
> 	unsigned int tv_nsec;	/* nanoseconds */
> 	unsigned char length;
> 	unsigned char data[SND_RAWMIDI_FRAMING_DATA_LENGTH];
> };
> 
> We'll then have only three bytes for the actual data, but since that is what most midi messages are anyway, it would be okay, I assume.

We can use the free bits in tv_nsec. It may be possible to carry 4 midi bytes
with the 64-bit tv_sec field, too.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
