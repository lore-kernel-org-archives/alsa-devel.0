Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6D4C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 18:29:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B766516B
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 18:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B766516B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1B86189B;
	Mon,  8 Mar 2021 19:28:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1B86189B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615228167;
	bh=jcNg9ZszJ6/z23qrQVHpPcndI/ZokzavOJgYTZ5NQn0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lkuhk1uGUVkx8ynkxMsLh9Wh2W3JMBVzBU8C0XQGTbXrs+/Q3hFcl6nffr4M6duSk
	 eQPvpZ6SXUY1+IhT3+VeNLJfIysDRLhduxBCECIjPAzyB0A8s6VaSgMifcSSeYaxQO
	 rbOlZP243IkvONJOqdXrG2lSgUqf4TIYc8dga/Lo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21C84F8016C;
	Mon,  8 Mar 2021 19:28:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43FB6F801D8; Mon,  8 Mar 2021 19:28:26 +0100 (CET)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
 [209.85.166.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A08BF800ED
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 19:28:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A08BF800ED
Received: by mail-io1-f47.google.com with SMTP id o11so11043801iob.1
 for <alsa-devel@alsa-project.org>; Mon, 08 Mar 2021 10:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pkbaxNzQLHArH8DUwfUMp/Z2ylGM8hVdhjO/fky3lKY=;
 b=o3BLax5hMMZ06aYWKYcCjnjMzuuz+XTG577KhY/bmGrG8ZGx5TXNaN8iaoyC/wXT+5
 THGdgaaEoBmshEWr+0zAGzF/u3mqhkRCr02rJSQxa4FdJvQyuKpbILZ2ktDbleI1jr6Y
 VWYJZZW+uQ8ELaSkMTz1M2GmDuQxiPajG0qDxK4X1GOEsK49ZNywv2oKP4yevRFc1P7T
 kq2HkV66+3xkqC0nb8GS9al2tKZU018Xp9UP3wUx22OhbPsGIwgYYst84eWdJzBFm/4Y
 Rh8hA/t7rpaxaBMgQZ7v5fDName7TcFLRD4sXw+wQjczxjQhRZzs2ehiN8IzTXpaxAmB
 n89g==
X-Gm-Message-State: AOAM530eY9CD0YjzGrhpohz3LXLAD5WAkfA5HLuPgSuY2r6XTU1si9na
 xgjjawNWtFOXyx3Fgs5Etg==
X-Google-Smtp-Source: ABdhPJwHpA3KqP1fPZljP8jc9FSfl2zbrcPXoTUukx/3q5TeueaKiHX7Zmok4sIN9ZPnBHSUD+MSeA==
X-Received: by 2002:a5d:81d1:: with SMTP id t17mr19944894iol.208.1615228095353; 
 Mon, 08 Mar 2021 10:28:15 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id o19sm6449916ioh.47.2021.03.08.10.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 10:28:14 -0800 (PST)
Received: (nullmailer pid 2746923 invoked by uid 1000);
 Mon, 08 Mar 2021 18:28:12 -0000
Date: Mon, 8 Mar 2021 11:28:12 -0700
From: Rob Herring <robh@kernel.org>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH v2 7/7] ASoC: convert Microchip I2SMCC binding to yaml
Message-ID: <20210308182812.GA2746864@robh.at.kernel.org>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
 <20210301170905.835091-8-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301170905.835091-8-codrin.ciubotariu@microchip.com>
Cc: devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, broonie@kernel.org,
 nicolas.ferre@microchip.com, lgirdwood@gmail.com, tiwai@suse.com,
 ludovic.desroches@microchip.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 01 Mar 2021 19:09:05 +0200, Codrin Ciubotariu wrote:
> This patch converts the Microchip I2SMCC bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v2:
> - moved from the beginning to the end of the patch series;
> - includes the changes (to yaml) from the rest of the patches that
>   update the DT binding;
> 
>  .../bindings/sound/mchp,i2s-mcc.yaml          | 108 ++++++++++++++++++
>  .../bindings/sound/mchp-i2s-mcc.txt           |  49 --------
>  2 files changed, 108 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
