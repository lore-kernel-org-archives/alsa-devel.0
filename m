Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7916DEB64D9
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jun 2023 16:46:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8DAD826;
	Thu, 29 Jun 2023 18:45:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8DAD826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688057163;
	bh=bljRpVQCgCKr7KOAtnHSxTXKHoZSmz8rm1JIj89UlXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aWkOP2sMmes30lXrS67BeKbi2mVnPefHvjCsENVa8EkamcKXIR6+CIDcqpnE5hvdA
	 an/4m2pUsk6EN6csVOTL8ftaaeEXtlXxLJBo5sh+e9iRgvWlM9Q7hTq0pk4tQJX7a0
	 kmTXXF5EHtpOv8gDa47pC3Eut1q5A2OGEzdxDgFA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1241EF80544; Thu, 29 Jun 2023 18:44:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6413EF80246;
	Thu, 29 Jun 2023 18:44:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76A07F80246; Thu, 29 Jun 2023 18:44:42 +0200 (CEST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com
 [209.85.166.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B66CF800E3
	for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2023 18:44:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B66CF800E3
Received: by mail-io1-f45.google.com with SMTP id
 ca18e2360f4ac-78362f57500so38108339f.3
        for <alsa-devel@alsa-project.org>;
 Thu, 29 Jun 2023 09:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688057075; x=1690649075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvv8o8lyQDs4Uqc/cTXEEqb+afkYfTSqGgHooIqCpbA=;
        b=kCe/diqFDInjvXQvSdWHNvDFsU7UPBFNFadjdt+j2n+Upi2Jni1OI9DRRe6z4Ekta5
         jeokhmz2NvfBaJoMWsSo+nLhSc1KPViBCyBC6sCQmEUZbiRYjr32xtdD/mcxaWjdCvAO
         GITsCW3xjS/tAsk6FFeHOS0FvJEW1xFr/zEWuatT2LRXjj2J7lB8bYcaq92EiD/BSmo6
         00Ym80+dDHTalXOg4vqTrETSCsxEfrAOldDH5UP+1dF6ldPyXxtF9+O65xOC35ME+eGw
         79YU6DIYoiFCNNtC/olxoQ+xU1DSpw0J3lRzAFI57OV/3U0sotVI1fnvg+UlxW5Lk6h4
         iAQw==
X-Gm-Message-State: AC+VfDxNiRb4hMgUda+zOFKgQM7NY8abXyozh4+9fe55SJpselwM1WOn
	daKSjKC2uXt0SXwuyd8w9Q==
X-Google-Smtp-Source: 
 ACHHUZ7Zq2rHGHa35R4f5/6RnXVSjZz6xktb2tp91v9Fy3aAm2hQ7f4Z40Tssnpm9/HIk8qiWdMP/A==
X-Received: by 2002:a5e:a717:0:b0:784:e618:e6cd with SMTP id
 b23-20020a5ea717000000b00784e618e6cdmr9008iod.20.1688057075474;
        Thu, 29 Jun 2023 09:44:35 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id
 b8-20020a5ea708000000b0076c7a2f0f41sm1627336iod.46.2023.06.29.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:44:34 -0700 (PDT)
Received: (nullmailer pid 3171062 invoked by uid 1000);
	Thu, 29 Jun 2023 16:44:33 -0000
Date: Thu, 29 Jun 2023 10:44:33 -0600
From: Rob Herring <robh@kernel.org>
To: Trevor Wu <trevor.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, perex@perex.cz,
 linux-mediatek@lists.infradead.org, tiwai@suse.com,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 alsa-devel@alsa-project.org, broonie@kernel.org
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: mediatek,mt8188-afe: add
 memory-region
Message-ID: <168805707144.3170983.17451535547887085687.robh@kernel.org>
References: <20230629074348.21670-1-trevor.wu@mediatek.com>
 <20230629074348.21670-3-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629074348.21670-3-trevor.wu@mediatek.com>
Message-ID-Hash: M4642EUH6AKLEJJP5HRRBZOJQU5QYM22
X-Message-ID-Hash: M4642EUH6AKLEJJP5HRRBZOJQU5QYM22
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M4642EUH6AKLEJJP5HRRBZOJQU5QYM22/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Thu, 29 Jun 2023 15:43:48 +0800, Trevor Wu wrote:
> Add memory-region property to utilize the reserved memory region.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../devicetree/bindings/sound/mediatek,mt8188-afe.yaml     | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

