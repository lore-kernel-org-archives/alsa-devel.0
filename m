Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3354C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:41:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30922208E4
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Iyb2lggK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30922208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E4261727;
	Wed, 26 Aug 2020 16:40:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E4261727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598452886;
	bh=9zKiGE/aYnuWFq4e2JSkdXss2oKilznYIzi6e79sYsM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iyb2lggKIyMUR2AqVIqyAIbdSiEMMqpdYZJMbcyNA9ZZHV1G3UkGPiVvqV777XYw9
	 MmGFgWLBtpaFiLJJnHZNF2TryI0jnV/nIqC8dXgdCedd1V1jBDIdnxnPabU6i0FCDh
	 yr43JnV+iphvhdNdMeYdj6gbghas04QqNmrp++Gg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E31AFF8016F;
	Wed, 26 Aug 2020 16:40:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1938DF801EC; Wed, 26 Aug 2020 16:40:33 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB942F80105
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 16:40:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB942F80105
IronPort-SDR: eYwisir8b6Tcv4kecRklCc1W2HvgrfYf2fnmqXUEJ4/+1TvaJn1GANGQuuifxUIJy1JsAWPHLd
 aWLQSCNcSnEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135849031"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="135849031"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 07:40:20 -0700
IronPort-SDR: uwrE/m7OJxY2wgP0ERnHQlSOIMq0Fak51rD/ut8OuryPrAsM34MBNqt2K0CCynweGLzV4+3tDo
 T5go1EsNN8Cw==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; d="scan'208";a="299494855"
Received: from gillelas-mobl1.amr.corp.intel.com (HELO [10.255.231.51])
 ([10.255.231.51])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 07:40:18 -0700
Subject: Re: [PATCH 05/11] soundwire: bus: update multi-link definition with
 hw sync details
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-6-yung-chuan.liao@linux.intel.com>
 <20200826094420.GA2639@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d534afc3-3c38-275e-2f62-0432ffd91a36@linux.intel.com>
Date: Wed, 26 Aug 2020 09:09:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826094420.GA2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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



>> + * @hw_sync_min_links: Number of links used by a stream above which
>> + * hardware-based synchronization is required. This value is only
>> + * meaningful if multi_link is set. If set to 1, hardware-based
>> + * synchronization will be used even if a stream only uses a single
>> + * SoundWire segment.
> 
> Soundwire spec does not say anything about multi-link so this is left to
> implementer. Assuming that value of 1 would mean hw based sync will
> be used even for single stream does not make sense in generic terms.
> Maybe yes for Intel but may not be true for everyone?

hw-based sync is required for Intel even for single stream. It's been 
part of the recommended programming flows since the beginning but 
ignored so far.

That said, this value is set by each master implementation, no one 
forces non-Intel users to implement an Intel-specific requirement.

> We already use m_rt_count in code for this, so the question is why is
> that not sufficient?

Because as you rightly said above, Intel requires the hw_sync to be used 
even for single stream, but we didn't want others to be forced to use 
the hw-sync for single stream. the m_rt_count is not sufficient for Intel.

I think we are in agreement on not forcing everyone to follow what is 
required by Intel, and that's precisely why we added this setting. If 
you set it to two you would only use hw_sync when two masters are used.
