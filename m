Return-Path: <SRS0=eYvk=35=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B020C35250
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Feb 2020 15:36:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90ABA20726
	for <alsa-devel@archiver.kernel.org>; Sun,  9 Feb 2020 15:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZNti2bER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ABA20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE6C8166F;
	Sun,  9 Feb 2020 16:35:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE6C8166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581262559;
	bh=4C2Hz6gTWTngW9tESNPOXsx91RU6nH4R4TWprxh4sMs=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZNti2bER4hpJ0IDFDYuSvL5HObN93uItETFiDA+ynGJHAZtZZWz6v3xVKkb+36Mgc
	 Ns9UBtbK74f8GD22lZXysfaCclKk1c/WPC7v5iobbgSFKT0Lf68j7lrFDzFq7OlbBU
	 YYCZuT4nmibmFmI8DUdGgNIIn0DgWpCaTX7hip0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B9C9F800E7;
	Sun,  9 Feb 2020 16:35:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94CE0F80145; Sun,  9 Feb 2020 16:35:05 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1ED0F800E7
 for <alsa-devel@alsa-project.org>; Sun,  9 Feb 2020 16:35:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1ED0F800E7
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Feb 2020 07:34:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,421,1574150400"; d="scan'208";a="226964306"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.86.168])
 ([10.251.86.168])
 by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2020 07:34:52 -0800
To: Colin King <colin.king@canonical.com>
References: <20200208220720.36657-1-colin.king@canonical.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <5622cdca-c17b-c0d8-8dbc-4616449877d2@intel.com>
Date: Sun, 9 Feb 2020 16:34:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200208220720.36657-1-colin.king@canonical.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: mrfld: return error codes
 when an error occurs
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

On 2020-02-08 23:07, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently function sst_platform_get_resources always returns zero and
> error return codes set by the function are never returned. Fix this
> by returning the error return code in variable ret rather than the
> hard coded zero.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: f533a035e4da ("ASoC: Intel: mrfld - create separate module for pci part")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   sound/soc/intel/atom/sst/sst_pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
> index d952719bc098..5862fe968083 100644
> --- a/sound/soc/intel/atom/sst/sst_pci.c
> +++ b/sound/soc/intel/atom/sst/sst_pci.c
> @@ -99,7 +99,7 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
>   	dev_dbg(ctx->dev, "DRAM Ptr %p\n", ctx->dram);
>   do_release_regions:
>   	pci_release_regions(pci);
> -	return 0;
> +	return ret;
>   }
>   
>   /*
> 

Thank you for the fix.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
