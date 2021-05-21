Return-Path: <SRS0=n5wC=KQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFCAC47078
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 15:44:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5125613DB
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 15:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5125613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5BA216B6;
	Fri, 21 May 2021 17:43:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5BA216B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621611852;
	bh=uO1z4JY0xye+w59/caHQVZuG8JdQR1wj0AUnYTXWJiE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfT5rrhZHc8coWeunOgrT9IC/ryFC9uud0AVoo2FQONzM9EQ/YTroE20hOoAEMbIz
	 hmDBozvZsn9rRrvGk5+CQHN/DkMDNv4ZpOhBMQ8wkpDQy9g0H1YJpdoaf3BbZ6KA8W
	 1s5A/ZzQ9JkCUNtzY3gifEkq2eOl62G/0UAO/mOw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40F5AF800E5;
	Fri, 21 May 2021 17:43:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41A1BF801DB; Fri, 21 May 2021 17:43:21 +0200 (CEST)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 383DAF800E5
 for <alsa-devel@alsa-project.org>; Fri, 21 May 2021 17:43:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 383DAF800E5
Received: by mail-oo1-f53.google.com with SMTP id
 i8-20020a4aa1080000b0290201edd785e7so4665928ool.1
 for <alsa-devel@alsa-project.org>; Fri, 21 May 2021 08:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yegbdR8KSApe+4ngi1kXcS7ZM10vxGbU/4zWEQ1128I=;
 b=RerYaEvz3wn1sV2e2Su8Z1X0sv67K6oGO7gdd/zvaR6d3kYIWUShZt8pl8x3DLMQrk
 +gfdKeL2kl+5bRAvwdjKuNcdycleM806o+d/5V9RQeXdyr/zvoHsP05wnDnqkexseZlm
 7JEPHwJDLy6ibI4A3z5RVFF2eu0vE4Ce47rhjzTKCHRkMTFChjSFMGelJNO3UCthLMB/
 1cCLWIgA4qVSWbM66FY3g+OsD5SkR8CWuoZk+UMOzO5cxMOTex0xFnyfWjluYn0FUW3t
 Cxf6I5eqgdEGq9FBoGEhrNnM56Iy1CwOsdLjz12MVTqQW/ZWNU5sWUM4VTVe/9XFZztE
 CrEQ==
X-Gm-Message-State: AOAM531N1dIr3Tp1D/zrBWsdF0RL1Ma58x5j6K3fM3CeZLGE96B6RLao
 lxnVfa9VntF+I7ibPbyfbw==
X-Google-Smtp-Source: ABdhPJyCmpOnE/ZQpkS6yGfTc1tG2/P8pWGm0a0vKvhQXR6E8uy3tjPzY7AuBhG7J2uRoccf3GXjDQ==
X-Received: by 2002:a4a:9b0b:: with SMTP id a11mr8799792ook.73.1621611792431; 
 Fri, 21 May 2021 08:43:12 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t39sm1244580ooi.42.2021.05.21.08.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 08:43:11 -0700 (PDT)
Received: (nullmailer pid 4051106 invoked by uid 1000);
 Fri, 21 May 2021 15:43:10 -0000
Date: Fri, 21 May 2021 10:43:10 -0500
From: Rob Herring <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v1] ASoC: dt-bindings: Convert imx-audmux binding to json
 schema
Message-ID: <20210521154310.GA4051048@robh.at.kernel.org>
References: <20210521122129.1371-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521122129.1371-1-o.rempel@pengutronix.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
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

On Fri, 21 May 2021 14:21:29 +0200, Oleksij Rempel wrote:
> Convert the imx-audmux binding to DT schema format using json-schema
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/sound/imx-audmux.txt  |  28 -----
>  .../devicetree/bindings/sound/imx-audmux.yaml | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/imx-audmux.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmux.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
