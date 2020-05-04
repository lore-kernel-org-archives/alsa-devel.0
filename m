Return-Path: <SRS0=TVyu=6S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD55C3A5A9
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 10:27:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE8620721
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 10:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gOLPOcCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE8620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D72216DE;
	Mon,  4 May 2020 12:26:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D72216DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588588038;
	bh=bckrmVrOnX+CHszJib1pwJhSmC5YT3JKHHq8cCeK9nk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gOLPOcCuMKgpPL7wsTjOakYpmBbxmPMyp5kKvyXOLsaX1CO/T53dW6NLiQqQDIbSz
	 LQEyq0li0Saim5Qk01EnDc5OOHwXzJyBC7W+Qeub+lhhWIm2eODnNWNpdkog7kYrDB
	 y/2/rbPxgp1EqRBhvSV9ZzXiIEIV7Ve5ncTTwnWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 371F7F80234;
	Mon,  4 May 2020 12:26:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93A91F80249; Mon,  4 May 2020 12:26:26 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8223CF800EE
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2020 12:26:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8223CF800EE
IronPort-SDR: 6ZGsPzfGtyGNsnxbHUREZkX1/WOAdkF9oBWWyyzHz93YGXQYjYaW6dJE1cjL+M5Qe0JsVnQdHA
 cjXnF0DG8JHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2020 03:26:13 -0700
IronPort-SDR: Djk+sPYBUiGDZjqYlj6SV0xQ2cOL4ygUP5vgzTR7nHEdab2lllmuEiWQnOl+6RZzDVnasvGJWi
 D3xNcoeQCtRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; d="scan'208";a="434058533"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.22.155])
 ([10.213.22.155])
 by orsmga005.jf.intel.com with ESMTP; 04 May 2020 03:26:11 -0700
Subject: Re: [PATCH v4] ucm2: hdadsp: add basic ucm config
To: perex@perex.cz
References: <20200318102605.20146-1-mateusz.gorski@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <a19fcc24-b56b-a7ab-346f-239d60b4a9cf@intel.com>
Date: Mon, 4 May 2020 12:26:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318102605.20146-1-mateusz.gorski@linux.intel.com>
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

On 2020-03-18 11:26, Mateusz Gorski wrote:
> Basic UCM configuration for Intel Skylake SST with HDA DSP generic
> machine driver enabling codec playback and capture on both HDA codec
> and DMIC ports.
> 
> Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
> ---
> 
> Changes in v4:
> - adjusted folder and files names to hda-dsp instead of hdadsp
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
