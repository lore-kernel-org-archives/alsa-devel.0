Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656F8C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 16:36:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28CC604DA
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 16:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B28CC604DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40B341845;
	Wed, 15 Sep 2021 18:35:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40B341845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631723794;
	bh=evnUKsDthFhrTgbTnl+EddrIEMOTWUGSPRnfxhq8Rl8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QeXgKjEF5WzgVAC3MU1VtPkKkqdxwKzz0yxZ+NQZ/nNAM01qEDVpozqvdBMtLXQoW
	 fPutKplgeuNEtCcL+5kQm6EHls6k61hq08cYgLbMANYReLsacrVinZMQdW745Ik9gP
	 oL5W9rmeBR1cL+7EOPmLkpA/F6hSZ2Dg7e3y91rA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17471F804BD;
	Wed, 15 Sep 2021 18:34:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 328EAF80117; Wed, 15 Sep 2021 18:34:47 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 632AAF80117
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 18:34:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 632AAF80117
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286060893"
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; d="scan'208";a="286060893"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 09:34:34 -0700
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; d="scan'208";a="583352185"
Received: from mvetrive-mobl3.amr.corp.intel.com (HELO [10.212.69.198])
 ([10.212.69.198])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 09:34:32 -0700
Subject: Re: [PATCH v6 14/22] ASoC: qdsp6: audioreach: add basic pkt alloc
 support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210915131333.19047-1-srinivas.kandagatla@linaro.org>
 <20210915131333.19047-15-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c6082189-5788-0973-2fba-699f1cc7e4ae@linux.intel.com>
Date: Wed, 15 Sep 2021 10:54:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915131333.19047-15-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com
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



> +#define APM_SHMEM_FMT_CFG_PSIZE(n) ALIGN( \
> +				sizeof(struct apm_sh_module_media_fmt_cmd) + \
> +				n * sizeof(uint8_t), 8)
> +
> +/* num of channels as argument */
> +#define APM_PCM_MODULE_FMT_CMD_PSIZE(n) ALIGN( \
> +				sizeof(struct apm_pcm_module_media_fmt_cmd) + \
> +				n * sizeof(uint8_t), 8)
> +
> +#define APM_PCM_OUT_FMT_CFG_PSIZE(n) ALIGN((sizeof( \
> +				struct payload_pcm_output_format_cfg) + \
> +				n * sizeof(uint8_t)), 4)

nit-pick: sizeof on the same line for consistency/readability?
