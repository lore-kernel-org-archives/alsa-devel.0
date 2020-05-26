Return-Path: <SRS0=6DhY=7I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACF1C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 14:35:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94E320679
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 14:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PQJd+IMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94E320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F397172C;
	Tue, 26 May 2020 16:34:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F397172C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590503746;
	bh=GU7XjqnK1s6AnZAb3wQUxnoLb3I5CN3plTEIzHnqDok=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PQJd+IMUSaoAS3VmJ7lrYZ0sY58GxoccxvyNP43No+DSyqwhG0OrZ0xuyci1gJPPw
	 dnQB1I4IAXE0byRacflqIgMOpuJE5SO75DeIA3S6iPYSP9t3N91syFh+7+ipDRmLF9
	 8YOltgukgYHOTqpaW2HmXm43rIRuLVeH6B4DhJ1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AB07F80150;
	Tue, 26 May 2020 16:34:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FCEDF8015C; Tue, 26 May 2020 16:34:53 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45788F80100
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2020 16:34:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45788F80100
IronPort-SDR: sqhIr1jaHA6giBrOaVHcF3oRql3p5QbRUK7FWRO7uWq7ZqXV7tlpv2p8wfmt5xwg/jFwqxRNPr
 7M8pnJ3pMdbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 07:34:41 -0700
IronPort-SDR: lYBmZtOllzA7SYiVXe9dzD/x2MXMHvueaFXpF/KsbPuWJgdhpndwrctYuNSkXQ5/wSAIQ5jcKO
 Uu/+ZdKPHsHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; d="scan'208";a="345194887"
Received: from jacwang-mobl1.ccr.corp.intel.com (HELO [10.254.210.216])
 ([10.254.210.216])
 by orsmga001.jf.intel.com with ESMTP; 26 May 2020 07:34:39 -0700
Subject: Re: [PATCH v2 0/2] ASoC topology header parsing refinement
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200521074847.71406-1-yang.jie@linux.intel.com>
 <32df1cf8-8a57-7fc8-c694-6ddcc03fffca@intel.com>
From: Keyon Jie <yang.jie@linux.intel.com>
Message-ID: <17aad566-e555-2c8d-9b1f-bf702e586a7f@linux.intel.com>
Date: Tue, 26 May 2020 22:34:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <32df1cf8-8a57-7fc8-c694-6ddcc03fffca@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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



On 5/26/20 8:40 PM, Cezary Rojewski wrote:
> On 2020-05-21 9:48 AM, Keyon Jie wrote:
>> This small series is to optimize the header logging during the topology
>> parsing. This is verified work fine on both SOF and SST drivers
>> (bxt_rt298 with dfw_sst.bin).
>>
>> Change History:
>> v2:
>> - Change the internal used array to be 'static' to fix the issue
>>    reported by: kbuild test robot <lkp@intel.com>
>> - Add testing coverage including Intel SST driver also.
>>
>> v1:
>> - Initial version.
>>
>> Keyon Jie (2):
>>    ASoC: topology: refine and log the header in the correct pass
>>    ASoC: topology: remove the redundant pass checks
>>
>>   sound/soc/soc-topology.c | 99 ++++++++++++++++++----------------------
>>   1 file changed, 44 insertions(+), 55 deletions(-)
>>
> 
> No regression after applying these and running through SST CI on cAVS 
> 1.5+ (GLK) and 1.8 (CNL).

Thanks a lot for the validation.

> 
> Given some comments on 1/2 though, believe it could be simplified.

reply on the 1/2 commit.

~Keyon

> 
> Czarek
