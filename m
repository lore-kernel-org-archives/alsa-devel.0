Return-Path: <SRS0=9b6r=YW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E67ACA9EAE
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 14:32:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1C120679
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 14:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hksm4hz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1C120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA61D20D7;
	Tue, 29 Oct 2019 15:31:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA61D20D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572359526;
	bh=W9KrafElgJwt+P8+AE+mpnfTFrCZzIBDtt7MtMVh7nI=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hksm4hz9hgS7FV3IhvvvwKbuq/lEiR5hrsgmST2Trxb/fFFLWJPkhUlUAeOTaUGAq
	 +aRZc/Ivy/0oOhlrRBwth22TWMKjoDizBqlsSnOHHaMT5rh+Pza23RV5tJXa7Svo4i
	 Oo1zVYc/uvWjmvg7CcqISiv5Srl7MKv72RtLQcOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85BF8F805FD;
	Tue, 29 Oct 2019 15:21:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA339F80534; Tue, 29 Oct 2019 15:21:26 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB71EF8044B
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 15:21:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB71EF8044B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Oct 2019 07:21:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400"; d="scan'208";a="193618826"
Received: from vtungala-mobl3.amr.corp.intel.com (HELO [10.254.109.225])
 ([10.254.109.225])
 by orsmga008.jf.intel.com with ESMTP; 29 Oct 2019 07:21:19 -0700
To: Cezary Rojewski <cezary.rojewski@intel.com>
References: <20191025224122.7718-1-pierre-louis.bossart@linux.intel.com>
 <20191025224122.7718-9-pierre-louis.bossart@linux.intel.com>
 <75fa1574-c5c4-595c-182c-fd6e509be348@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fe6cbc40-9865-ff42-214c-22d62ff2e5ba@linux.intel.com>
Date: Tue, 29 Oct 2019 09:13:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <75fa1574-c5c4-595c-182c-fd6e509be348@intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
 Keyon Jie <yang.jie@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 08/26] ASoC: SOF: token: add tokens for PCM
 compatible with D0i3 substate
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



On 10/29/19 5:11 AM, Cezary Rojewski wrote:
> On 2019-10-26 00:41, Pierre-Louis Bossart wrote:
>> From: Keyon Jie <yang.jie@linux.intel.com>
>>
>> Add stream token SOF_TKN_STREAM_PLAYBACK_COMPATIBLE_D0I3 and
>> SOF_TKN_STREAM_CAPTURE_COMPATIBLE_D0I3 to denote if the stream can be
>> opened at low power d0i3 status or not.
>>
>> Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
> 
> By any chance, can stream be playback D0ix incompatible but capture D0ix 
> compatible? Single token would suffice, no?

we discussed this on github. If we generalize this to low-power 
streaming, it's possible to have a case where the buffering is not 
suitable on capture but suitable on playback, or vice-versa, so we added 
two tokens.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
