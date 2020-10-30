Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085AAC00A89
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:04:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D633620729
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qOCRjZvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D633620729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B759F15E5;
	Fri, 30 Oct 2020 19:03:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B759F15E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604081084;
	bh=55FQBsEXOl3PXZ6zx8LObHWnJKqiQXmHYKRyOdhJyRE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qOCRjZvuKkupvx9qUCszgB8SbhfoCGgVn5RjHzhGG1t0SXVTZHQPGj14USULbyGh8
	 bobTH7D/SJ22lwF+mckSYKnFD9MJzC0p0zvpUz1alqZsJH4fElRUXUTgzYW6DW1uoE
	 6weU0Zl5Sz9XXIZriJ0eTIEEqJT4kV4bIAEkaW0U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28CFFF801D5;
	Fri, 30 Oct 2020 19:03:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0122F80212; Fri, 30 Oct 2020 19:03:51 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D64FBF800FF
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 19:03:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D64FBF800FF
IronPort-SDR: dW46Eb9mkqcIf2b5wXrKCnEXlDa0/VSRVwtPndLiS/iMDi8JkRLzQ359Ga0JYI6J2Lr5ohTeGM
 xV1tVoRz58mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="166060004"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; d="scan'208";a="166060004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2020 11:03:41 -0700
IronPort-SDR: Zju8Tqf+Dr10H+s+LbQXlYDo5BteOucn0MS4mZK4vR/PhJVV2jEqojAmzDdsSSc9FZ1BkGT/jY
 TznzYUauRoYw==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; d="scan'208";a="351357510"
Received: from rdchavez-mobl2.amr.corp.intel.com (HELO [10.212.91.180])
 ([10.212.91.180])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2020 11:03:39 -0700
Subject: Re: [PATCH v2 0/2] Add rt1015 support to CML boards
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
References: <20201030170559.20370-1-brent.lu@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f85e56df-f413-d199-c2dd-2d9f1713e3b2@linux.intel.com>
Date: Fri, 30 Oct 2020 13:03:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030170559.20370-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jason Yan <yanaijie@huawei.com>,
 Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Rander Wang <rander.wang@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Fred Oh <fred.oh@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>
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



On 10/30/20 12:05 PM, Brent Lu wrote:
> First patch adds tdm 4-slot 100fs DAI setting to avoid jitter of using
> 64fs on CML boards. Second patch is a DMI quirk for HP Dooly.
> 
> Changes since v1:
> -Add comment on Dooly's DMI quirk
> 
> Brent Lu (2):
>    ASoC: intel: sof_rt5682: Add support for cml_rt1015_rt5682
>    ASoC: intel: sof_rt5682: Add quirk for Dooly

For the series

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Brent!

> 
>   sound/soc/intel/boards/sof_rt5682.c           | 65 +++++++++++++++++--
>   .../intel/common/soc-acpi-intel-cml-match.c   | 13 ++++
>   2 files changed, 73 insertions(+), 5 deletions(-)
> 
