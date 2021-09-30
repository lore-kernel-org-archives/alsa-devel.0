Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33042C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 20:25:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B136361A4F
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 20:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B136361A4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99A9E16AF;
	Thu, 30 Sep 2021 22:24:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99A9E16AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633033522;
	bh=WpLftkhDhcjLdKo6ABzVP2HW5QRJ4JrSyj8+/bSZ9uc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g5LVsmToOrJLRwJ0Oz1rtldXjhZBEyChCJwDj+DKTDMteE3JV29/0KR+sVGR0Hcz2
	 3/M8ec+c8GPsjkxJC/Cnta78OhRZj/wMw8HkH8T+HzVnqJTkptqrjVrzxNMUxS7tm6
	 JmRXniw9+Bnp0OaPLbaxpEXDorU7yKA5/oPhR/II=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E546F8032C;
	Thu, 30 Sep 2021 22:24:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00F64F804AD; Thu, 30 Sep 2021 22:24:30 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A84BF800F3
 for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2021 22:24:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A84BF800F3
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="212538115"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="212538115"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 13:24:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="521334832"
Received: from lcalx-mobl1.amr.corp.intel.com (HELO [10.212.88.180])
 ([10.212.88.180])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 13:24:12 -0700
Subject: Re: [PATCH] ASoC: SOF: Intel: hda-stream: limit PROCEN workaround
To: Mark Brown <broonie@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
References: <20210928082248.6081-1-peter.ujfalusi@linux.intel.com>
 <20210928151012.GA25932@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <795a1c96-c4b5-a364-e192-58358c90d5de@linux.intel.com>
Date: Thu, 30 Sep 2021 15:24:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928151012.GA25932@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, rander.wang@intel.com, lgirdwood@gmail.com,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com
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



On 9/28/21 10:10 AM, Mark Brown wrote:
> On Tue, Sep 28, 2021 at 11:22:48AM +0300, Peter Ujfalusi wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> The work-around enabled in hda-stream.c is only required on earlier
>> versions of SOCs/PCH (Skylake, KabyLake, ApolloLake,
>> GeminiLake). Before setting the format on the host DMA, it is required
>> to couple the host and link DMA - which as a consequence shall use the
>> same format.
> 
> This breaks the build for me:
> 
> /mnt/kernel/sound/soc/sof/intel/hda-stream.c: In function 'hda_dsp_stream_hw_params':
> /mnt/kernel/sound/soc/sof/intel/hda-stream.c:436:42: error: implicit declaration of function 'get_chip_info'; did you mean 'get_group_info'? [-Werror=implicit-function-declaration]

Ack, we're missing a dependency.

Peter, this function was moved to shim.h with Ranjani's patch
"ASoC: SOF: Intel: hda: expose get_chip_info()"

That patch was added in the SOF multi-core series.
