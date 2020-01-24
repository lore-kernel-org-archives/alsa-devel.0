Return-Path: <SRS0=dQ5X=3N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0482C2D0DB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:26:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641532072C
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R3njMgda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641532072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBD98169C;
	Fri, 24 Jan 2020 21:26:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBD98169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579897616;
	bh=M0rbJProgXqVH00GQmj45zQw1PTh/k+1izWyDxCDpiU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R3njMgdaTAJ1UQ/aOkq1sgXFVZ/cKZYR0/jqI6ExeYG3FIIA4AlIyFR6dp4GhsGyJ
	 yzakgrElV2VzttMrtH3WmPkXugoTHoKZj/GTBOVXSrZpOXD6R1N0cHBeRKORKFrR7w
	 QzrZmUAYFMG+IADeQce+wuwnz2YXmOSX5ZIWiBWI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A1E2F8027B;
	Fri, 24 Jan 2020 21:24:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F771F80272; Fri, 24 Jan 2020 21:24:18 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A38DF801D8
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2020 21:24:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A38DF801D8
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jan 2020 12:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; d="scan'208";a="400759969"
Received: from iifeduba-mobl1.amr.corp.intel.com (HELO [10.254.110.26])
 ([10.254.110.26])
 by orsmga005.jf.intel.com with ESMTP; 24 Jan 2020 12:24:09 -0800
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200124190413.18154-1-cezary.rojewski@intel.com>
 <20200124190413.18154-9-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d74dc038-78fa-b81c-5014-6ed3668641b1@linux.intel.com>
Date: Fri, 24 Jan 2020 14:00:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124190413.18154-9-cezary.rojewski@intel.com>
Content-Language: en-US
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH 08/12] ASoC: SOF: Generic probe compress
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


> +int sof_probe_compr_open(struct snd_compr_stream *cstream,
> +		struct snd_soc_dai *dai)
> +{
> +	struct snd_sof_dev *sdev =
> +				snd_soc_component_get_drvdata(dai->component);
> +	int ret;
> +
> +	ret = snd_sof_probe_compr_assign(sdev, cstream, dai);
> +	if (ret < 0) {
> +		dev_err(dai->dev, "Failed to assign probe stream: %d\n", ret);
> +		return ret;
> +	}
> +
> +	sdev->extractor = ret;

could you either rename the 'extractor' field to something meaningful or 
add a comment on what is stored in this field? A stream tag? a device 
number? It's only used once for the init.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
