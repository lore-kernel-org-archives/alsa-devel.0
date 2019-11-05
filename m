Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7E2C5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:07:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B1621929
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CYLL/I1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B1621929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DEBF16DC;
	Tue,  5 Nov 2019 23:06:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DEBF16DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572991632;
	bh=A8mwe9wQJtWXbmfTU1IfEkK1Q26zuHaQIqf/o0rnmuQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CYLL/I1DWsZgef2m0+j4ymDIZT4+AdilQTfxP20aTHHoRSFA4xxZrZx9oYzKURoJh
	 pYehtuTqL55ecoKXSlClkpsBWd3nFJmkSrnNkiCpJvhDfMMHiFseO50OobzlkWdHtt
	 rR96igXjSCOibtNX0SyDmS03b7b+rrxbbqPo6sdQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1FBFF80446;
	Tue,  5 Nov 2019 23:06:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D703F8049B; Tue,  5 Nov 2019 23:06:20 +0100 (CET)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5557CF8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 23:06:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5557CF8015B
Received: by mail-ot1-f65.google.com with SMTP id r24so2764587otk.12
 for <alsa-devel@alsa-project.org>; Tue, 05 Nov 2019 14:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Gisrq4TxhtoP8Q30cWa1tTfB7XNXHFmOi8fXi53w+bM=;
 b=uXqesS4EMIfxrDfR1/NK/OERMjTNJ7TYe/yZrnyAv62g3ygVbin8Nb7t1VNkWc6XxH
 UPgkofXqDQviqP6YLioEYgKXcfCssl8vdDgzaloNXTIVClujeW/lv8TWVy98kM/kwn5+
 cYvzQNKQvm64VxD2ybkr9SxwTsjKxjNVgGIyjkHu3KoTpYf/v6hEfY3AnuU/IrBT5DGi
 xCW0tapwQrv5C8euunZfTHvzeePTeKFW6SBXe93W2jPaNPPhwKuGBhEUqgvcPwFjvE2X
 TKoDjSbKbDwerQdqD42uTyUXXesVyWy6+2byVvFQp8dB21quqCkRJBVdCLMZAkaHB0bh
 NyyA==
X-Gm-Message-State: APjAAAVQlNAsS6ekgN6K2/Se9Ttq68ry6LaQRseoXxkjC2wZsQRKf98F
 B3qQrQEyYXSHFEiselP7pA==
X-Google-Smtp-Source: APXvYqziXsft0r6jrafQ9WzZOixRtOGMfgoIJWpJT32hv2BnJtDlqlWeelJ4ao+H8Pht1CzipcEy0A==
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr5137307otn.370.1572991575309; 
 Tue, 05 Nov 2019 14:06:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id b12sm5910543oie.52.2019.11.05.14.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 14:06:14 -0800 (PST)
Date: Tue, 5 Nov 2019 16:06:14 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Message-ID: <20191105220614.GA12397@bogus>
References: <6465fb7dfaa68b6693584bcfa696894628d45fe9.1572435604.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6465fb7dfaa68b6693584bcfa696894628d45fe9.1572435604.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH V2 1/2] ASoC: dt-bindings: fsl_asrc: add
 compatible string for imx8qm
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Oct 30, 2019 at 07:41:26PM +0800, Shengjiu Wang wrote:
> In order to support the two asrc modules in imx8qm, we need to
> add compatible string "fsl,imx8qm-asrc0" and "fsl,imx8qm-asrc1"

Are the blocks different in some way?

If not, why do you need to distinguish them?

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index 1d4d9f938689..cd2bd3daa7e1 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -8,7 +8,8 @@ three substreams within totally 10 channels.
>  
>  Required properties:
>  
> -  - compatible		: Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
> +  - compatible		: Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
> +			  "fsl,imx8qm-asrc0" or "fsl,imx8qm-asrc1".
>  
>    - reg			: Offset and length of the register set for the device.
>  
> -- 
> 2.21.0
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
