Return-Path: <SRS0=sUwr=AH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00816C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:02:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEEF206E9
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u5kAB0tY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEEF206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F35711688;
	Fri, 26 Jun 2020 17:01:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F35711688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593183729;
	bh=FvXpMZmcv6a4qx/4LBTuVv7xienzG9Os6eAHeMshWlc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u5kAB0tYhjCtzEGSjxyikwhxi3tUiF4odskNBqGwMIoSH5AqqFEFwgfS/jnre9DcE
	 uh4DrfwJR0HBfTXDtaeLpCbcVYRVh9s6gcX+y/niFSejAf0Y3dpO/+bT48qJZde0Xs
	 4yj+4rnHmKjDufP+fK0UFIN6aC2zhIiX/ryW2qTo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A1D8F801DB;
	Fri, 26 Jun 2020 17:00:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7EBFF8015A; Fri, 26 Jun 2020 17:00:24 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5006EF800F1
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2020 17:00:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5006EF800F1
IronPort-SDR: 6pIpets2n4KxlZ9IMptgNcTpxx3PsEmw7yFAohS2bIjoOLCS77bG/XhpNDx2Na3qTc6glB/sg+
 ai/1BM6jmvCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="230122113"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; d="scan'208";a="230122113"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 08:00:13 -0700
IronPort-SDR: hsPjDnOTLe/LxKw1Mzb195JGpBVxQIUoxh7UAx46lDK63UfeYBkdwTX9GObJgXAEmqioj3kPav
 Q6SQF0+QAkSA==
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; d="scan'208";a="280171468"
Received: from avenkat1-mobl2.amr.corp.intel.com (HELO [10.254.109.204])
 ([10.254.109.204])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 08:00:12 -0700
Subject: Re: [PATCH] snd/soc: correct trivial kernel-doc inconsistency
To: Colton Lewis <colton.w.lewis@protonmail.com>, alsa-devel@alsa-project.org
References: <4574918.31r3eYUQgx@laptop.coltonlewis.name>
 <db6d3b05-33c1-91b9-d0b4-c5063ebafcae@linux.intel.com>
 <20200626053953.68797-1-colton.w.lewis@protonmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3f131b97-08db-6c1e-e76e-362df261fbae@linux.intel.com>
Date: Fri, 26 Jun 2020 09:35:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626053953.68797-1-colton.w.lewis@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, broonie@kernel.org, lgirwood@gmail.com
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



On 6/26/20 12:40 AM, Colton Lewis wrote:
> Silence documentation build warning by correcting kernel-doc comment
> for snd_soc_runtime_action.
> 
> ./sound/soc/soc-pcm.c:220: warning: Function parameter or member 'action' not described in 'snd_soc_runtime_action'
> 
> Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/soc-pcm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 2c114b4542ce..9ab376844ac1 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -208,6 +208,7 @@ static inline void dpcm_remove_debugfs_state(struct snd_soc_dpcm *dpcm)
>    * PCM runtime components
>    * @rtd: ASoC PCM runtime that is activated
>    * @stream: Direction of the PCM stream
> + * @action: Activate stream if 1. Deactivate if -1.
>    *
>    * Increments/Decrements the active count for all the DAIs and components
>    * attached to a PCM runtime.
> 
