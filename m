Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD860C07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 16:38:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F18B61CCC
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 16:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F18B61CCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F8241670;
	Wed,  7 Jul 2021 18:37:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F8241670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625675879;
	bh=IexnHbUi8IhAZVlmyv4Yu5/oFRkcK2gkuDOK3g7zu0Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CSl2rfRPjXU9sCDGCkHsQzOdAkm4lXSJOTEhGaP+O5ECEM5vhgAJXkheZfhf+KqvR
	 7vdPuXeVJ2OooxcbOOPMbi31fHXQzNaAYVAvJVwSly6/6Tu3LcAwbZ8XPJ/hZodoxy
	 JVpwWk4lAa2KThwcOE2xPYcwWFuDZ+u3lc8qpgqE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4F07F804E0;
	Wed,  7 Jul 2021 18:35:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE9B4F804E2; Wed,  7 Jul 2021 18:35:43 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24C69F8016C
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 18:35:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24C69F8016C
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209299046"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; d="scan'208";a="209299046"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2021 09:35:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; d="scan'208";a="645442799"
Received: from cmcarran-mobl.amr.corp.intel.com (HELO [10.213.189.140])
 ([10.213.189.140])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2021 09:35:37 -0700
Subject: Re: [PATCH 10/12] ASoC: amd: add vangogh pci driver pm ops
To: Vijendar Mukunda <vijendar.mukunda@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-11-vijendar.mukunda@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ce03f4b3-874f-a286-5523-7793722a6ee7@linux.intel.com>
Date: Wed, 7 Jul 2021 11:34:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707055623.27371-11-vijendar.mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Alexander.Deucher@amd.com, Takashi Iwai <tiwai@suse.com>,
 Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
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


> +static int snd_acp5x_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct acp5x_dev_data *adata;
> +
> +	adata = dev_get_drvdata(dev);
> +	ret = acp5x_deinit(adata->acp5x_base);
> +	if (ret)
> +		dev_err(dev, "ACP de-init failed\n");
> +	else
> +		dev_dbg(dev, "ACP de-initialized\n");
> +
> +	return ret;
> +}
> +
> +static int snd_acp5x_resume(struct device *dev)
> +{
> +	int ret;
> +	struct acp5x_dev_data *adata;
> +
> +	adata = dev_get_drvdata(dev);
> +	ret = acp5x_init(adata->acp5x_base);
> +	if (ret) {
> +		dev_err(dev, "ACP init failed\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops acp5x_pm = {
> +	.runtime_suspend = snd_acp5x_suspend,
> +	.runtime_resume =  snd_acp5x_resume,
> +	.resume =	snd_acp5x_resume,

use SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS?

also not clear why you don't have a .suspend here?

And to avoid warnings use __maybe_unused for those callbacks when PM is disabled?


