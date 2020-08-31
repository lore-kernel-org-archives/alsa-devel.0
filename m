Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A712C433E6
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 17:58:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F5D206CD
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 17:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kAXBLDy7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="ERl0nyR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F5D206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C05D1681;
	Mon, 31 Aug 2020 19:57:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C05D1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598896718;
	bh=0/ewt4/nBAEOOWEgXxbKIZ1mNi0QLw6rlZDCNk2126Y=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kAXBLDy7Q3lZ+8ffnuNk0UrMzRzO6jp2MG4hmOc/Ne1YZLhU69tcZa2M9l0MT7g0z
	 leKC3vaGdpwcH5G0Qd440t9iKjQ0HBBrmwPWQHVTLhzA+0cI8QLyWh80oWGuxMYARn
	 4ja3UxypgZb25SSUeOKBc+oqPW3//m31kaZOexGU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACE81F801DA;
	Mon, 31 Aug 2020 19:57:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8428AF80212; Mon, 31 Aug 2020 19:57:46 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3A3EF80146
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 19:57:40 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B8A9DA0042;
 Mon, 31 Aug 2020 19:57:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B8A9DA0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1598896659; bh=i5fZ2Ot1wALIv89Ol9cNGS58A+wjMcWHMR6hVAJD34M=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=ERl0nyR18QNFJOo69X0tmSLMfxRy3UbMmDsK+PCcn1SFUlnV69DZZ95WrBQ6d/cT+
 N1OkLYOFhwOV86ItPzS8tRruusyRP0p0Nb6KFrPjnpMXK2KqBMv8Wpg1bMYs85opKo
 IaIwywB3VTbCw/To+ZvxrP7Lr2ue5bgVNq8aL5no=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 31 Aug 2020 19:57:33 +0200 (CEST)
Subject: Re: [PATCH v4 00/10] topology: decode: Various fixes
From: Jaroslav Kysela <perex@perex.cz>
To: Piotr Maziarz <piotrx.maziarz@linux.intel.com>, alsa-devel@alsa-project.org
References: <1598864943-22883-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <7f62aba5-1a74-ce3e-9c0c-796e56f1cea0@perex.cz>
Message-ID: <6335bfeb-8631-a392-fee3-8f244643bbeb@perex.cz>
Date: Mon, 31 Aug 2020 19:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7f62aba5-1a74-ce3e-9c0c-796e56f1cea0@perex.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
 tiwai@suse.com, amadeuszx.slawinski@linux.intel.com
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

Dne 31. 08. 20 v 13:11 Jaroslav Kysela napsal(a):
> Dne 31. 08. 20 v 11:08 Piotr Maziarz napsal(a):
>> This series fixes various problems with topology decoding mechanism.
>> Some of the problems were critical like improper memory management or
>> infinite loops that were causing undefined behaviour or program crashes,
>> while other resulted in losing some data during conversion.
>>
>> Bugs found while testing with Intel SST topologies.
> 
> Thank you for this work. I applied all patches to the alsa-lib repository. I
> dislike the last one - dynamic allocation for each printf(), but I applied it
> until we found a better solution.
> 
> We may use the dynamic allocation only when the printf is bigger than the 1024
> bytes threshold (and keep the small buffer on stack otherwise) or create 'dst'
> structure which will carry the output buffer point and the temporary buffer
> pointer which will be freed when the output is finished.

I implemented the later suggestion in:

https://github.com/alsa-project/alsa-lib/commit/472ab5db67a0ed04de634214773e7b17d10b5415

There are also other fixes in the topology library. It would be nice, if you
can give a test.

			Thank you,
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
