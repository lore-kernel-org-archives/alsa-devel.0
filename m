Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC753C54FD0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:31:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77663206B9
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GsEgyKBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77663206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFD7216AF;
	Mon, 27 Apr 2020 15:30:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFD7216AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587994279;
	bh=1aghJssTU/0FYuE/GG+7c9nCU9f9AB5mqxqUYV2fWX4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GsEgyKBBEQT07NWbyOEwftlG/YBiRN4HIzTot2j5ci67Y69/sSOPwM0j+PJpnXgyk
	 IeIU1NOuzQyRGOLfG9WgJg3c8bMaoeVZY5YpDPgwJMVkINm4o3Mynwh2jPfqMAsC02
	 vJ75OllDu0uHC3IdC00+eMW6nOSJFpC0kyMcBa9k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88B39F80217;
	Mon, 27 Apr 2020 15:29:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFE80F802A2; Mon, 27 Apr 2020 15:29:03 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE26EF80112
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 15:28:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE26EF80112
IronPort-SDR: ktxUilmKN2s57/ATLeuaX2kAGgXk3gsKgVSYWtc9F/e6E6aBAJh0C+7wQA/d1wUPPRtv4oTYsd
 +ThNUT4b9RWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 06:28:55 -0700
IronPort-SDR: Lz79dPO+Uh88IFuBn2qWfgee6Z+wky7QeH/2bauSWC1BgCp8DiVIqA+jtWVO5EUqj/Cnw+Gxee
 nevuSFzixKGg==
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; d="scan'208";a="248879010"
Received: from jrluquin-mobl1.amr.corp.intel.com (HELO [10.252.136.187])
 ([10.252.136.187])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 06:28:53 -0700
Subject: Re: [PATCH v5 1/3] ASoC: Intel: Skylake: Add alternative topology
 binary name
To: Mark Brown <broonie@kernel.org>
References: <20200427111520.12076-1-mateusz.gorski@linux.intel.com>
 <20200427111520.12076-2-mateusz.gorski@linux.intel.com>
 <20200427121401.GB4383@sirena.org.uk>
From: "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>
Message-ID: <168e91b4-f091-ac4c-6b62-6d8975fdb99a@linux.intel.com>
Date: Mon, 27 Apr 2020 15:28:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427121401.GB4383@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: pl
Cc: cezary.rojewski@intel.com, alsa-devel@alsa-project.org, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com
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


> On Mon, Apr 27, 2020 at 01:15:18PM +0200, Mateusz Gorski wrote:
>> Add alternative topology binary file name based on used machine driver
>> and fallback to use this name after failed attempt to load topology file
>> with name based on NHLT.
>> This change addresses multiple issues with current mechanism, for
>> example - there are devices without NHLT table, and that currently
>> results in tplg_name being empty.
>>
>> Changes in v2:
>> - added <sound/soc-acpi.h> include
>> - machine driver name is now read from different field
> As covered in submitting-patches.rst the changelog should go after the
> --- so it doesn't end up in the git changelog.


Of course, my bad, pasted these in wrong place.. Thanks for pointing out.

Sending v6,
Mateusz

