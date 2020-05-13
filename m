Return-Path: <SRS0=BSyU=63=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA39C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2020 17:26:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1620820659
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2020 17:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DLdD2r8L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oU+zYpSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1620820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD2CC1615;
	Wed, 13 May 2020 19:25:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD2CC1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589390808;
	bh=OAYW1/kKp1XWDgzrpZuwLukMSsmthAR6AIk8NwqEdYA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DLdD2r8LAEbKBNHKmzO/6O/Px+kzdFWTVrBjiZ7+4jyeZRLTxLEE4C45GP/uioTT7
	 6QfJ2SEpUqdKjHfPeyV9NUQ8v0IT1Nga628o4ZKD/GNPLkHb7xBkgGCjhZ38hF8KFu
	 bCNgKDQXmKYKL9Jo6Tpm26qutbmKFmwfnYeFtdBI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54684F8022D;
	Wed, 13 May 2020 19:25:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44DAEF80247; Wed, 13 May 2020 19:25:56 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38837F800BD
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2020 19:25:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38837F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oU+zYpSz"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DHPnEH109727;
 Wed, 13 May 2020 12:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1589390749;
 bh=duOsfIS+tq7+J/oq9NmLkFabkw0gD0IE1GYQRhOX5qg=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=oU+zYpSz2npoUF8TOdFjvAo6oy3TDlzNxjM9OTYFYFveOmiCLMOlLpGap3JuPIkW2
 R87XXmuprnHmGwGDf4VYlncFRBLlcIUsKM9oX+ThnhFpkmGK+OlH2oC34bzBnHrCnR
 TJQ4vS/AiA2e4RwVCjmaSw9t804bdBoor0IFSQVc=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DHPnSd123155
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 May 2020 12:25:49 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 12:25:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 12:25:49 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DHPnc9115992;
 Wed, 13 May 2020 12:25:49 -0500
Subject: Re: [PATCH] ASoC: tlv320adcx140: Add controls for PDM clk and edge
To: Mark Brown <broonie@kernel.org>
References: <20200513144746.14337-1-dmurphy@ti.com>
 <20200513153243.GO4803@sirena.org.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <d2e3741e-ba06-7578-b5f3-2af75e1e33c7@ti.com>
Date: Wed, 13 May 2020 12:16:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513153243.GO4803@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
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

Mark

On 5/13/20 10:32 AM, Mark Brown wrote:
> On Wed, May 13, 2020 at 09:47:46AM -0500, Dan Murphy wrote:
>
>> +static const char * const pdmclk_text[] = {
>> +	"2.8224 MHz", "1.4112 MHz", "705.6 kHz", "5.6448 MHz"
>> +};
>> +
>> +static SOC_ENUM_SINGLE_DECL(pdmclk_select_enum, ADCX140_PDMCLK_CFG, 0,
>> +			    pdmclk_text);
>> +
>> +static const struct snd_kcontrol_new pdmclk_div_controls[] = {
>> +	SOC_DAPM_ENUM("PDM Clk Divider Select", pdmclk_select_enum),
>> +};
>> +
>> +static const char * const pdm_edge_text[] = {
>> +	"Negative", "Positive"
>> +};
> Are these (especially the clock and polarity) things that are going to
> vary at runtime?  I'd have expected these to come from the hardware
> rather than being something that could usefully change.
Some microphone support low power modes that use a slower clock.
Polarity will probably not change at run-time, but clock speed can 
change to move mics from low power/low-resolution to higher 
power/high-resolution mode.

So polarity can be made hardware specific but clocks should be configurable.

I can break these out into separate patches if you want.

Dan

