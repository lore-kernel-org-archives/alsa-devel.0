Return-Path: <SRS0=sxeJ=4J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B297EC35646
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:44:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AFC206E2
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mbQUnHA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AFC206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A497C16B4;
	Fri, 21 Feb 2020 16:43:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A497C16B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582299870;
	bh=jkZQFgPsPyR5A+kSjTDPH7u9v+FrkGj0BEFlkIdTo3Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mbQUnHA3g8zkfCFONuSSLH6Iv77UWr5osfKlw6L7P17ocFL1sq28Cvvm6tO9TKUZx
	 qqKMx2xkaLbjIj27+v7fg7Rqzw7VX1lKjzYY1SNCpR4yj2Gvj+CppSX2IlaQm9pt2S
	 iq8tiDBnT2fQgPxVH35ignOq+wO/gtQOFCzOJXKs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27CFDF80240;
	Fri, 21 Feb 2020 16:43:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5752DF8025F; Fri, 21 Feb 2020 16:43:38 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 466A5F800C5
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2020 16:43:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 466A5F800C5
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Feb 2020 07:43:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,468,1574150400"; d="scan'208";a="236603814"
Received: from mdiamon1-mobl.amr.corp.intel.com (HELO [10.252.143.193])
 ([10.252.143.193])
 by orsmga003.jf.intel.com with ESMTP; 21 Feb 2020 07:43:30 -0800
Subject: Re: [PATCH] Intel: Skylake: Fix inconsistent IS_ERR and PTR_ERR
To: Joe Perches <joe@perches.com>, Xu Wang <vulab@iscas.ac.cn>,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
References: <20200221101112.3104-1-vulab@iscas.ac.cn>
 <1247da797bc0a860e845989241385e124e589063.camel@perches.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8e96c207-cdf8-2d1f-755e-be60555c8728@linux.intel.com>
Date: Fri, 21 Feb 2020 09:40:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1247da797bc0a860e845989241385e124e589063.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "Rojewski, Cezary" <cezary.rojewski@intel.com>,
 linux-kernel@vger.kernel.org, "Slawinski,
 AmadeuszX" <amadeuszx.slawinski@intel.com>
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



On 2/21/20 8:41 AM, Joe Perches wrote:
> On Fri, 2020-02-21 at 18:11 +0800, Xu Wang wrote:
>> PTR_ERR should access the value just tested by IS_ERR.
>> In skl_clk_dev_probe(),it is inconsistent.
> []
>> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
> []
>> @@ -384,7 +384,7 @@ static int skl_clk_dev_probe(struct platform_device *pdev)
>>   				&clks[i], clk_pdata, i);
>>   
>>   		if (IS_ERR(data->clk[data->avail_clk_cnt])) {
>> -			ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
>> +			ret = PTR_ERR(data->clk[data->avail_clk_cnt]);
> 
> NAK.
> 
> This is not inconsistent and you are removing the ++
> which is a post increment.  Likely that is necessary.
> 
> You could write the access and the increment as two
> separate statements if it confuses you.

Well to be fair the code is far from clear.

the post-increment is likely needed because of the error handling in 
unregister_src_clk 1
		data->clk[data->avail_clk_cnt] = register_skl_clk(dev,
				&clks[i], clk_pdata, i);

		if (IS_ERR(data->clk[data->avail_clk_cnt])) {
			ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
			goto err_unreg_skl_clk;
		}
	}

	platform_set_drvdata(pdev, data);

	return 0;

err_unreg_skl_clk:
	unregister_src_clk(data);

static void unregister_src_clk(struct skl_clk_data *dclk)
{
	while (dclk->avail_clk_cnt--)
		clkdev_drop(dclk->clk[dclk->avail_clk_cnt]->lookup);
}

So the post-increment is cancelled in the while().

That said, the avail_clk_cnt field is never initialized or incremented 
in normal usages so the code looks quite suspicious indeed.

gitk tells me this patch is likely the culprit:

6ee927f2f01466 ('ASoC: Intel: Skylake: Fix NULL ptr dereference when 
unloading clk dev')

-		data->clk[i] = register_skl_clk(dev, &clks[i], clk_pdata, i);
-		if (IS_ERR(data->clk[i])) {
-			ret = PTR_ERR(data->clk[i]);
+		data->clk[data->avail_clk_cnt] = register_skl_clk(dev,
+				&clks[i], clk_pdata, i);
+
+		if (IS_ERR(data->clk[data->avail_clk_cnt])) {
+			ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
  			goto err_unreg_skl_clk;
  		}
-
-		data->avail_clk_cnt++;

That last removal is probably wrong. Cezary and Amadeusz, you may want 
to look at this?
