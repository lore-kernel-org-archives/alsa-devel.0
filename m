Return-Path: <SRS0=QzCZ=YH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91749C4CECE
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:03:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9224121835
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bU0V3rA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9224121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CD04850;
	Mon, 14 Oct 2019 18:02:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CD04850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571069010;
	bh=fmVcsMlVqbXPHErY33L8ShWUBjyMhDQ1WFK/S51ySog=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bU0V3rA8/mL8S/+h86eOUgqum1kCUxVY0NTzNENMv8YnV2Ks6w4cEMSl38i3jFo7D
	 s6Oe0yfs9HkO83iUCjEK7lMVA4duqz3zuAY6mU+ieHyxjJHQyHrCqfCER618JOq5yL
	 0O91b2C9IUmDt1ce9Y8PolXoXM3EQNLZDD57Ea6o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B120F80322;
	Mon, 14 Oct 2019 18:02:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54608F80138; Mon, 14 Oct 2019 18:02:36 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 324B4F80138
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2019 18:02:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 324B4F80138
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Oct 2019 09:02:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; d="scan'208";a="199439424"
Received: from rtnitta-mobl1.amr.corp.intel.com (HELO [10.251.134.135])
 ([10.251.134.135])
 by orsmga006.jf.intel.com with ESMTP; 14 Oct 2019 09:02:28 -0700
To: alsa-devel@alsa-project.org
References: <20190916185739.32184-1-pierre-louis.bossart@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <779f012b-4994-09c5-5944-164cd053a724@linux.intel.com>
Date: Mon, 14 Oct 2019 10:59:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190916185739.32184-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 0/2] soundwire: Kconfig/build improvements
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



On 9/16/19 1:57 PM, Pierre-Louis Bossart wrote:
> The Intel kbuild test reported issues with COMPILE_TEST or
> cross-compilation when SOF is enabled, fix. This has no functional
> impact.

Vinod, if you are back at your desk, those patches are almost a month 
old. thanks!

> 
> Pierre-Louis Bossart (2):
>    soundwire: intel: add missing headers for cross-compilation
>    soundwire: intel: remove X86 dependency
> 
>   drivers/soundwire/Kconfig      | 2 +-
>   drivers/soundwire/intel.c      | 1 +
>   drivers/soundwire/intel_init.c | 1 +
>   3 files changed, 3 insertions(+), 1 deletion(-)
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
