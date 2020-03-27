Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253AFC43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:52:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0F820A8B
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JR63DeE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0F820A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE5371670;
	Fri, 27 Mar 2020 17:14:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE5371670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585325708;
	bh=T39a/qIfzzNNxTvKzWHqcQIy6NjCPv/IOGgD4b2qhyY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JR63DeE6GuGqe8XBYN6CwEpbF3CCjZPJT/14to8pvPalxO8UNPHlkBKcpKqyhmh9j
	 0WZz3obqBSLQyOvYg29s5P7IQO14NQp8guGxDMVyGGNU5FuoEKh6ECuHKVdKJ3/wPK
	 oHuPrpqaoSWz7OA7ETdOxUdCSnIzyYZcHUY/CMtg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F821F80147;
	Fri, 27 Mar 2020 17:14:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 920CBF80158; Fri, 27 Mar 2020 17:14:16 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F664F800EA
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 17:14:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F664F800EA
IronPort-SDR: IrBNMkxvJs2odiu5kqlbxMGu5k3RPtPGSdd/Bq7fc0PUe2QcCh8rFkNp06W1LAx0Nb3vqeXjcI
 XJFpGC5ys4iQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 09:14:06 -0700
IronPort-SDR: U9x5JaJbgDUHRSJc+7epX8RJdD+0e7W838ZRLhnExYcWGWjGbVCcHxb7H/c8FsXmMfROf1unk/
 sc+WwLmSd1Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; d="scan'208";a="239140332"
Received: from mvargasp-mobl.amr.corp.intel.com (HELO [10.134.103.63])
 ([10.134.103.63])
 by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2020 09:14:06 -0700
Subject: Re: [PATCH 0/4] ASoC: Intel: add SoundWire machine driver
To: Mark Brown <broonie@kernel.org>
References: <20200325220746.29601-1-pierre-louis.bossart@linux.intel.com>
 <20200327160515.GG4437@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <28879805-22b0-8e4d-d204-fa406146cbc1@linux.intel.com>
Date: Fri, 27 Mar 2020 11:14:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327160515.GG4437@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
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



On 3/27/20 11:05 AM, Mark Brown wrote:
> On Wed, Mar 25, 2020 at 05:07:42PM -0500, Pierre-Louis Bossart wrote:
>> To handle multiple hardware combinations, this patchset suggests a
>> single machine driver which will create and initialize dailinks
>> dynamically. This allows us to support new configurations easily, as
>> shown with the TigerLake rt5682 example.
> 
> This doesn't apply against current code, please check and resend.

ok, will resubmit. Likely the chromebook patch that didn't flow through 
the SOF tree now that I think of it.
