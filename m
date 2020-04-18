Return-Path: <SRS0=riU+=6C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA905C352BE
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 18:51:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6988E21D93
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2020 18:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HmDUFs8t";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s8O9bLPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6988E21D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFFBE1612;
	Sat, 18 Apr 2020 20:50:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFFBE1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587235861;
	bh=9ITDjCN+DMGTcs8GHEzEQ+pHcQ26TGkj1ZzApmWLLm0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HmDUFs8tT85RZ9I7TDdjoNFRmA2fwh81QVqX6qDT3Co/y7ZWVaVKRlZRu1Qk+CLG2
	 BustrrFP0qHG1c1APJVNHPcL68exhu75ACtneKq4JlH1Wh8/WkJCMd4J8ItCWbONpT
	 EntLnw58lzPF0Pdcr5A8oBw2vusLKxQniu7Ktr1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76268F8012E;
	Sat, 18 Apr 2020 20:50:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A17A9F8014E; Sat, 18 Apr 2020 20:50:09 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 261EDF8012E
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2020 20:50:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 261EDF8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="s8O9bLPQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=na4bJ3PkcifD0nFgc5n3XvGryFaz89gkoFznEG5QSiA=; b=s8O9bLPQ3/PwyhlXG8w8qqYbwq
 sTtpsGIripwqUAVAAsu2nj/XCKxMas3tSgjRxl3gHNtvArdEj1uffO6xT7tPA3EqF9wmB93jjToSn
 N4K9MdbnF1AhlTs/5V0mo2YU4ioGpwniS9b7RLbThV642vvH0Oaw4DQvAXombZAy6nkuiqaTG5ZtZ
 3ETZbMbDXUb4qlER1RXVuV+nxpkl9G+aWvUaDQqrcR0Iyoie1anJryeuc5zYhk4x+UQ4IP5g9eBoV
 vQvnY/lULm5KVOhnO0YdeCnzPEXXBNqZu/Zs1RAWjA3aKwPFfzK/pLRb/7u0sH8oOF7NyLx+KXYAJ
 bRYCu/FA==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jPsXQ-0003BB-Ls; Sat, 18 Apr 2020 18:50:00 +0000
Subject: Re: [RFC PATCH 1/9] kernel.h: add do_empty() macro
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-2-rdunlap@infradead.org>
 <6bb8d99e6e56fa1622fc7238c1ae37c3b3510ded.camel@perches.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3990866b-3331-560d-e5e3-6b51ae51c1e2@infradead.org>
Date: Sat, 18 Apr 2020 11:49:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6bb8d99e6e56fa1622fc7238c1ae37c3b3510ded.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 4/18/20 11:44 AM, Joe Perches wrote:
> On Sat, 2020-04-18 at 11:41 -0700, Randy Dunlap wrote:
>> Add the do_empty() macro to silence gcc warnings about an empty body
>> following an "if" statement when -Wextra is used.
>>
>> However, for debug printk calls that are being disabled, use either
>> no_printk() or pr_debug() [and optionally dynamic printk debugging]
>> instead.
> []
>> +#define do_empty()		do { } while (0)
> 
> If this is really useful
> (I think the warning is somewhat silly)
> 
> bikeshed:
> 
> I think do_nothing() is more descriptive

Yes, I do too, as I more or less mentioned in the cover letter.

-- 
~Randy

