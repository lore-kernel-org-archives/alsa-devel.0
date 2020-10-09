Return-Path: <SRS0=04K1=DQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D667C433E7
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:08:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C43D22267
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MErdI6l9";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="5pSW4L5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C43D22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 725F815E2;
	Fri,  9 Oct 2020 16:07:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 725F815E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602252503;
	bh=EMefrkiR6VErnBfysfycnwnXyiK4IqvSiZNmhaUx7xw=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MErdI6l9fQxzcqGA57vEnZ/FQY4d/BgUuInrSrPc+WHWTNvWnOwrlGxFiBBgsfUYk
	 7L/bAj/StNIqwGS9xQf2EY/zjNeSM5xEemOpA15PdkxfQ7u5hQ8kjLq+ogkSuIWfRY
	 jzDb+jk4+QZaecy89ZRE94qvUOPEOAaQzWne86aI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0D6DF80148;
	Fri,  9 Oct 2020 16:07:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F2DBF8015B; Fri,  9 Oct 2020 16:07:31 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B5C5F800BF
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2020 16:07:25 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9A304A0040;
 Fri,  9 Oct 2020 16:07:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9A304A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1602252444; bh=/mlODqTRA6pIsB2YAuSJv3Urebp1ojosppj7aeDvNR8=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=5pSW4L5PX+jdobcAAAh5MXYJoCbICWWPuq3QP1Os7I6IMGuMWh+vMJvqoWj4v9UjW
 feviIdp6C5CoJvB16wYEswqMUDFxH+tS46hlODcnN2iMUgQaIxrmq/eTMJx77YOKUF
 +6L8iFYpmLai66/GpnXsdEisi0Py7v2yFFTQkaI0=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri,  9 Oct 2020 16:07:22 +0200 (CEST)
Subject: Re: Discover a microphone device, to later discover if it is
 receiving input
To: info <info@dressmaker.ca>, alsa-devel@alsa-project.org
References: <de6ebf17-8f71-c497-28bc-7819338baddb@dressmaker.ca>
 <5378606a-5b71-5d1b-f7f4-a6f33dce60b3@dressmaker.ca>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <69ba716e-d576-088f-23e5-4462933e0159@perex.cz>
Date: Fri, 9 Oct 2020 16:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5378606a-5b71-5d1b-f7f4-a6f33dce60b3@dressmaker.ca>
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

Dne 09. 10. 20 v 14:39 info napsal(a):
> Can maintainers of this list please give a straight answer: is asking 
> questions and leaving comments here a waste of time?

Unfortunately, the hint list does not give information about the connected
mixer outputs or inputs. It's just a list of available PCM devices in the system.

If the I/O type is (null) it means that both directions may be available.

We have better device enumeration in UCM (Use Case Manager) by the use, but
the configurations are not available for all hardware yet.

BTW: Your e-mail header (From:) and signature does not seem trustly.

						Jaroslav

> On 2020-10-04 12:22 PM, info wrote:
>> Hi all,
>>
>>
>> I am writing a program that aims to auto-discover the microphone 
>> device that the user is speaking into. I started off by querying 
>> device hints and collected all devices with the IO types of null, 
>> since I have not found any devices with the type of Input. I am 
>> puzzled how it is possible that there is no Input, where a microphone 
>> device should not be able to emit sound. This is the list on my 
>> particular machine:
>>
>> Name of device: sysdefault:CARD=SB
>> Description of device: HDA ATI SB, ALC892 Analog
>> Default Audio Device
>> I/O type of device: (null)
>>
>> Name of device: front:CARD=SB,DEV=0
>> Description of device: HDA ATI SB, ALC892 Analog
>> Front speakers
>> I/O type of device: (null)
>>
>> Name of device: surround21:CARD=SB,DEV=0
>> Description of device: HDA ATI SB, ALC892 Analog
>> 2.1 Surround output to Front and Subwoofer speakers
>> I/O type of device: Output
>>
>> Name of device: surround41:CARD=SB,DEV=0
>> Description of device: HDA ATI SB, ALC892 Analog
>> 4.1 Surround output to Front, Rear and Subwoofer speakers
>> I/O type of device: Output
>>
>> Name of device: surround50:CARD=SB,DEV=0
>> Description of device: HDA ATI SB, ALC892 Analog
>> 5.0 Surround output to Front, Center and Rear speakers
>> I/O type of device: Output
>>
>> Name of device: surround71:CARD=SB,DEV=0
>> Description of device: HDA ATI SB, ALC892 Analog
>> 7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
>> I/O type of device: Output
>>
>> Name of device: sysdefault:CARD=SB
>> Description of device: HDA ATI SB, ALC892 Analog
>> Default Audio Device
>> I/O type of device: (null)
>>
>> Name of device: front:CARD=SB,DEV=0
>> Description of device: HDA ATI SB, ALC892 Analog
>> Front speakers
>> I/O type of device: (null)
>>
>> Now, I am more puzzled, because none of them is a microphone device 
>> explicitly. How can my program determine which of them is actually a 
>> microphone?
>>
>> Also, why are devices are duplicated in the output from 
>> snd_device_name_hint()? The very first device is also repeated as the 
>> 2nd last one...
>>
>>
>> Regards,
>> Alex
>>
>>
> 
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
