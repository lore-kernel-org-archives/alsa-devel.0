Return-Path: <SRS0=zdUo=3U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8D8C2D0DB
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:08:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B212082E
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CLESFwym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B212082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62867167C;
	Fri, 31 Jan 2020 18:07:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62867167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580490505;
	bh=jFkGPqOqZIjDQwWhmVX2aoRXgqybOP+YPKQzo/nrGhw=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CLESFwymg/O2yGxQaBQyUN+K3Vwolvh4S2tkczMp+dbREIR1EaQM/3nbbi3PWmRcW
	 QtGCxQE44y2ATBN8F7BFUdB3cb1YX0GHIE3d3P7NNrsxUFod540bnVA6CcgLYxiNi8
	 /VWJpxfHaGZEyop0QJtWvbgqFYaD7INmb852JXnU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41F1EF80218;
	Fri, 31 Jan 2020 18:06:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6AD5DF80234; Fri, 31 Jan 2020 18:06:45 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33DA7F80218
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2020 18:06:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33DA7F80218
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 09:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,386,1574150400"; d="scan'208";a="224494509"
Received: from dsankar-mobl.amr.corp.intel.com (HELO [10.252.202.81])
 ([10.252.202.81])
 by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2020 09:06:35 -0800
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200131123115.14247-1-cezary.rojewski@intel.com>
 <20200131123115.14247-10-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <00c94f11-d9a1-fc0b-ec36-6a3845a9a740@linux.intel.com>
Date: Fri, 31 Jan 2020 11:05:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131123115.14247-10-cezary.rojewski@intel.com>
Content-Language: en-US
Cc: vkoul@kernel.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com
Subject: Re: [alsa-devel] [PATCH v4 09/11] ASoC: SOF: Intel: Probe compress
 operations
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



On 1/31/20 6:31 AM, Cezary Rojewski wrote:
> Add HDA handlers for soc_compr_ops and snd_compr_ops which cover probe
> related operations. Implementation supports both connection purposes.
> These merely define stream setups as core flow is covered by SOF
> compress core.
> 
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
> 
> Changes in v4:
> - Reverted SND_SOC_SOF_HDA_LINK requirement-removal change for HDA probes.
>    Code requires SND_HDA_EXT_CORE in order to function on Intel platforms

Since the beginning of SOF our direction has been to only enable the 
HDA_LINK option to support HDMI and HDAudio codecs. Probes are unrelated 
and should work with plain vanilla I2S codecs and even in nocodec mode.

Let's talk on this.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
