Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C9C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:08:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B788620771
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B834Ib4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B788620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A83D16D1;
	Thu,  2 Jul 2020 17:07:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A83D16D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593702493;
	bh=MZaSn20N9vbNlcflGXGLgoIKLp7OhrNAPw6g6sLsCM8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B834Ib4c+v/9qBm1Lqd+xIVjL4h657t0TMbsCxvRUXr7NByyE38urswesa2DGXo3k
	 lfpFWqWgveRQpqaxCya+4TqvnO06P6fSS8JGh26TUMzOZY5T+pWjFUPZnfUlgMGPuU
	 qy6TSXj9sgpy/ny9ZRhN2uOITBu/xgx6stKB1BfI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40163F8022B;
	Thu,  2 Jul 2020 17:07:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36683F8022D; Thu,  2 Jul 2020 17:07:21 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C93A5F800C1
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 17:07:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C93A5F800C1
IronPort-SDR: EkkIaWou8Fpf6WzReWs2AphR+fKHMyU7P3GCA7+qB937al0aNXIZiqZjW69pRQmF4wwqK5/WOU
 qdD+Xns/C2Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148468347"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="148468347"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 08:07:15 -0700
IronPort-SDR: ZR0UMN3WcFHnx0VAwF4wDFeA4aKpHzgbfRNoCOzKpWi6k63NWHrkLP+vYvWr5YYKjerUeXLTrk
 AxkbSClCAPpQ==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="304276958"
Received: from nchava-mobl1.amr.corp.intel.com (HELO [10.252.135.144])
 ([10.252.135.144])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 08:07:14 -0700
Subject: Re: [PATCH 7/7] ASoC: codecs: wm8400: add _maybe_unused as needed
To: Charles Keepax <ckeepax@opensource.cirrus.com>
References: <20200701181320.80848-1-pierre-louis.bossart@linux.intel.com>
 <20200701181320.80848-8-pierre-louis.bossart@linux.intel.com>
 <20200702092318.GL71940@ediswmail.ad.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3c2c9d10-0d7d-2447-01a6-3cf04836c34c@linux.intel.com>
Date: Thu, 2 Jul 2020 10:07:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702092318.GL71940@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
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



On 7/2/20 4:23 AM, Charles Keepax wrote:
> On Wed, Jul 01, 2020 at 01:13:20PM -0500, Pierre-Louis Bossart wrote:
>> Fix W=1 warning by adding __maybe_unused. Maintainers for this file
>> may want to double-check if those definitions are necessary.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
> 
> Yeah I think in this case better to remove them, they arn't used
> in the driver, the driver is pretty old and no one really works
> on it so little chance the features are ever getting added.

Thanks Charles, I can resend a v2 series with your Acked-by and remove 
these definitions.

Out of curiosity, who can check the patch 1 and 2 (cs4270 / cs42l42)?
