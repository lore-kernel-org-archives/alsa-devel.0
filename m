Return-Path: <SRS0=4Ztp=5E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD1C4332D
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:08:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097032137B
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="e+emFZkf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FUIQinlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097032137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46243176A;
	Thu, 19 Mar 2020 15:07:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46243176A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584626893;
	bh=XV0u0ItEc4EH8W254bW0tIa097CzaZvkeCWb8PNI9Ok=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e+emFZkfM5tIg0SB4h+/q7VUWlt+USGcNN7TAl4q3XNW5fRV8GAaNjbe0f9KGcfuR
	 iE8GlZqmG3T1OTHQ0r/n1sBAl6LSMYysSP8m0XoNzXwR3uRHdjKsHYbLR7PxJzGeLL
	 BmaOVwQ5m4Fk8ATrMy/sazB5bVJHMBEG8fCDf2O4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64FD8F800DD;
	Thu, 19 Mar 2020 15:07:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F453F800C0; Thu, 19 Mar 2020 15:07:16 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD2F9F800C0
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2020 15:07:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD2F9F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FUIQinlx"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02JE77L3048046;
 Thu, 19 Mar 2020 09:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1584626827;
 bh=F8cnBozYX8/iF9YH+60dq/RPVSZvGKSsyeEtA3GUHiY=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=FUIQinlxjeigNZMn1OTmCITKd7pTLCtLHdjpqObiI5xXQgpEQT2Wo5ZRTHr02bDpR
 m00TJZbPf6va34eqFVVpqQaBkhh0SQar92NarCwP468LvJ4ZCqMdYD3BJwrdwd2xU5
 edsOfZgPicfvccrirHYADFMd+WtyTTISsX6abwRc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JE77UJ026756;
 Thu, 19 Mar 2020 09:07:07 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 09:07:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 09:07:07 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JE76v3049010;
 Thu, 19 Mar 2020 09:07:06 -0500
Subject: Re: [PATCH] ASoC: tas2562: Fixed incorrect amp_level setting.
To: Jonghwan Choi <charlie.jh@kakaocorp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20200319140043.GA6688@jhbirdchoi-MS-7B79>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <0b4a59c9-6af7-a34f-fb08-f5200fbe5926@ti.com>
Date: Thu, 19 Mar 2020 09:01:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319140043.GA6688@jhbirdchoi-MS-7B79>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

Jonghwan

On 3/19/20 9:00 AM, Jonghwan Choi wrote:
> According to the tas2562 datasheet,the bits[5:1] represents the amp_level value.
> So to set the amp_level value correctly,the shift value should be set to 1.
>
> Signed-off-by: Jonghwan Choi <charlie.jh@kakaocorp.com>
> ---
>   sound/soc/codecs/tas2562.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
> index be52886a5edb..fb2233ca9103 100644
> --- a/sound/soc/codecs/tas2562.c
> +++ b/sound/soc/codecs/tas2562.c
> @@ -409,7 +409,7 @@ static const struct snd_kcontrol_new vsense_switch =
>   			1, 1);
>   
>   static const struct snd_kcontrol_new tas2562_snd_controls[] = {
> -	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 0, 0x1c, 0,
> +	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 1, 0x1c, 0,
>   		       tas2562_dac_tlv),
>   };
>   


Acked-by: Dan Murphy <dmurphy@ti.com>

