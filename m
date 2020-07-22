Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82092C433E2
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:51:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D3420781
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vn1tjw2v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VjW8M1Ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D3420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F6C4852;
	Wed, 22 Jul 2020 20:50:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F6C4852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595443878;
	bh=Bk4mtDbs4VFmJlp4TdT+8ZhiB+fSb/xZ6x2EIfTS5KY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vn1tjw2vGHAobrC9zugxrhxGVCLQ6zT8286y3YiCSJKwElhY/rAW1e8rnzpeu/das
	 dmDveJYfk9sv5tZQglgJ4NJ6vKPZXmCjgfwCzhBU2GzNMCGe4yt21FSB8K3ZSblqpp
	 VQBtzX0nntELY14fKqha9xtsm7z1yO3DAJuyFq84=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBADBF800CE;
	Wed, 22 Jul 2020 20:50:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2824EF8014C; Wed, 22 Jul 2020 20:50:20 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F52DF800CE
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 20:50:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F52DF800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VjW8M1Ij"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06MIoAQA025624;
 Wed, 22 Jul 2020 13:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1595443810;
 bh=9f2jGn0pD++9Yxca7x8BCShEMLB/gy2zylnc48q7auA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=VjW8M1IjKgzniAsdheTN3EvjKM66h2tHKrVUv944qJgkr/UY13i828uajtF1NR75O
 KbR+cWHsZO38WQ0ZfJ4r4Zg/OvezfxNhtk3p4rqD6AjodiMZo94TtIQzmWb3Fwxr4Q
 +6djcYk0x2+Rp7tB7xewdbWJrQr4LecUGOStC+o8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06MIoArG047101
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Jul 2020 13:50:10 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 13:50:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 13:50:10 -0500
Received: from [10.250.35.192] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MIo91r100814;
 Wed, 22 Jul 2020 13:50:09 -0500
Subject: Re: [PATCH v2 2/2] ASoC: tas2562: Update shutdown GPIO property
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <robh@kernel.org>
References: <20200722154706.9657-1-dmurphy@ti.com>
 <20200722154706.9657-2-dmurphy@ti.com>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <09f2076f-352f-cac2-030f-9f29a0add47e@ti.com>
Date: Wed, 22 Jul 2020 13:50:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722154706.9657-2-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

Hello

On 7/22/20 10:47 AM, Dan Murphy wrote:
> Update the shutdown GPIO property to be shutdown from shut-down.
>
> Fixes: c173dba44c2d2 ("ASoC: tas2562: Introduce the TAS2562 amplifier")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>
> v2 - Set sdz_gpio to NULL if gpio property not present.
>
>   sound/soc/codecs/tas2562.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
> index e74628061040..8a53633a3853 100644
> --- a/sound/soc/codecs/tas2562.c
> +++ b/sound/soc/codecs/tas2562.c
> @@ -680,12 +680,25 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
>   	struct device *dev = tas2562->dev;
>   	int ret = 0;
>   
> -	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
> -						    GPIOD_OUT_HIGH);
> +	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown",
> +						      GPIOD_OUT_HIGH);
>   	if (IS_ERR(tas2562->sdz_gpio)) {
> -		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER) {
> -			tas2562->sdz_gpio = NULL;
> +		tas2562->sdz_gpio = NULL;

This is incorrect.  We will never see EPROBE_DEFER since we cleared out 
the gpio.  I need to revert this.

Same for below.

> +		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER)
>   			return -EPROBE_DEFER;
> +	}
> +
> +	/*
> +	 * The shut-down property is deprecated but needs to be checked for
> +	 * backwards compatibility.
> +	 */
> +	if (tas2562->sdz_gpio == NULL) {
> +		tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
> +							      GPIOD_OUT_HIGH);
> +		if (IS_ERR(tas2562->sdz_gpio)) {
> +			tas2562->sdz_gpio = NULL;

Same comment as above

Dan

