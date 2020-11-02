Return-Path: <SRS0=b8gG=EI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798C7C388F9
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:18:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A89122275
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LoDDI3jk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aBk9tP4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A89122275
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF41216DB;
	Mon,  2 Nov 2020 09:17:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF41216DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604305127;
	bh=yxL89Hl7K6+0Ssn+nIQ9BuCY3LXH9StE855PvV0xK1I=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LoDDI3jkSr13sBRdj6vykl+k86dg3kEpHKgj5NCkcVq9w08xSxXP9dsMr+EpaXPdt
	 QJYLfAniB8fE6sMG6j1oAAEMKovDueL00qdjJlBaxz2g7m/jlUerXW3hRdjNa6r+z+
	 8cn219t7eDVyIANOvoJZ0sHMl9iSiYljaun97/1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37DF2F80229;
	Mon,  2 Nov 2020 09:17:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A519CF80232; Mon,  2 Nov 2020 09:17:55 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A19EF8012B
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 09:17:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A19EF8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aBk9tP4x"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A28HkjG095958;
 Mon, 2 Nov 2020 02:17:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1604305066;
 bh=PKURKhrStf5hrU/3/FF8PfX58ZYAVeadBgvFHZofdUQ=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=aBk9tP4xdkqFm+ZsJtTWJASXy4g8DHzi/WCcG1PXOBg5cUc9e3Be39Cgu6md+6JbB
 H+acGNAdSqAMWLIvF5U3xqVqPO5z2Va273STE7hdctiLgeWib5IiY8tECBeHTeWLHk
 +V1nv47qCi57ZIlKmf+2BRKCwy10JTZEGpDjVXKY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A28Hkj4016878
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Nov 2020 02:17:46 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 02:17:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 02:17:46 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A28HiDm044386;
 Mon, 2 Nov 2020 02:17:44 -0600
Subject: Re: [PATCH] ASoC: ti: davinci-evm: Remove redundant null check before
 clk_disable_unprepare
To: Xu Wang <vulab@iscas.ac.cn>, <lgirdwood@gmail.com>, <broonie@kernel.org>, 
 <perex@perex.cz>, <tiwai@suse.com>, <alsa-devel@alsa-project.org>
References: <20201029082513.28233-1-vulab@iscas.ac.cn>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ec63e4cc-b723-d183-8205-20fd0debbb43@ti.com>
Date: Mon, 2 Nov 2020 10:18:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029082513.28233-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: linux-kernel@vger.kernel.org
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



On 29/10/2020 10.25, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  sound/soc/ti/davinci-evm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
> index 105e56ab9cdc..b043a0070d20 100644
> --- a/sound/soc/ti/davinci-evm.c
> +++ b/sound/soc/ti/davinci-evm.c
> @@ -46,8 +46,7 @@ static void evm_shutdown(struct snd_pcm_substream *substream)
>  	struct snd_soc_card_drvdata_davinci *drvdata =
>  		snd_soc_card_get_drvdata(soc_card);
>  
> -	if (drvdata->mclk)
> -		clk_disable_unprepare(drvdata->mclk);
> +	clk_disable_unprepare(drvdata->mclk);
>  }
>  
>  static int evm_hw_params(struct snd_pcm_substream *substream,
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
