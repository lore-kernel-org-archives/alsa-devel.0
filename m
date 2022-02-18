Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90580C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Feb 2022 18:13:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9205817DD;
	Fri, 18 Feb 2022 19:12:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9205817DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645207984;
	bh=qJpUQfCMiajF+akcXvNXCP6L2CbGn7TS+KQgaql4Uhw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GtdwvlyTmXG7lRxy3Hi9E/AaA8ghOxYRmkIU+wrkZZVDUYxTEj0pPB0Ht8n1TDtgk
	 VKUnG4GuVZoLGiKB7cofetzZOzCWa5oHG+WaRSIxj6Ai2d/O2jOTY4NOIwT1wfsNdL
	 VE7+CkecbIE1bPxk5mH+NCPmytDYvuamYIZbxNCM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FBA6F8012B;
	Fri, 18 Feb 2022 19:12:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2BEAF8013C; Fri, 18 Feb 2022 19:12:12 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EE9CF800FF
 for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2022 19:12:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EE9CF800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="WjjaQ73k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645207929; x=1676743929;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qJpUQfCMiajF+akcXvNXCP6L2CbGn7TS+KQgaql4Uhw=;
 b=WjjaQ73k4tpYNs+wNAT0CORlBw5A58A4wMGRAXrqNkYJIqKzTMfkLKLe
 Jy7Tg90tc+eb++7NgyLnlNg2r+TkV+ahoFy3EhgRUqp0hGlc/XaeR1gD0
 dIOCuh3Uw8gqU+QwlgLuSYC6EnOhVgcSA0LOxghE5Zb6U4cS7xj3AZpAs
 mGCpXlWBLPxg59AzXgJupC1BLWCCEwhgmqSwz7FkU7bPeUOetr5V7DtTk
 EAmmNT3cFGnIv1EVj1ZDdJQNCuZNviW8aLQtoUBe1RmteXkCo9/0MBPKM
 R9GILCMPcJUQ/ir7bGajfr8Yu1GsSQXAk/zNolNFQC8Fj6y1sa/Ej4VQW A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231165055"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; d="scan'208";a="231165055"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 10:12:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; d="scan'208";a="504080860"
Received: from ryanflyn-mobl.amr.corp.intel.com (HELO [10.212.54.106])
 ([10.212.54.106])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 10:11:59 -0800
Message-ID: <c17173cb-290c-9ecd-54e3-b74f9d4e9061@linux.intel.com>
Date: Fri, 18 Feb 2022 12:11:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 0/1] sound: add quirk for Huawei D15
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <cover.1640351150.git.mchehab@kernel.org>
 <164519450743.1836505.3912962145996830275.b4-ty@kernel.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <164519450743.1836505.3912962145996830275.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Huajun Li <huajun.li@intel.com>
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



On 2/18/22 08:28, Mark Brown wrote:
> On Fri, 24 Dec 2021 14:09:48 +0100, Mauro Carvalho Chehab wrote:
>> Based on my tests, Huawei D15 (Intel) uses SSP0 on es8336.
>>
>> Add a quirk for it.
>>
>> Please notice that, currently, only the internal speaker is working.
>> The topology for the internal microphone and for the headphones
>> is wrong. Enabling/disabling the other two quirks (GPIO and/or DMIC)
>> doesn't cause any audible results, nor change the devices listed
>> on pavucontrol (tested with pipewire-pulse).
>>
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: Intel: sof_es8336: add quirk for Huawei D15 2021
>       commit: ce6a70bfce21bb4edb7c0f29ecfb0522fa34ab71

I'll probably revert this change in my next update [1], I have a set of
changes where we can detect which SSP is used by parsing the NHTL
information in platform firmware.

I am still trying to figure out how to detect which MCLK is used, and
once this is done I'll send the patches upstream.

[1] https://github.com/thesofproject/linux/pull/3338
