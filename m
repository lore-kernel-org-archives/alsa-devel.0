Return-Path: <SRS0=J9ZO=6P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03815C47253
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 15:19:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834C920708
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 15:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OHWLYcCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834C920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D896D169B;
	Fri,  1 May 2020 17:18:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D896D169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588346348;
	bh=xT08XPw8plO+r+63ijCkvoeFGEV8iywlwxKi3f8T6KE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OHWLYcCcjD8O//v9rHvq+lisy54sgEID9oMWNEBsI5JH1XmCrZz1pRWdVsJBYS7fd
	 xNJGFIGLJ1TdzZ/OEt/VkySl2m1meDdolEF8LkO+Yu1hms48zsocaUeThf8zRo5o8f
	 X1I4ZEnJ7hCPHnIxGVPogtLyPA1iN1yuneI4RQ5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70D4BF80232;
	Fri,  1 May 2020 17:18:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A63C9F80245; Fri,  1 May 2020 17:18:16 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FA1AF800B6
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2020 17:18:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FA1AF800B6
IronPort-SDR: 8giOim9vMsxOxm7D5GnVcmYWWLq5Bip87MbeyHkVsFQIEIN/5zPQB39CUiFvNayurV/daAy/0X
 UkbgzcskTOxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2020 08:18:06 -0700
IronPort-SDR: G6sez57Sd23OlT1+5nLaWjH6hYM4GEfoJABx8Ni7dwSTLcPiHilm/Ig2OTHJzA+gmi/EzLSiQc
 c2fYaywmT6Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,339,1583222400"; d="scan'208";a="276847916"
Received: from srodrig5-mobl2.amr.corp.intel.com (HELO [10.254.111.158])
 ([10.254.111.158])
 by orsmga002.jf.intel.com with ESMTP; 01 May 2020 08:18:05 -0700
Subject: Re: [PATCH] ASoC: Intel: boards: sof-wm8804: support for Hifiberry
 Digiplus boards
To: Mark Brown <broonie@kernel.org>
References: <20200501150611.15395-1-pierre-louis.bossart@linux.intel.com>
 <20200501150949.GE5276@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ffd0e3a2-6a9b-e5aa-c133-916a3a01acee@linux.intel.com>
Date: Fri, 1 May 2020 10:18:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501150949.GE5276@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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



On 5/1/20 10:09 AM, Mark Brown wrote:
> On Fri, May 01, 2020 at 10:06:11AM -0500, Pierre-Louis Bossart wrote:
> 
>> @@ -0,0 +1,298 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) 2018-2020, Intel Corporation
>> +/*
>> + * sof-wm8804.c - ASoC machine driver for Up and Up2 board
> 
> Please make the entire comment a C++ one so things look clearer.

right, I keep forgetting about this and we mechanically use the old 
style by copy/pasting. Will make sure the new machine drivers use C++ 
comments. v2 sent.
