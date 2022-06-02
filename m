Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C4CCCA478
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jun 2022 13:36:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAC4F174B;
	Thu,  2 Jun 2022 15:35:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAC4F174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654176963;
	bh=BWUS7htz5gFjgOD5DhsohWS5sPd/5YA+o3KxLX5Yq+w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FkK2UeUpUPtT7ssev80NKHrmIHFa+3oBF5BIFaxNkPLA0yErfXWiH8TLDFyrp+onQ
	 R1tAcAYB2uJeFUa05hpUQMRfGj1BTfjLygahEGq8LRQdrSFXm+x/bC7ihQ3T119YU/
	 8nQ1hMnp9eMQjvBHY4uZvvAQEJsTBnecXDPkWtA4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5160FF80158;
	Thu,  2 Jun 2022 15:35:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5552F80236; Thu,  2 Jun 2022 15:35:11 +0200 (CEST)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B655F80089
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2022 15:35:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B655F80089
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-f2e0a41009so6743846fac.6
 for <alsa-devel@alsa-project.org>; Thu, 02 Jun 2022 06:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tgfreAiExWVjh0PELNOgid7tEm3i3yoN+t28LQQbOv8=;
 b=M5AB2FR9Xg/+k83hXguGSQXHyoo3mDg01ev2OkF9NDZsX6ZURtDUVJnyyPudxqq4QB
 t4Cj93QsTtiXyjZDCoCYFOaOdjV2uGDqcsNF5jdzL2W2e3OvWJgkDZlkmtR1DLrgqwkQ
 83fLAfntwJA/EaC/0hpPeDdskctIApGwfz6WP0Z3q//6phUD4TsGnj2nBDLHCUSYSOIT
 WGNe9fp8v3XnlR9QnXAiZus6ZZl6s22IDgXo0TO3YYNeorta7JJ9Rq02IwemebMa+cQ6
 srnGhKL62uXvMAU38DgN41o6GWzY9MiKHK0f2zhbl6Xsytb2ntwhouoULCucVUR4wXUA
 IRGw==
X-Gm-Message-State: AOAM530ialrb8b93VLvS9sNgNSjhp1Qiz1lMmmrJC4GEzNN3UwBUy7mm
 ea2R6G1Vs3yZApSVLOXnXQ==
X-Google-Smtp-Source: ABdhPJwWILYV+CaH9AQ9LI9AUkPXoe8U3uEh9QSpzW+3Pmotl16aphMbVSG0O8No11RVjqhlcb7ghg==
X-Received: by 2002:a05:6870:630a:b0:e2:f8bb:5ec with SMTP id
 s10-20020a056870630a00b000e2f8bb05ecmr2572853oao.171.1654176903469; 
 Thu, 02 Jun 2022 06:35:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0568080bc300b0032e41b45ea7sm368959oik.18.2022.06.02.06.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 06:35:03 -0700 (PDT)
Received: (nullmailer pid 2160289 invoked by uid 1000);
 Thu, 02 Jun 2022 13:35:02 -0000
Date: Thu, 2 Jun 2022 08:35:02 -0500
From: Rob Herring <robh@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v5 18/20] dt-bindings: mediatek: mt8186: add
 mt8186-mt6366-da7219-max98357 document
Message-ID: <20220602133502.GA2160227-robh@kernel.org>
References: <20220523132858.22166-1-jiaxin.yu@mediatek.com>
 <20220523132858.22166-19-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523132858.22166-19-jiaxin.yu@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 broonie@kernel.org, linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com, julianbraha@gmail.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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

On Mon, 23 May 2022 21:28:56 +0800, Jiaxin Yu wrote:
> Add document for mt8186 board with mt6366, da7219 and max98357.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../sound/mt8186-mt6366-da7219-max98357.yaml  | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
