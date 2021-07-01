Return-Path: <SRS0=xdAn=LZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B531CC11F64
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Jul 2021 15:17:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC99613F8
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Jul 2021 15:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC99613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A97A1692;
	Thu,  1 Jul 2021 17:16:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A97A1692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625152626;
	bh=YSy1Atfa9Acc1pRwUBvUglmbJ7Q7Plhq4GrBGTfqAjo=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DzTK+SpD9HUgfW/XjALwIFhajJSPBshCfwoO28TRk6PH/sGK+CuKIEgHm+o09llsi
	 Exr5HVGIltTw7xDMUXVhjFWftUKuUCbedDglx6NNhjGxaNSEraaNf5BiHdczdvOBha
	 vHSM01aM2YoU7AwloSA+q4+2G0VnxxJxcxZPZ/kg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 345ADF800BA;
	Thu,  1 Jul 2021 17:16:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E72BF802D2; Thu,  1 Jul 2021 17:16:15 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D600F800BA
 for <alsa-devel@alsa-project.org>; Thu,  1 Jul 2021 17:16:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D600F800BA
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="272406168"
X-IronPort-AV: E=Sophos;i="5.83,314,1616482800"; d="scan'208";a="272406168"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2021 08:16:01 -0700
X-IronPort-AV: E=Sophos;i="5.83,314,1616482800"; d="scan'208";a="447927843"
Received: from upadmana-mobl.amr.corp.intel.com (HELO [10.212.78.216])
 ([10.212.78.216])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2021 08:16:00 -0700
Subject: Re: [PATCH v2 1/2] ASoC: cs35l41: CS35L41 Boosted Smart Amplifier
To: David Rhodes <drhodes@opensource.cirrus.com>, broonie@kernel.org,
 robh@kernel.org, ckeepax@opensource.cirrus.com, brian.austin@cirrus.com,
 patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 david.rhodes@cirrus.com
References: <20210629222719.1391653-1-drhodes@opensource.cirrus.com>
 <20210629222719.1391653-2-drhodes@opensource.cirrus.com>
 <b14da5ca-2b5a-43fc-11bb-7f87c873d3c4@linux.intel.com>
 <9e432f81-9229-57d3-5231-50d6f935d084@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5b39ac3e-2992-e107-a65b-f005b8c842f8@linux.intel.com>
Date: Thu, 1 Jul 2021 06:54:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9e432f81-9229-57d3-5231-50d6f935d084@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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



On 6/30/21 4:35 PM, David Rhodes wrote:
> On 6/29/21 6:51 PM, Pierre-Louis Bossart wrote:
>>
>>> +#ifdef CONFIG_ACPI
>>> +static const struct acpi_device_id cs35l41_acpi_match[] = {
>>> +    { "CSC3541", 0 }, /* Cirrus Logic PCI ID + part ID */
>>
>> Wrong comment or wrong ID, "CSC" is clearly not a PCI ID?
>>
> 
> CSC is a PnP ID, not a PCI ID. I will change the comment to reflect this.

Funny to see how Crystal Semiconductor still shows in PNP IDs, 30 years after being acquired by Cirrus Logic...

