Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175FCC001B0
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Jul 2023 21:11:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0BDBA4D;
	Fri, 14 Jul 2023 23:10:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0BDBA4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689369107;
	bh=2bap8zB9vvxPTrUg6lNgEahOkneQI8GQnvL3RqEUxLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ISPThBK6N6AW9Uj9+em6WxR2wzptI9ZFFbs5rYiHlFQNMRyY51nDkXT03R3HPEzUl
	 roExceaQAJ3oIMxYmp4eLQndNJMwaGCzour1Wu3iXBdpehbBjA6AC1VpqK9fhTfqaX
	 OGYD0y1eqw7ZnS6lfhULXjD3h90DGJ30Iy1tGa8E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B665F80153; Fri, 14 Jul 2023 23:10:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ECF35F80249;
	Fri, 14 Jul 2023 23:10:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89CECF80249; Fri, 14 Jul 2023 23:10:26 +0200 (CEST)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com
 [209.85.166.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5AF1FF80153
	for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2023 23:10:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AF1FF80153
Received: by mail-io1-f41.google.com with SMTP id
 ca18e2360f4ac-78362f57500so97483639f.3
        for <alsa-devel@alsa-project.org>;
 Fri, 14 Jul 2023 14:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689369018; x=1691961018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkCjprVYBJpe7HRMk9SvWkrvsXF3xVXknPaBi2ASDrw=;
        b=CeWjZLLmXd0J+8jo7SMz/bEd377MNo8B3/rDgh+X/tFeQfq/z+IPzGmu+tXgX2ilIe
         FMEnkG/mA1sNOt+YTz8PXNw1P3RRChkUmCksD89fAoTODBcSWoGTzo+IcPrIl4CFkS7T
         Op5By3bfsVBHagZpwF5IDHERJ9Aw9sVBC9qhcZYBlUruBPr24t/IxhYIkD2sWC/Bq1By
         alwe4QWrW0sT1FDTtKX32zkJl+TcJozSRh5MdUITEqhNWiv7sVcAC52kVfZO1imMuXEh
         Z3fLOwr21LQHpR2Z4icE8R/ijfcLYkLtIIGYm5M0o2GrOhKVYuMzzQBihhCNDr8r0XwT
         qvjw==
X-Gm-Message-State: ABy/qLbDs0kZunxhSYL/gTtdTihvUH2C70IWrC3ox3hz19jA6+xP1YKh
	j6PfassrSG/aYHlPV+te6w==
X-Google-Smtp-Source: 
 APBJJlHw2d99DUg4gS2VZfnGG0p4S0aamaC8pUtwgVWFXwCrzpNa4KyrdxyzMFAGOi1rds0VjPsDyQ==
X-Received: by 2002:a6b:a04:0:b0:776:fd07:3c96 with SMTP id
 z4-20020a6b0a04000000b00776fd073c96mr6153362ioi.7.1689369018459;
        Fri, 14 Jul 2023 14:10:18 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id
 b9-20020a056602218900b007835686237asm2923748iob.27.2023.07.14.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 14:10:17 -0700 (PDT)
Received: (nullmailer pid 250792 invoked by uid 1000);
	Fri, 14 Jul 2023 21:10:02 -0000
Date: Fri, 14 Jul 2023 15:10:02 -0600
From: Rob Herring <robh@kernel.org>
To: Chancel Liu <chancel.liu@nxp.com>
Cc: krzysztof.kozlowski+dt@linaro.org, Xiubo.Lee@gmail.com,
 nicoleotsuka@gmail.com, shengjiu.wang@gmail.com, festevam@gmail.com,
 devicetree@vger.kernel.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 robh+dt@kernel.org, alsa-devel@alsa-project.org, conor+dt@kernel.org,
 perex@perex.cz, broonie@kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_rpmsg: Add compatible string
 for i.MX93
Message-ID: <168936900247.250605.6973924196553077259.robh@kernel.org>
References: <20230714092913.1591195-1-chancel.liu@nxp.com>
 <20230714092913.1591195-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714092913.1591195-2-chancel.liu@nxp.com>
Message-ID-Hash: 2UHDP35GEAGEEJC6NPZDK7IMYD5TQF7B
X-Message-ID-Hash: 2UHDP35GEAGEEJC6NPZDK7IMYD5TQF7B
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2UHDP35GEAGEEJC6NPZDK7IMYD5TQF7B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Fri, 14 Jul 2023 17:29:12 +0800, Chancel Liu wrote:
> Add compatible string for i.MX93 platform which supports audio
> function through rpmsg channel between Cortex-A and Cortex-M core.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

