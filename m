Return-Path: <SRS0=j9WI=Y4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CD7CA9ED4
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2019 21:59:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D659321E6F
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2019 21:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GLo+bIye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D659321E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 190A11730;
	Mon,  4 Nov 2019 22:58:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 190A11730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572904780;
	bh=gXVzpFb7SSYT7pE9KpUFSZt4WrgCCGAYmlaDbRLPAxk=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GLo+bIyecMWejDabD9ULU03SbYOQv62UeV/V/DcF360kgVnJFIrOjZHu3Tf1eSZyR
	 6J6ZWaJ8A5XnM74MgJndPIQVOxHmqxx8w0QP1GuSZ5KtZWlfehzpF1N0JCAYx+IvIK
	 5ABH36vz8FRQrtnqpMTLzEFuEhpgb4Ep+2XbeCWI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F3D3F80636;
	Mon,  4 Nov 2019 22:56:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10CA7F80637; Mon,  4 Nov 2019 22:56:33 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C5AAF8019B
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2019 22:56:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C5AAF8019B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Nov 2019 13:56:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; d="scan'208";a="226888820"
Received: from trowland-mobl.amr.corp.intel.com (HELO [10.254.97.182])
 ([10.254.97.182])
 by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2019 13:56:08 -0800
To: Cezary Rojewski <cezary.rojewski@intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-11-pierre-louis.bossart@linux.intel.com>
 <7a49fcce-5b36-81c1-6041-dda263ebb200@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <02ef59ba-66da-3ba9-1fe7-0b7e256e3ac1@linux.intel.com>
Date: Mon, 4 Nov 2019 15:31:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7a49fcce-5b36-81c1-6041-dda263ebb200@intel.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 10/14] soundwire: intel: add prepare
 support in sdw dai driver
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



On 11/4/19 1:45 PM, Cezary Rojewski wrote:
> On 2019-10-23 23:28, Pierre-Louis Bossart wrote:
>> From: Rander Wang <rander.wang@linux.intel.com>
>>
>> It gets sdw runtime information from dai to prepare stream.
>>
>> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
> 
> While the patch looks good, the commit message is questionable. You may 
> simply state why it is added only just now. Judging from the commit 
> title, it has been added to make the sdw dai driver interface complete.

The commit message is not great but it's not wrong either...
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
