Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4086C33C9E
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:50:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7622524658
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dXZOPdbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7622524658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E18A181D;
	Tue, 14 Jan 2020 18:49:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E18A181D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579024214;
	bh=hBYH7phebKlzxV1wA/cTXlDejkJZLFaB/xcZdxkaYY4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dXZOPdbhrCrZlOoepZfLZ45TZt4z2+jUiYLo1M/mAORUggkoblKo74l9fHvvyOMsj
	 BPPjQgzN7X7TVfJ3IXjTqBltPvBcSuk4tqyfvAtBMeTH86k65jllR9uIVqQxwAzkPB
	 dWEpUYFTWo45gJunCr/sjxQKvHUu9ZnMUubuT0h0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 741D3F8014E;
	Tue, 14 Jan 2020 18:48:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68884F8023E; Tue, 14 Jan 2020 18:48:30 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28B5FF800E9
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2020 18:48:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28B5FF800E9
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 09:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; d="scan'208";a="225285564"
Received: from snathamg-mobl.amr.corp.intel.com (HELO [10.252.136.159])
 ([10.252.136.159])
 by orsmga003.jf.intel.com with ESMTP; 14 Jan 2020 09:48:22 -0800
To: Vinod Koul <vkoul@kernel.org>
References: <20200110220016.30887-1-pierre-louis.bossart@linux.intel.com>
 <a70c54c0-c691-d8eb-4f99-da1bb9306c2f@linux.intel.com>
 <20200114062605.GD2818@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7a2e514c-edd1-fbeb-3ebb-df289c7436e2@linux.intel.com>
Date: Tue, 14 Jan 2020 10:05:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114062605.GD2818@vkoul-mobl>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: intel: report slave_ids for
 each link to SOF driver
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



On 1/14/20 12:26 AM, Vinod Koul wrote:
> On 10-01-20, 16:31, Pierre-Louis Bossart wrote:
>>
>>
>> On 1/10/20 4:00 PM, Pierre-Louis Bossart wrote:
>>> From: Bard Liao <yung-chuan.liao@linux.intel.com>
>>>
>>> The existing link_mask flag is no longer sufficient to detect the
>>> hardware and identify which topology file and a machine driver to load.
>>>
>>> By reporting the slave_ids exposed in ACPI tables, the parent SOF
>>> driver will be able to compare against a set of static configurations.
>>>
>>> This patch only adds the interface change, the functionality is added
>>> in future patches.
>>
>> Vinod, this patch would need to be shared as an immutable tag for Mark, once
>> this is done I can share the SOF parts that make use of the information (cf.
>> https://github.com/thesofproject/linux/pull/1692 for reference)
>>
>> Sorry we missed this in the earlier interface changes, we didn't think we
>> would have so many hardware variations so quickly.
> 
> do you want the tag now..? I can provide... We are already in -rc6
> and i will send PR to greg later this week...

yes please, I'd like to send the SOF patches this week as well.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
