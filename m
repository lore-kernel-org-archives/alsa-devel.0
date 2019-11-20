Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7A6C432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:11:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF9C206EC
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="juMviqA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF9C206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EA9716E6;
	Wed, 20 Nov 2019 17:10:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EA9716E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574266292;
	bh=OLUuHXofsGggbV446EkSDDlDb5VCRkfpoDxmcT8KoUQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=juMviqA0xnGX1v0V2AwXcsNWzLmXiQlZt42Uyrr57xM/YN+WXzWDVXvAiMRSpXpo1
	 yZeyagO5F7Tov7GJJtxNl/BH8WPYK+ZsssBn3ZkSm6qBCdBDVkOCL5KNq14dvhWVMy
	 92fM/7msyshNBCtplHEhx6c78RGhSMVqKBMKkVxQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B9EAF8013F;
	Wed, 20 Nov 2019 17:10:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D62AF8013F; Wed, 20 Nov 2019 17:10:40 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54824F800C1
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 17:10:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54824F800C1
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Nov 2019 08:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; d="scan'208";a="204862313"
Received: from ngoel1-mobl1.amr.corp.intel.com (HELO [10.255.66.61])
 ([10.255.66.61])
 by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2019 08:10:33 -0800
To: Tzung-Bi Shih <tzungbi@google.com>, broonie@kernel.org
References: <20191120060256.212818-1-tzungbi@google.com>
 <20191120060256.212818-4-tzungbi@google.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8273f728-3d4b-b0dc-03b7-6276c5ae4460@linux.intel.com>
Date: Wed, 20 Nov 2019 08:32:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191120060256.212818-4-tzungbi@google.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
Subject: Re: [alsa-devel] [PATCH 3/3] ASoC: max98090: fix possible race
 conditions
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 11/20/19 12:02 AM, Tzung-Bi Shih wrote:
> max98090_interrupt() and max98090_pll_work() run in 2 different threads.
> There are 2 possible races:
> 
> Note: M98090_REG_DEVICE_STATUS = 0x01.
> Note: ULK == 0, PLL is locked; ULK == 1, PLL is unlocked.
> 
> max98090_interrupt      max98090_pll_work
> ----------------------------------------------
> schedule max98090_pll_work
>                          restart max98090 codec
> receive ULK INT
>                          assert ULK == 0
> schedule max98090_pll_work (1).
> 
> In the case (1), the PLL is locked but max98090_interrupt unnecessarily
> schedules another max98090_pll_work.

if you re-test that the PLL is already running, then you can exit the 
work function immediately without redoing the sequence?

maybe also play with the masks so that the PLL unlock is masked in the 
interrupt and unmasked after the PLL locks?

> 
> max98090_interrupt      max98090_pll_work      max98090 codec
> ----------------------------------------------------------------------
>                                                 ULK = 1
> receive ULK INT
> read 0x01
>                                                 ULK = 0 (clear on read)
> schedule max98090_pll_work
>                          restart max98090 codec
>                                                 ULK = 1
> receive ULK INT
> read 0x01
>                                                 ULK = 0 (clear on read)
>                          read 0x1
>                          assert ULK == 0 (2).

what are those 0x01 and 0x1? is the second a typo possibly?

> 
> In the case (2), both max98090_interrupt and max98090_pll_work read
> the same clear-on-read register.  max98090_pll_work would falsely
> thought PLL is locked.
> 
> There are 2 possible options:
> A. turn off ULK interrupt before scheduling max98090_pll_work; and turn
> on again before exiting max98090_pll_work.
> B. remove the second thread of execution.
> 
> Adopts option B which is more straightforward.

but has the side effect of possibly adding a 10ms delay in the interrupt 
thread?

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
