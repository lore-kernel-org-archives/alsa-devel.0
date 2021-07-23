Return-Path: <SRS0=VrYT=MP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5CEC4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jul 2021 21:36:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5F360EB1
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jul 2021 21:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A5F360EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 425E61756;
	Fri, 23 Jul 2021 23:35:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 425E61756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627076176;
	bh=9fp19cbvnV0/9nUgjdy63a69hNyPIe2vgt6d0Rzv9oY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fBIuah3Yt/P1nWexoidXXPdWkp/LZ2GpMWyudxLw+xgXyjGjATsMe2MOoaTlmgyxx
	 AvnXIMwFmpzspAwrwddFtJIJISNjJ7IJE4e5u5Z62E2eMNcUsLpxFooJwlcYezmQ3X
	 l+2N8JndDx87KYv/irZlopDfRwKwB7whm3tm05iY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCAFBF804AB;
	Fri, 23 Jul 2021 23:35:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92452F804AC; Fri, 23 Jul 2021 23:35:23 +0200 (CEST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
 [209.85.166.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BA1FF80086
 for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2021 23:35:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BA1FF80086
Received: by mail-io1-f49.google.com with SMTP id l126so4144683ioa.12
 for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2021 14:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XlIq9sgkpH0VLjxnlc9KkJaSod6wixszIJrzFBohWBQ=;
 b=gYGe8uo+w9dGpF456xoOOQ3Yqfgbt9tMcfBXF4XYdZ1Fo6wJpKFH0h+VJ4TkvjKTZg
 QPmZOUzI3I4oettU/H/+W+c9hZsA1jS2SKI6SYFo7zv2hdQDHqoh1uvh9IccukZiv2u7
 2p4wc0DaylaIoFTwiyy0u1zFTFeGEBg4dAweIthsrQJ+7L7soE8FSSYz2WdGUuItf9JC
 bOOMtRsOiKSqj25k9hrxGRD5NU4O/hJ+tQ9OfGH8hk3Tea8Z6vU6ALCfwBElsGYXMMze
 jKA22usypxoHSDvv5ILpt6EAJj6QilLDO/siU4/O+vwO+FfxZsr5wSDxE6q8E8i35fLB
 nywg==
X-Gm-Message-State: AOAM5335ROAj3gIJ8YrfFRhmHtJ38YtGcbPJOLtD1vIoofdr+YLvQrj+
 LQxClsbdY97H8FAhgS0LZw==
X-Google-Smtp-Source: ABdhPJxm3/7JByYULNQVHzHLMkbguEpYVWROlSg6OC5iWccT709JPbbBrofXe/hc2B8/npGbI/nOeg==
X-Received: by 2002:a02:620a:: with SMTP id d10mr5911026jac.22.1627076115287; 
 Fri, 23 Jul 2021 14:35:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id z18sm8442819ilh.55.2021.07.23.14.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 14:35:14 -0700 (PDT)
Received: (nullmailer pid 2628990 invoked by uid 1000);
 Fri, 23 Jul 2021 21:35:11 -0000
Date: Fri, 23 Jul 2021 15:35:11 -0600
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 03/54] ASoC: dt-bindings: Convert SPDIF Transmitter
 binding to a schema
Message-ID: <20210723213511.GA2628924@robh.at.kernel.org>
References: <20210721140424.725744-1-maxime@cerno.tech>
 <20210721140424.725744-4-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721140424.725744-4-maxime@cerno.tech>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-sunxi@googlegroups.com,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, 21 Jul 2021 16:03:33 +0200, Maxime Ripard wrote:
> The SPDIF Transmitter binding is used by Linux with a matching Device
> Tree binding.
> 
> Now that we have the DT validation in place, let's convert the device
> tree bindings for that driver over to a YAML schema.
> 
> Cc: alsa-devel@alsa-project.org
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../bindings/sound/linux,spdif-dit.yaml       | 32 +++++++++++++++++++
>  .../bindings/sound/spdif-transmitter.txt      | 10 ------
>  2 files changed, 32 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/spdif-transmitter.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
