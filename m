Return-Path: <SRS0=riU+=6C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285C7C2BA19
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 22:25:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34B121BE5
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 22:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KYDttus5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxhW+B4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34B121BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B72CF1612;
	Sun, 19 Apr 2020 00:24:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B72CF1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587248746;
	bh=sSsGBAbyUZM42V2oC+QG3wLOkJwedpj7LmpBLFvmj8k=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KYDttus5nS64L9YENbCbWYD0YY1zyelemNTBsVdxh7Jy4/mUF3pPcZThNHRmggKKB
	 J8ey8Lnizj75MdPJeYRiGLgdFyJMmV/bfwIh48nZr+FM74SoCh1K28zPaQKSLUcQLq
	 PmNtu/0sBnbRJDo0szI2Y3dOjYlvR9uE1axuQxcA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54530F80122;
	Sun, 19 Apr 2020 00:24:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B3F8F8014E; Sun, 19 Apr 2020 00:24:54 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D887F80122
 for <alsa-devel@alsa-project.org>; Sun, 19 Apr 2020 00:24:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D887F80122
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="oxhW+B4v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=6BmXyiqO0wHj5DxV76+E1WoB5x4GFAz5ggF5vJlCwBY=; b=oxhW+B4vRTgqQBsuDwIsLFMEct
 6TX5T83DboBf3ez7X7kXQJafr/mSIetsMcmkxbozwlNZhrGP3KaBhB72DD90MaxwSTxz0xRfULyL6
 AvX4zavVft8NqRBtfqcYE2kitI1mQMkez/vCA6TpAShj11oJMTOdbM7o15E8RRIiAPkVoHCWwXASe
 A1EetPGnTH+meja3KBvzdtPeq+Nbub1BjZ119BN61NVOGGhALPjPbS/siMH++8AT0x7QlOdGIK5G+
 q5LOp3OsdL8SPeD26SqecS+Gp7dn5PPGGDyyTbrH2nVd3ur5IgeGTiwFOjWwfijvCRV7dqo/d/V99
 /QQogknA==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jPvt8-0003Nf-T0; Sat, 18 Apr 2020 22:24:39 +0000
Subject: Re: [RFC PATCH 1/9] kernel.h: add do_empty() macro
To: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-2-rdunlap@infradead.org>
 <f097242a-1bf0-218b-4890-3ee82c5a0a23@acm.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <144825af-536e-9f11-f055-7ff978ede505@infradead.org>
Date: Sat, 18 Apr 2020 15:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f097242a-1bf0-218b-4890-3ee82c5a0a23@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Zzy Wysm <zzy@zzywysm.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 target-devel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
 linux-scsi@vger.kernel.org, linux-nvdimm@lists.01.org,
 Vishal Verma <vishal.l.verma@intel.com>, linux-input@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-nfs@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Chuck Lever <chuck.lever@oracle.com>,
 linux-fsdevel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On 4/18/20 3:20 PM, Bart Van Assche wrote:
> On 4/18/20 11:41 AM, Randy Dunlap wrote:
>> --- linux-next-20200327.orig/include/linux/kernel.h
>> +++ linux-next-20200327/include/linux/kernel.h
>> @@ -40,6 +40,14 @@
>>   #define READ            0
>>   #define WRITE            1
>>   +/*
>> + * When using -Wextra, an "if" statement followed by an empty block
>> + * (containing only a ';'), produces a warning from gcc:
>> + * warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
>> + * Replace the empty body with do_empty() to silence this warning.
>> + */
>> +#define do_empty()        do { } while (0)
>> +
>>   /**
>>    * ARRAY_SIZE - get the number of elements in array @arr
>>    * @arr: array to be sized
> 
> I'm less than enthusiast about introducing a new macro to suppress "empty body" warnings. Anyone who encounters code in which this macro is used will have to look up the definition of this macro to learn what it does. Has it been considered to suppress empty body warnings by changing the empty bodies from ";" into "{}"?

I mentioned that possibility in PATCH 0/9 (cover letter)...
which should have been RFC PATCH 0/9.
So yes, it is possible.

You are the only other person who has mentioned it.

thanks.
-- 
~Randy

