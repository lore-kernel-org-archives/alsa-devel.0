Return-Path: <SRS0=j9WI=Y4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F4BCA9ED4
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2019 21:58:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5229721929
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2019 21:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IKArxNDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5229721929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 853A51728;
	Mon,  4 Nov 2019 22:57:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 853A51728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572904729;
	bh=EJHbGCsyfhD5IXpDRmU2SSp9wqPYzNAE8N6lyg0QWp8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IKArxNDHW1SyDOzHCe7VdptKq7tDFCaJfudmsfeoiwuYSwee2OgsPv7vsOzOiO7Lm
	 m/uydOy/Fn3NaIEAttmtp/iWZ7NWvXQOU/aFgptIoib97VaMvDQ+EOjLgKYJhQ2tek
	 S53AYnqzx4X58M0yLXfUNsqbOe293IpvoZQxRoBg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 165F5F80600;
	Mon,  4 Nov 2019 22:56:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8865EF805E2; Mon,  4 Nov 2019 22:56:24 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA055F804FE
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2019 22:56:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA055F804FE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Nov 2019 13:56:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; d="scan'208";a="226888863"
Received: from trowland-mobl.amr.corp.intel.com (HELO [10.254.97.182])
 ([10.254.97.182])
 by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2019 13:56:17 -0800
To: Cezary Rojewski <cezary.rojewski@intel.com>
References: <20191101173045.27099-1-pierre-louis.bossart@linux.intel.com>
 <20191101173045.27099-4-pierre-louis.bossart@linux.intel.com>
 <123e11ae-d22c-a54e-283f-a3b4e002c0c7@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5930ecb1-5651-abd7-d031-a010f788100e@linux.intel.com>
Date: Mon, 4 Nov 2019 15:52:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <123e11ae-d22c-a54e-283f-a3b4e002c0c7@intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH 03/11] ASoC: Intel: add mutual exclusion
 between SOF and legacy Baytrail driver
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 11/4/19 2:18 PM, Cezary Rojewski wrote:
> On 2019-11-01 18:30, Pierre-Louis Bossart wrote:
>> This legacy driver is already deprecated, let's make sure there is no
>> conflict with SOF.
>>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
> 
> Pierre, with SOF replacing /atom and /baytrail for BYT platforms, is 
> /baytrail (legacy) used on any of the setups officially? While @ IGK I'm 
> playing with anything from HSW up to TGL and above, /baytrail gets 
> skipped entirely, even here.

The legacy Baytrail driver is still used by Baytrail Chromebooks, and 
that choice is not something we control. If Google transition to SOF for 
Baytrail, then we can remove this driver altogether.
The Atom Baytrail driver is enabled by default (default ACPI). Only when 
we have support for Baytrail-CR can we deprecate Baytrail/Atom.
Does this answer to your question?
-Pierre
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
