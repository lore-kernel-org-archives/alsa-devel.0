Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2028CC2BA19
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:47:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC032098B
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H3+vgQRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC032098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA72E1684;
	Thu, 23 Apr 2020 12:46:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA72E1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587638828;
	bh=u/WpKl3YPbT214r0GRIqUd6AIbVt/welZLu2uZ8r6nk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H3+vgQRE6z59VmUzzriEDOoURlo9SV/YPTYPHRK21ynFqzyC+4pMfC6rNDFJ4G16i
	 2J3uC0lFfWbkihA25UD80spn4j6KjN+fVlrF6BtYbMoW3NGRxvAF6qaOOIuO34ZAKd
	 vRWWYJoEoMHtHO0+58xjXkg/W+tP0DiMhkw98H6s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76551F8014A;
	Thu, 23 Apr 2020 12:46:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D140F801EC; Thu, 23 Apr 2020 12:46:14 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8BCAF800F2
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 12:46:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8BCAF800F2
IronPort-SDR: aZ+pwk3azVc3BQxL0Hr4Xlx5sDsHlehyRJmxS7ChyCbtLUSIEMx6/GElQHv4ippEDjcX+so+8M
 kLCYfhihZP2w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 03:46:08 -0700
IronPort-SDR: wijmJ2ni+uPoQc+wmoyu7LzERXZoKLsp7Qfe+iqfydkBy+yFj93w00DNN21rrGoqlaSgjgVupo
 z4v39d3BPVcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; d="scan'208";a="456863767"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.5.100])
 ([10.213.5.100])
 by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2020 03:46:06 -0700
Subject: Re: [PATCH v2 2/3] ASoC: Intel: Multiple I/O PCM format support for
 pipe
To: Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200422120532.31492-1-mateusz.gorski@linux.intel.com>
 <20200422120532.31492-3-mateusz.gorski@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <3e2a9e70-add2-77d4-58ae-4e64ac92efe4@intel.com>
Date: Thu, 23 Apr 2020 12:46:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422120532.31492-3-mateusz.gorski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Pavan K <pavan.k.s@intel.com>, tiwai@suse.com
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

On 2020-04-22 14:05, Mateusz Gorski wrote:
> For pipes supporting multiple input/output formats, kcontrol is
> created and selection of pipe input and output configuration
> is done based on control set.
> 
> If more than one configuration is supported, then this patch
> allows user to select configuration of choice
> using amixer settings.
> 

> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 58f77b6c5cda..2e6eca619c4e 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -579,6 +579,38 @@ static int skl_tplg_unload_pipe_modules(struct skl_dev *skl,
>   	return ret;
>   }
>   
> +static bool skl_tplg_is_multi_fmt(struct skl_dev *skl, struct skl_pipe *pipe)
> +{
> +	int i;
> +	struct skl_pipe_fmt *cur_fmt;
> +	struct skl_pipe_fmt *next_fmt;
> +

Hmm, some code-cosmetics are left unattended too.
Please reorder 'i' declaration to the bottom.
