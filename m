Return-Path: <SRS0=bmHO=2G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CEDC43603
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:35:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13A4206E0
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DGOafyh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13A4206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8543850;
	Mon, 16 Dec 2019 23:34:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8543850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576535731;
	bh=Wxvw5o7pg8w04xZLGxH4jDCIj3GOw9SucIUCA+K52TI=;
	h=From:To:References:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DGOafyh3e+cTZkNUbAlJZymufGzJitCB678tBNNAs5JVVeMZZP3Wtiz+Bh2dQpeua
	 m0/e4pA0Sb+PWXJUH+87vjoZnLLcvaMEyCF6qFLFk/FHijPqm7tEdksy0nyCkcXg3k
	 hSngLDDZTtnN5/RFhTGdl2QFFr70jXmG4qmgTu80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36B38F8014F;
	Mon, 16 Dec 2019 23:34:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81059F80255; Mon, 16 Dec 2019 23:34:39 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1C76F800AD
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2019 23:34:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1C76F800AD
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 14:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; d="scan'208";a="365172648"
Received: from andresma-mobl.amr.corp.intel.com (HELO [10.252.132.232])
 ([10.252.132.232])
 by orsmga004.jf.intel.com with ESMTP; 16 Dec 2019 14:34:29 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
 <20191213072844.GF1750354@kroah.com>
 <7431d8cf-4a09-42af-14f5-01ab3b15b47b@linux.intel.com>
 <20191213161046.GA2653074@kroah.com>
 <a838eed1-9d55-d1b4-c790-22bdd0a97370@linux.intel.com>
Message-ID: <a4e918c3-8d5c-9f89-903e-a34707cb6f0e@linux.intel.com>
Date: Mon, 16 Dec 2019 16:34:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a838eed1-9d55-d1b4-c790-22bdd0a97370@linux.intel.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 08/15] soundwire: add initial
 definitions for sdw_master_device
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


>> No, I mean the new MODULE_NAMESPACE() support that is in the kernel.
>> I'll move the greybus code to use it too, but when you are adding new
>> apis, it just makes sense to use it then as well.
> 
> ok, thanks for the pointer, will look into this.

This namespace check already saved me a lot of time. I found an issue in 
our latest code (not submitted for review yet) with a new functionality 
added to the wrong module and without the proper abstraction required...
Really nice tool, I can already see how useful it will be for on-going 
code partitioning (SOF multi-client work and virtualization support).
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
