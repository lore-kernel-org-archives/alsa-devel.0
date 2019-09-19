Return-Path: <SRS0=hSRK=XO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F7C3A5A6
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:46:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D273E217D6
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UTOJwisu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D273E217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79056166F;
	Thu, 19 Sep 2019 16:45:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79056166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568904376;
	bh=sy+cwkvToEG64IuE8lF5Vuz/oyQybXOmf+DW3ft0hXc=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UTOJwisutfcJtlsUzCipmpWnZ3FiJIfI5E7L/nB3PgTE6jf3ZBPbT0f0j0eSwr8Pj
	 +lFmnZi5f5WfU5UTGDSTHjC2U4FZVa7pAm7UUh1vysE8B2GVLNAevhIbdUfzHUmMcX
	 sUJQC4WlYd4ptAg3zc8UtJ8WuDrMzh179uAs1HGM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05AD8F80307;
	Thu, 19 Sep 2019 16:45:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F089F80361; Thu, 19 Sep 2019 16:45:24 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0491AF80146
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2019 16:45:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0491AF80146
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 07:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,523,1559545200"; d="scan'208";a="199415001"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga002.jf.intel.com with ESMTP; 19 Sep 2019 07:45:18 -0700
Received: from pbossart-mac01.local (unknown [10.251.11.91])
 by linux.intel.com (Postfix) with ESMTP id 4553F5802A3;
 Thu, 19 Sep 2019 07:45:18 -0700 (PDT)
To: alsa-devel@alsa-project.org, Mark Pearson <mpearson@lenovo.com>,
 Elimar Riesebieter <riesebie@lxtec.de>
References: <20190919142329.35bsdnh5skuj7jl3@toy.home.lxtec.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <853b3859-8c8e-1c52-becb-3807d351b8f1@linux.intel.com>
Date: Thu, 19 Sep 2019 09:44:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190919142329.35bsdnh5skuj7jl3@toy.home.lxtec.de>
Content-Language: en-US
Subject: Re: [alsa-devel] alsa-lib: Add ucm support for whiskeylake
 sof-skl_hda_card audio
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

On 9/19/19 9:23 AM, Elimar Riesebieter wrote:
> Hi ALSA devs,
> 
> please notice the attached suggestion from Lenovo to support sound
> for whiskeylake sof-skl_hda_card audio.

Indeed UCM is required for all cases where SOF and PulseAudio are used.

Our thinking was however to add this UCM file to the new repository 
outside of alsa-lib [1]. There is an on-going thread started by Jaroslav 
to move those files and relicense them as BSD-3-Clause [2]

[1] 
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-July/153257.html
[2] 
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-September/155246.html
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
