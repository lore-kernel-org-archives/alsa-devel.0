Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB38C41604
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 19:37:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50994206BE
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 19:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gEtkYOdi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bIBEUHlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50994206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5E3C16E0;
	Tue,  6 Oct 2020 21:36:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5E3C16E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602013021;
	bh=P6p+EJ+rRP+CiVxxUP+I8crIL7r+PvBwYT3Hqksd1vg=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gEtkYOdiydL4O/z0l3IrcZTGLipcBKrOHiYbZFgFIrWsqsqiWt5d8jCRPbwcx4Zdj
	 dw+kKPK+OQufWTOR6nUCOZQgxR0PnxgQnbpazUxDqvlyOtb+kWm5R4o8JXdHAHFgav
	 MZyWKdBVHaY2ugbhyxjaL8BwWUX9ZCgUpU25tvho=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E5DDF80128;
	Tue,  6 Oct 2020 21:36:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42BB3F8012A; Tue,  6 Oct 2020 21:36:09 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B368F80128
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 21:36:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B368F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="bIBEUHlO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=DJKJ8r3sz1KNUVoUA6+L/JRy5qYNTx6QHmLO0xUeMgk=; b=bIBEUHlO2Zq+nAPOB1WSpZCB+L
 fOiT5gyGLPR/t2q6QgJyPt4+h6c6MpfaDpfQy/kiWI2E6hOD6cG/gaWefTPn08AMySXjTNO5ms8rq
 UBHuRU75A7LtqJI+NvrAoKOQCxG74VOLFnd5QHz7YTDqMUQMDhWnJo+58CDFoNYYR2m4zUGqkYW/X
 LB/UcFaj431QMvXb5NJIF6w73YmfK4F6JqD3CyUYC7CTg6YrPgiK0vhZ9rqoY8SZ0YMMmQgTkUT9x
 zdwKWHZHjdVKznoG03Hkk5nF+OzekKsyjOCrMDc+Zuxr4OLvNCYt1VoUVkKA5LV0QLBI7n2rdUfZy
 XJuNDiZQ==;
Received: from [2601:1c0:6280:3f0::2c9a]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPskc-0007RY-3H; Tue, 06 Oct 2020 19:35:54 +0000
Subject: Re: linux-next: Tree for Oct 6 (sound/soc/intel/catpt/device.c)
From: Randy Dunlap <rdunlap@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201006231234.701591b5@canb.auug.org.au>
 <0d1072b7-c57c-6a50-0561-389ad6a3e414@infradead.org>
Message-ID: <3cb00b47-2143-e867-433d-4e8ba026cb90@infradead.org>
Date: Tue, 6 Oct 2020 12:35:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0d1072b7-c57c-6a50-0561-389ad6a3e414@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
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

On 10/6/20 11:54 AM, Randy Dunlap wrote:
> On 10/6/20 5:12 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20201002:
>>
> 
> on x86_64 or i386:
> when CONFIG_MODULES is not set/enabled:
> 
> ../sound/soc/intel/catpt/device.c: In function ‘catpt_resume’:
> ../sound/soc/intel/catpt/device.c:84:7: error: implicit declaration of function ‘module_is_live’; did you mean ‘module_driver’? [-Werror=implicit-function-declaration]
>   if (!module_is_live(dev->driver->owner)) {
>        ^~~~~~~~~~~~~~
>        module_driver
> 
> 
> You could see
> commit cdb685cb9158fa67f6f4584ea39279ed7ae39253
> Author: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Date:   Thu May 21 20:59:09 2020 +0200
> 
>     RDMA/rnbd: Fix compilation error when CONFIG_MODULES is disabled
> 
> for a possible fix.
> 

I also just saw this:

WARNING: unmet direct dependencies detected for DW_DMAC_CORE
  Depends on [n]: DMADEVICES [=n]
  Selected by [y]:
  - SND_SOC_INTEL_CATPT [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_SST_TOPLEVEL [=y] && (ACPI [=n] || COMPILE_TEST [=y]) && SND_DMA_SGBUF [=y]

so SND_SOC_INTEL_CATPT should also depend on DMADEVICES.


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
