Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3E6C54FCB
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:32:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F9C20767
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JyFvjUPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F9C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9930816A8;
	Thu, 23 Apr 2020 18:31:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9930816A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587659564;
	bh=s15aixBtz3ZLxbIPilw9PjKMzGyyZQZ8xazVIoyA7gk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JyFvjUPb21igSlEJLwxj9mbNBX5jOIW2a6Fdbqma1XG1AniL7v1pdaMOP/Vc1A3R3
	 4VOp9JdHAevyXlkZtTZXY7UIddAh+32izDwo94rrAF3E8+ZxwY0za0T5rFKRe3+yYC
	 Y6dEuxlvP5UzHKr+pWIzSjszu0MXebvCfg3J9mPk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A8DAF80279;
	Thu, 23 Apr 2020 18:30:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0429F801F5; Thu, 23 Apr 2020 18:30:12 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC60BF801EC
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 18:30:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC60BF801EC
IronPort-SDR: 0y51wM/QmgAESmQvGNzv/euWMrtzZBKGV4pHfv65lM298kak2crYWYlue1UMPD/w/6BVNjyJxr
 +cZPVZB+heCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 09:30:08 -0700
IronPort-SDR: sjeTWS7Qo94Jbd7VH8lm1lcxAbtTMy2N6DOHgqN2aenEId5C6zjwffLBwGRAXsbG+hcIuXVdX5
 kyHPMUbnkWiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; d="scan'208";a="256040297"
Received: from lsatpatx-mobl.gar.corp.intel.com (HELO [10.251.150.156])
 ([10.251.150.156])
 by orsmga003.jf.intel.com with ESMTP; 23 Apr 2020 09:30:07 -0700
Subject: Re: [PATCH v3 0/3] Add support for different DMIC configurations
To: Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200423111148.6977-1-mateusz.gorski@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <703d14ad-6a79-a05c-5b79-dd2de991fe14@linux.intel.com>
Date: Thu, 23 Apr 2020 10:56:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423111148.6977-1-mateusz.gorski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, broonie@kernel.org, tiwai@suse.com
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



On 4/23/20 6:11 AM, Mateusz Gorski wrote:
> Set of patches to enable DMIC capture on different hardware
> configurations.
> Information about supported DMIC configuration is read from NHLT and
> correct pipeline configuration is selected automatically.
> Also, adding additional option for topology binary name which is
> based on used machine driver.
> 
> Changes in v2:
> - removed patch 1/4 swapping machine device and platform device
>    registration order
> - alt_tplg_name creation now uses different field to read machine driver
>    name
> - including of <sound/soc-acpi.h> moved to different patch
> 
> Changes in v3:
> - cosmetic changes in skl-topology.c file

I suggested a couple of improvements/nit-picks but the code looks good 
to me already so:

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Mateusz Gorski (3):
>    ASoC: Intel: Skylake: Add alternative topology binary name
>    ASoC: Intel: Multiple I/O PCM format support for pipe
>    ASoC: Intel: Skylake: Automatic DMIC format configuration according to
>      information from NHLT
> 
>   include/uapi/sound/skl-tplg-interface.h |   2 +
>   sound/soc/intel/skylake/skl-topology.c  | 188 +++++++++++++++++++++++-
>   sound/soc/intel/skylake/skl-topology.h  |   1 +
>   3 files changed, 186 insertions(+), 5 deletions(-)
> 
