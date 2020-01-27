Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B69CC2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 21:23:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B4024679
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 21:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uaEfdhTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B4024679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C60DE83D;
	Mon, 27 Jan 2020 22:22:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C60DE83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580160179;
	bh=RIkX7c+zKH+M7BXg4Yt7VJSP5lxbsR+UdXMBZMQzv8c=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uaEfdhTLLwe3+QENhEHZhMZhMfRJUoxEurD0dYrlsNRYb0wgZNGtdNvQNHljBZkIy
	 HFVAKa+BWWEjmMEpDFuTFZgJ+7B91t6WhakbcqT4uiasnAaqD4B3r2W1HYVRbUUb/v
	 RCO3BnVSMUM+FSl2cB3qeD0XPRY9zN92PmLVk7qA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAB44F8021E;
	Mon, 27 Jan 2020 22:21:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17374F80259; Mon, 27 Jan 2020 22:21:20 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19F26F80082
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 22:21:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19F26F80082
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jan 2020 13:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,371,1574150400"; d="scan'208";a="231649951"
Received: from ngstahl-mobl1.amr.corp.intel.com (HELO [10.254.190.105])
 ([10.254.190.105])
 by orsmga006.jf.intel.com with ESMTP; 27 Jan 2020 13:21:08 -0800
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200127121243.15813-1-cezary.rojewski@intel.com>
 <20200127121243.15813-8-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ba250355-73bc-bdf0-15b1-362b0147a4bd@linux.intel.com>
Date: Mon, 27 Jan 2020 15:09:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127121243.15813-8-cezary.rojewski@intel.com>
Content-Language: en-US
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com
Subject: Re: [alsa-devel] [PATCH v2 07/11] ASoC: SOF: Implement Probe IPC API
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



On 1/27/20 6:12 AM, Cezary Rojewski wrote:
> Add all required types and methods to support each and every request
> that driver could sent to firmware. Probe is one of SOF firmware
> features which allows for data extraction and injection directly from
> or to DMA stream.
> 
> Exposes eight IPCs:
> - addition and removal of injection DMAs
> - addition and removal of probe points
> - info retrieval of injection DMAs and probe points
> - probe initialization and cleanup
> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

You also want to fix the kernel-doc issues reported with make W=1

sound/soc/sof/probe.c:29: warning: Function parameter or member
'stream_tag' not described in 'sof_ipc_probe_init'

sound/soc/sof/probe.c:266: warning: Function parameter or member
'buffer_id' not described in 'sof_ipc_probe_points_remove'

sound/soc/sof/probe.c:266: warning: Function parameter or member
'num_buffer_id' not described in 'sof_ipc_probe_points_remove'

sound/soc/sof/probe.c:266: warning: Excess function parameter
'desc' description in 'sof_ipc_probe_points_remove'

sound/soc/sof/probe.c:266: warning: Excess function parameter
'num_desc' description in 'sof_ipc_probe_points_remove'

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
