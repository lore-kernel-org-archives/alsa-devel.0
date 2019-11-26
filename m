Return-Path: <SRS0=RV9o=ZS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5515AC432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:36:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C6820727
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iSrqvr3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C6820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 117B8171B;
	Tue, 26 Nov 2019 23:35:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 117B8171B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574807782;
	bh=TZKYhE+wtiFqii8g9WBElxg7s9vWe5tFTQyYyCd1IJ8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iSrqvr3brVjs9WbtZag5+jIJX/cdpV9p5d3+obRjcTVGJpTEDEbQKtn6q++WCFCOQ
	 jfAuhcA3Z3VB/6mNXqcLPPWAXlPAR9oBufsnkbNEX9JTMyy+fie1aqtTffPO1POGg6
	 rhTO+4qs8OZLhOVrLVPvC1x8niIG4pQb4+fZeyWE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FF93F80149;
	Tue, 26 Nov 2019 23:35:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEEEDF80159; Tue, 26 Nov 2019 23:35:25 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CEE90F800DD;
 Tue, 26 Nov 2019 23:35:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CEE90F800DD
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 14:35:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,247,1571727600"; d="scan'208";a="291869723"
Received: from purnend1-mobl.amr.corp.intel.com (HELO [10.251.132.250])
 ([10.251.132.250])
 by orsmga001.jf.intel.com with ESMTP; 26 Nov 2019 14:35:15 -0800
To: Daniel Baluta <daniel.baluta@gmail.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
References: <CAEnQRZBsmz17JGdxT_bB_tDHsmWskdXCW47R5wf5dhEw=Jpu-g@mail.gmail.com>
 <6a508a6f957b13a2ccb71c1c91316a272fb38b3a.camel@linux.intel.com>
 <CAEnQRZCia2s-UxoqO4mYuS=4PEY_2Cjsq9prKfmmOAwguV1DEA@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f4dfe1d9-c7f7-0320-2367-e53714516816@linux.intel.com>
Date: Tue, 26 Nov 2019 16:35:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCia2s-UxoqO4mYuS=4PEY_2Cjsq9prKfmmOAwguV1DEA@mail.gmail.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, sof@nxp.com,
 sound-open-firmware@alsa-project.org
Subject: Re: [alsa-devel] Converting a non BE to BE inside soc_check_tplg_fes
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


> Can someone at Intel test following machine drivers for SOF:
> 
> sound/soc/intel/boards/byt-max98090.c
> sound/soc/intel/boards/byt-rt5640.c
> 
> I would expect them not to work for SOF case.

these machine drivers are not supported with SOF.
We have better ones (chtmax98090_ti.c and bytcr_rt5640.c)
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
