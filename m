Return-Path: <SRS0=jDen=FJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F763C433FE
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 15:00:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AA623107
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 15:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AA623107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04547190E;
	Sat,  5 Dec 2020 16:00:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04547190E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607180451;
	bh=8YZq+wYhe31/EFf6Cu7wqNO0rxvXUXho/5LNapKytA0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V6Bj+6Rcw7LRhECzYGd1JaOY0aPMlI3RmStfaMtmhNapVKfvVHPX2AB2z8vPWimvc
	 3+dGm5K0ekWZfgBwjPVoWkN0mrYGmwuW4arnIaNlFzIZZ1DJpV2fMHr7jVIyJVV7XF
	 vZURzp9I/FCSGDW1l+j/umLkZXAlMAG1ZreBUqOc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EA18F8016D;
	Sat,  5 Dec 2020 16:00:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 215E4F800E2; Sat,  5 Dec 2020 15:59:59 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93C63F800E2
 for <alsa-devel@alsa-project.org>; Sat,  5 Dec 2020 15:59:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93C63F800E2
IronPort-SDR: 1MJK8hg5WLrrJmreQzw5tj0OcTVeXyWUKWWlMAswm8bw8nKtL3fu8zFrykLqDXGCcVCN/riAMH
 6A8wRMMriv2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="237628582"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; d="scan'208";a="237628582"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2020 06:59:52 -0800
IronPort-SDR: +vl+HACmjCKcAtpEM37NXeuK0wfxYW7gV4L1SEvyX/90iJeWmUPkwGbEPU4HvxhF+3xikZUCgi
 GC/J6Jf/Vm+A==
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; d="scan'208";a="436104261"
Received: from schamb2-mobl2.amr.corp.intel.com (HELO [10.212.89.161])
 ([10.212.89.161])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2020 06:59:51 -0800
Subject: Re: [PATCH 4/7] soundwire/regmap: use _no_pm functions in
 regmap_read/write
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-5-yung-chuan.liao@linux.intel.com>
 <20201205074554.GR8403@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f72fc1d5-f904-2247-17ef-d01a9fcf0b97@linux.intel.com>
Date: Sat, 5 Dec 2020 08:43:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201205074554.GR8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
 bard.liao@intel.com
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


>> -static int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
>> +int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
>>   {
>>   	return sdw_nwrite_no_pm(slave, addr, 1, &value);
>>   }
>> +EXPORT_SYMBOL(sdw_write_no_pm);
> 
> Why not export this is patch 1..?

yes, good point. I guess Bard and I were debugging in parallel and 
missed this. thanks for pointing it out.
