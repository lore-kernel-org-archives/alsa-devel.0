Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03CAC43466
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:59:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474AD20866
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 13:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PJKjDD6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474AD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B54BF16C2;
	Mon, 21 Sep 2020 15:58:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B54BF16C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600696788;
	bh=VknibLNvzP4bPfXlcBo6XgJj3gaRos7YMDEF4dY5c4A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PJKjDD6NMv7DoTA4w3ccK2W24j8x9sacRl68JadpIbHwqP2YRC01mBTs5mf7dOCuc
	 m86wiS6p0472H629UF+W+xt2WCT2c54foTXs9EfKM/BjEVTphIZfeXPX/4HHXQ2EIZ
	 wGzKzSaSlDLxL3E5v7M2uO9ZGJTxNGBAU+2tGlvg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F37FF80161;
	Mon, 21 Sep 2020 15:58:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9488F8015F; Mon, 21 Sep 2020 15:58:56 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B586F8015F
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 15:58:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B586F8015F
IronPort-SDR: IK/3jpAG9/dUsSLJEp3G1rE01V4bWi31IIHQfwoZLJhQMsXf2jaem+nLe+iCovZvioD5gXfoxf
 g8hYQAMlvE6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="139879736"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="139879736"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 06:58:40 -0700
IronPort-SDR: esHjewjzPOyjwAiTa36qtJGR3vZdNW8DQmdjQlogTwN4+u3VPTx/quxklMinlTxDOp5s++eneF
 YFvCy6t0qD3Q==
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="485483175"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.249.148.113])
 ([10.249.148.113])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 06:58:35 -0700
Subject: Re: [PATCH v7 03/14] ASoC: Intel: catpt: Add IPC message handlers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <20200921115424.4105-1-cezary.rojewski@intel.com>
 <20200921115424.4105-4-cezary.rojewski@intel.com>
 <20200921125934.GT3956970@smile.fi.intel.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <2c073526-fc9d-832b-48d4-f955e3b99e24@linux.intel.com>
Date: Mon, 21 Sep 2020 15:58:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921125934.GT3956970@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, filip.kaczmarski@intel.com,
 harshapriya.n@intel.com, gregkh@linuxfoundation.org, ppapierkowski@habana.ai,
 marcin.barlik@intel.com, zwisler@google.com,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 filip.proborszcz@intel.com, broonie@kernel.org, michal.wasko@intel.com,
 tiwai@suse.com, krzysztof.hejmowski@intel.com, cujomalainey@chromium.org,
 vamshi.krishna.gopal@intel.com
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

On 9/21/2020 2:59 PM, Andy Shevchenko wrote:
>> +struct catpt_set_volume_input {
>> +	u32 channel;
>> +	u32 target_volume;
>> +	u64 curve_duration;
>> +	enum catpt_audio_curve_type curve_type __aligned(4);
>> +} __packed;
> How this __packed changes anything? In general __packed doesn't make sense for
> in-kernel data structures. Otherwise you have to use proper (POD) types for
> data. Ditto for all similar cases.

All of __packed use in code is done on structures used to communicate 
with FW, which is binary interface, so it is not kernel only structure, 
as it is also FW one. While we can expect compiler to do the right 
thing, I consider it is better to be explicit about what kind of data we 
are handling, so there aren't any surprises.
