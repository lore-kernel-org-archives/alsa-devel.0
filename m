Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D1AC433E1
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:03:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269A020737
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ki9MuhDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269A020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9999016D1;
	Thu,  2 Jul 2020 17:02:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9999016D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593702226;
	bh=RzuxJDCWoVijtS38qYxdfdrVKsqcOrwvyYi5323sG1E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ki9MuhDpFfoAXiUyyjfyl7PFFZnLqoq3LTnktOT3sIvfOzjquJp80RKaMuLJ/g6tf
	 cdEkXlKW6JOwft+mRu+qR6a+2bb+dDCum47+ZtNKpUU2xQmE6HVsO7gnUDgqf8Q8FO
	 rsaA4/VN57qqrBUgOO+anduZXgYFG8Khk2lhAUcE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8B7EF80245;
	Thu,  2 Jul 2020 17:02:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7104F80252; Thu,  2 Jul 2020 17:02:53 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18A7DF80134
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 17:02:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18A7DF80134
IronPort-SDR: xHP95+yHDBpjp3/9K8Iq6T3wqcPeOueLVkElFwhnypbxvasdKO+j6XwbCxAW2oEHyYuhoBY99v
 TGkSPTMQyeXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="145063685"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="145063685"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 08:02:41 -0700
IronPort-SDR: W/iS25Y2HU7wr+H0UDFRVD3TdGcuFXMVpdLnjPeZ9a4kObj1kYA7x++obbTVf6rR1WgJA/yPNp
 LlVVPdTUSaZw==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="304275473"
Received: from nchava-mobl1.amr.corp.intel.com (HELO [10.252.135.144])
 ([10.252.135.144])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 08:02:40 -0700
Subject: Re: [PATCH] riscv: asm/gdb_xml.h: use __maybe_used to make W=1
 warnings go away
To: Vincent Chen <vincent.chen@sifive.com>
References: <20200701184751.84008-1-pierre-louis.bossart@linux.intel.com>
 <CABvJ_xhm9a0nzBJ2YKvwm5vKZt3Xp0H9z6QakD0EYK7vRR-_AA@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f148580a-f97d-3416-ca03-c3a425189568@linux.intel.com>
Date: Thu, 2 Jul 2020 09:20:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CABvJ_xhm9a0nzBJ2YKvwm5vKZt3Xp0H9z6QakD0EYK7vRR-_AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Albert Ou <aou@eecs.berkeley.edu>,
 kernel test robot <lkp@intel.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, broonie@kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
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



On 7/1/20 9:04 PM, Vincent Chen wrote:
> On Thu, Jul 2, 2020 at 2:48 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> 0day/kbuild reports warnings with the ASoC codecs compiled with W=1.
>>
>> In file included from arch/riscv/include/asm/kgdb.h:109,
>>                   from include/linux/kgdb.h:20,
>>                   from include/linux/fb.h:5,
>>                   from include/drm/drm_crtc.h:31,
>>                   from sound/soc/codecs/hdmi-codec.c:19:
>>
>> arch/riscv/include/asm/gdb_xml.h:23:19: warning:
>> 'riscv_gdb_stub_cpuxml' defined but not used [-Wunused-const-variable=]
>>     23 | static const char riscv_gdb_stub_cpuxml[2048] =
>>        |                   ^~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/gdb_xml.h:16:19: warning:
>> 'riscv_gdb_stub_target_desc' defined but not used [-Wunused-const-variable=]
>>     16 | static const char riscv_gdb_stub_target_desc[256] =
>>        |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/gdb_xml.h:13:19: warning:
>> 'gdb_xfer_read_cpuxml' defined but not used [-Wunused-const-variable=]
>>     13 | static const char gdb_xfer_read_cpuxml[39] =
>>        |                   ^~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/gdb_xml.h:10:19: warning:
>> 'gdb_xfer_read_target' defined but not used [-Wunused-const-variable=]
>>     10 | static const char gdb_xfer_read_target[31] = "qXfer:features:read:target.xml:";
>>        |                   ^~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/gdb_xml.h:7:19: warning:
>> 'riscv_gdb_stub_feature' defined but not used [-Wunused-const-variable=]
>>      7 | static const char riscv_gdb_stub_feature[64] =
>>        |                   ^~~~~~~~~~~~~~~~~~~~~~
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>
>> I don't know if this is the right way of solving this issue but this
>> error is now consistently thrown in kbuild compile-test reports w/
>> W=1.
>>
> 
> Dear Pierre-Louis Bossart:
> Thanks for your modifications. I have fixed the warnings in my latest
> KGDB patchset and sent it out, but the merged KGDB patchset is not my
> latest version.
> I have sent a patch set to complement the missing ports, and I think
> these warnings would disappear after this patch has been accepted and
> merged.
> 
> Here is the patch to fix this warning:
> http://lists.infradead.org/pipermail/linux-riscv/2020-June/000660.html

Thank you Vincent, let's drop my hacky patch then.
