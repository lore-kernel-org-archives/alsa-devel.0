Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6739BC54FD0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:15:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58E920575
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VrUidyT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58E920575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C49F74C;
	Mon, 27 Apr 2020 13:15:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C49F74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587986153;
	bh=C+DSSJMEvfKvba8+hgGRm70EsIX/y1y3VOSJUEiv1Dc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VrUidyT8CotLY0m4CNVBi6Zpdi1QbbWvOEN4L9LOf2fmekSHdxkTGVBF7pXROauHE
	 XELibSNLuS/zLSHCYhowGHN1Bl/e4vi4LWnffaeN0PKs2CLvVcEM94VmDtdP6RFOVR
	 DcY1CBQwSJu5FJnx3hX6CBea1hjNpRPDUf/xOLK4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02D6DF8010A;
	Mon, 27 Apr 2020 13:15:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D06B6F8022B; Mon, 27 Apr 2020 13:14:59 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EFC4F8010A
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 13:14:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EFC4F8010A
IronPort-SDR: 4KV9gbClMolpHY5+1T6Czi7N295NDV2KMv7HViQdi6aRb9+t6rh5K772dVSGGTM48aBZ0Qef4S
 xCw0wnu0BGwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 04:14:53 -0700
IronPort-SDR: /PtLdhwd9OuLG59TZ3F2ZR6UL+OduJVaHBWYbaorADvlnIaroXBTxdZ+oMu6nta7nYAIJruVyT
 muip1dYUf8Hw==
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; d="scan'208";a="247384560"
Received: from mgorski-mobl.ger.corp.intel.com (HELO [10.135.60.246])
 ([10.135.60.246])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 04:14:51 -0700
Subject: Re: [PATCH v4 0/3] Add support for different DMIC configurations
To: Mark Brown <broonie@kernel.org>
References: <20200424132002.3850-1-mateusz.gorski@linux.intel.com>
 <20200424145236.GG5850@sirena.org.uk>
From: "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>
Message-ID: <24bdfe47-104b-e87a-db97-ce0dccdb0662@linux.intel.com>
Date: Mon, 27 Apr 2020 13:14:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424145236.GG5850@sirena.org.uk>
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


>> Set of patches to enable DMIC capture on different hardware
>> configurations.
> Neither this posting nor the last posting seem to have managed to send
> me a copy of patch 2.


The only reason I can think of is the fact, that one of Signed-by tags 
in patch 2/3 had a comma in it and git send-patch added one additional, 
invalid CC recipient.

I have adjusted that Signed-by tag in patchset v5.


Mateusz

