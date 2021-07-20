Return-Path: <SRS0=et8u=MM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B1C07E95
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 18:49:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5106023B
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 18:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5106023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED5E3168A;
	Tue, 20 Jul 2021 20:48:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED5E3168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626806969;
	bh=TSHPZRBsIMbVKvtMk1+XUX6CmIED68sP+F2Awj1gn64=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=prW8yQjT2DNz4rsbJBypjRgldzQBVzg+XcfP6EwJiYQ0GQvnUQZ8lOiE/ejQYF0ts
	 RVw03b7Xjw2gi7EOI9CnEIAve2lw3s/v/37A+nPnzmtqU6RpLCiIA5nOO1N7xImJz0
	 0pnoqVBf2y/BIVCo+JFGx6NmUw1wFZNYd6snEvio=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB8EAF804A9;
	Tue, 20 Jul 2021 20:47:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D825CF80423; Tue, 20 Jul 2021 20:47:42 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 727D5F80104
 for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2021 20:47:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 727D5F80104
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="198511668"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; d="scan'208";a="198511668"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2021 11:47:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; d="scan'208";a="462146678"
Received: from aremenni-mobl.amr.corp.intel.com (HELO [10.209.130.10])
 ([10.209.130.10])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2021 11:47:30 -0700
Subject: Re: [PATCH v4 09/12] ASoC: amd: add vangogh i2s dai driver ops
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
 <20210720163732.23003-10-Vijendar.Mukunda@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6983b9cf-d270-1033-5481-f8aa5bb378d9@linux.intel.com>
Date: Tue, 20 Jul 2021 13:30:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720163732.23003-10-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Sunil-kumar.Dommati@amd.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Alexander.Deucher@amd.com, krisman@collabora.com
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


> diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
> index 2300e63534e7..c94ed8795b9c 100644
> --- a/sound/soc/amd/vangogh/acp5x.h
> +++ b/sound/soc/amd/vangogh/acp5x.h
> @@ -74,9 +74,20 @@
>  #define I2S_MASTER_MODE_ENABLE 0x01
>  #define I2S_MASTER_MODE_DISABLE 0x00
>  
> +#define SLOT_WIDTH_8 0x08
> +#define SLOT_WIDTH_16 0x10
> +#define SLOT_WIDTH_24 0x18
> +#define SLOT_WIDTH_32 0x20

nit-pick: it's not incorrect but is the hex notation necessary?

> +#define TDM_ENABLE 1
> +#define TDM_DISABLE 0
> +#define ACP5x_ITER_IRER_SAMP_LEN_MASK	0x38
