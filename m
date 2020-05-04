Return-Path: <SRS0=TVyu=6S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4B5C3A5A9
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 10:29:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8E7206B8
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 10:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QB5t/VUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8E7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4618516D9;
	Mon,  4 May 2020 12:28:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4618516D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588588138;
	bh=0YLZJqt0kw8DzTvmfelTI0C4WgwZmu7hzexYsuoQbbs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QB5t/VULo1k+1PZ73dnyaSUY193eUsf3Ss7yrKQGRNy8xX+VYVpRYNVt0XClKqlSh
	 WAdqpSGzg6fxJEnvXg+WCdtKhm5c/rZ0WgK2VrOFdXrUv02vCZ1FVpq+pKU7hz+H/8
	 vc3/Ds/u9K9CcJNTru7gsegNnZAqaF9mKFIEOu9Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6564F80249;
	Mon,  4 May 2020 12:28:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3DD8F80259; Mon,  4 May 2020 12:28:01 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86623F800E5
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2020 12:27:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86623F800E5
IronPort-SDR: WmnRRxOyNpnc4UKNI2aCw6k2K2EJCQYUvFzPVJ7Aij6aXz/PXqjPURE6n79IXlQ+IB95eXbQiI
 5W5GK87pRE3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2020 03:27:51 -0700
IronPort-SDR: hOMvlG3q9uemsqIiIyDBAUERBnF/Ngt6Ql3kTansnkAtN4CX8H4TvyUgQ666Y4dY7h9X7Zk88M
 fJqSWXnwpCqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; d="scan'208";a="434059070"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.22.155])
 ([10.213.22.155])
 by orsmga005.jf.intel.com with ESMTP; 04 May 2020 03:27:48 -0700
Subject: Re: [PATCH v4] topology: Add topology file for generic HDA DSP
 machine driver
To: perex@perex.cz
References: <20200421202615.4111-1-mateusz.gorski@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <d94ca24a-9f02-51cc-431d-93854dab535e@intel.com>
Date: Mon, 4 May 2020 12:27:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421202615.4111-1-mateusz.gorski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 tiwai@suse.com, Mateusz Gorski <mateusz.gorski@linux.intel.com>
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

On 2020-04-21 22:26, Mateusz Gorski wrote:
> Provide conf file with topology for generic HDA DSP machine
> driver configuration. This topology is meant to be used with Intel
> Skylake SST driver.
> 
> Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
> ---
> 
> Changes in v4:
> - changed get and put enum ops for DMIC paths
> - removed "write" and "read_write" rights for DMIC multi-config enums
> 

Hello Jaroslav,

Kernel patch series:
	[PATCH v6 0/3] Add support for different DMIC configurations

has already been merged by Mark and is now part of Skylake driver. UCM 
and topology patches are still missing though. I didn't find any review 
or issue that has not been addressed. Is there anything else you want us 
to do before merging? Patches have been tested using the exact same 
scope as kernel ones: Intel AVS platforms, RVP and production both.

Czarek
