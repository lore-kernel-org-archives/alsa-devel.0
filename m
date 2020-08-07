Return-Path: <SRS0=pDBX=BR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9970FC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:07:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2124D221E2
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hHSkOZv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2124D221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9492B85D;
	Fri,  7 Aug 2020 15:06:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9492B85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596805637;
	bh=ynKUQ5C/IjqwdqP7kbjsgNu6KaqCrQYoxaO95yslmQI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hHSkOZv1xqxA3Pb4rK2A/vDyL1DYcUWeuuLz/3GJ+zt8eiwGEWjDjiofNTGeYMqfq
	 U0JlStFg/q8DLb9g534X5ZIlS2uuz+MBkFHCajxZeO2ciOel3ZryZdCm3GYJuoPjVy
	 Iw7JuVmusdNoA6IYvn52t9myuxytYJF9zm8ASE8w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DA19F80234;
	Fri,  7 Aug 2020 15:06:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBECBF8023E; Fri,  7 Aug 2020 15:06:25 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E0E8F800B7
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2020 15:06:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E0E8F800B7
IronPort-SDR: ipRwaT4x65uiaoIYH8ua2fG55bjMEOlj3UG2U4q/BvcaitK9aua0lQgzmkbz5Zn6D9mkf4OTip
 9Vh4jf/gBZag==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140667225"
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; d="scan'208";a="140667225"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2020 06:05:53 -0700
IronPort-SDR: 0yMK1IswMLYSYBpMw2tB5IO4yqD7SzTvDmbx8BQ5dXIUV9EPWBhfRp7D6eLUBeJYDqxWMVqxau
 E1O/DJKEUw0g==
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; d="scan'208";a="307370116"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.153.24])
 ([10.249.153.24])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2020 06:05:49 -0700
Subject: Re: [PATCH 00/13] ASoC: Intel: Catpt - Lynx and Wildcat point
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200807110649.17114-1-cezary.rojewski@intel.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <275aa4b8-a98e-9d32-38ad-746783731fe0@linux.intel.com>
Date: Fri, 7 Aug 2020 15:05:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807110649.17114-1-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: andriy.shevchenko@intel.com, filip.kaczmarski@intel.com,
 harshapriya.n@intel.com, ppapierkowski@habana.ai, marcin.barlik@intel.com,
 zwisler@google.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 filip.proborszcz@intel.com, broonie@kernel.org, michal.wasko@intel.com,
 tiwai@suse.com, cujomalainey@chromium.org, vamshi.krishna.gopal@intel.com
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



On 8/7/2020 1:06 PM, Cezary Rojewski wrote:

> 
> Special thanks go to Marcin Barlik and Piotr Papierkowski for sharing
> their LPT/WPT AudioDSP architecture expertise as well as helping
> backtrack its historical background.
> My thanks go to Amadeusz Slawinski for reviews and improvements proposed
> on and off the internal list. Most of diff below is his contribution.
> Krzysztof Hejmowski helped me setup my own Xtensa environment and
> recompile LPT/WPT FW binary sources what sped up the development greatly.
> 
As mentioned I've already seen those patches before and gone through 
them once again now, as I have no more comments:

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
