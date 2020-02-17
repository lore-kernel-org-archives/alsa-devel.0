Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A7C35242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 04:09:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0B520717
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 04:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vd2riE3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0B520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F21BA83D;
	Mon, 17 Feb 2020 05:08:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F21BA83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581912563;
	bh=TrBuMzcvzI3BHplaLIhZMiGCuWCZ93MOjIsybB+v7wY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vd2riE3hZgCah7jQnA9b+236osHR8sF1V+81ba2Ss9cx/CYAmxGaZ3VetSJouKoF9
	 SflG/tS3nyi1ZSWXN4VNaOrOOkAbnGLL//Rj+9+fex0OrFzDZqD9OyEAsTRZbve7dr
	 XYxQMJmsJh/xSpXBxRqiriH+TCf9ZHYKSe3YVz2g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70CEFF8015E;
	Mon, 17 Feb 2020 05:08:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3E5BF80172; Mon, 17 Feb 2020 05:08:28 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9E1CF800C4
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 05:08:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9E1CF800C4
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Feb 2020 20:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,451,1574150400"; d="scan'208";a="258141212"
Received: from unknown (HELO buildpc-HP-Z230) ([10.223.89.131])
 by fmsmga004.fm.intel.com with ESMTP; 16 Feb 2020 20:08:13 -0800
Date: Mon, 17 Feb 2020 09:39:21 +0530
From: Sanyog Kale <sanyog.r.kale@intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20200217040921.GA19766@buildpc-HP-Z230>
References: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3 0/5] soundwire: intel: add DAI callbacks
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Feb 14, 2020 at 07:47:35PM -0600, Pierre-Louis Bossart wrote:
> The existing mainline code is missing most of the DAI callbacks needed
> for a functional implementation, and the existing ones need to be
> modified to provide the relevant information to ASoC/SOF drivers.
> 
> As suggested by Vinod, these patches are shared first - with the risk
> that they are separated from the actual DAI enablement, so reviewers
> might wonder why they are needed in the first place.
> 
> For reference, the complete set of 90+ patches required for SoundWire
> on Intel platforms is available here:
> 
> https://github.com/thesofproject/linux/pull/1692
> 
> Changes since v2:
> Add missing kfree for stream name (feedback from Vinod)
> 
> changes since v1:
> Fix string allocation (only feedback from Vinod)
> 
> Pierre-Louis Bossart (2):
>   soundwire: intel: rename res field as link_res
>   soundwire: intel: free all resources on hw_free()
> 
> Rander Wang (3):
>   soundwire: intel: add prepare support in sdw dai driver
>   soundwire: intel: add trigger support in sdw dai driver
>   soundwire: intel: add sdw_stream_setup helper for .startup callback
> 
>  drivers/soundwire/intel.c | 198 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 178 insertions(+), 20 deletions(-)
> 

Acked-by: Sanyog Kale <sanyog.r.kale@intel.com>

Thanks,
Sanyog

> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
