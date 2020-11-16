Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5E6C4742C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 17:00:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F2020E65
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 17:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YY4RqOVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F2020E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C81A1738;
	Mon, 16 Nov 2020 17:59:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C81A1738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605546026;
	bh=pv7h6bCA27Ern67tID4XCKwPb2K4maENI6Z69GZzsOE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YY4RqOVcb/5HUAPATw2iJzEoAFQnIQtXYfys4AlYqTrvd3Ha5WjDh54iD6wL29qS6
	 nCV0ur1fubZgp3O4lpKezzPEOVHdraAzzlS9edRpTGL5bGHaVKUnd750MInKbDSrXa
	 GAQZSpS8UoPOvNN9o8W66VIFJJG8ZIFHZEqD0Rd0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D865F80167;
	Mon, 16 Nov 2020 17:59:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F8B7F80167; Mon, 16 Nov 2020 17:59:33 +0100 (CET)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FD8BF8010A
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 17:59:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FD8BF8010A
Received: by mail-ot1-f66.google.com with SMTP id y22so16668026oti.10
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 08:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gPm6sA9oRClgJ6QfZp27nZDmEP+LS+OgTAXUUaGYMo8=;
 b=PoaQRd2pJGfNgqQmt7flaMmnw8SFNiztA7Y1fh9t2tloVRmAqYyegGy6L/eJZAZfIq
 +FhPvlTWKyBOeiuMPenR0ir95VlOtr6fx7L6+bq7iuIV9Gg/rxqr1IVZ/9eCcOPz06U5
 EiGB2Viq9zmCv7kweZd2hAuithdjo5CN9W8qDVqGh7cfjASD4vN5D+rJ/qE4Gi8WtaFm
 c0LgIIEwooNw95I26/fy8Nnbahz60mGsJFztLK7j+Ykz8ne7Sepcaw26pOk1M8A5NF6o
 ABTDDySh4t7P/lr07amKY1gMDKg8FLu2mvpi5rQwYAU+1f0PHoBrIvWUgIblkYmAx9Lr
 5R8Q==
X-Gm-Message-State: AOAM533AefRYjMH7kANuPBYxWooiv7egl88z69Sw4jHMPX96BtkZzBHm
 GChl9oFX5pYew3ZPOw24eg==
X-Google-Smtp-Source: ABdhPJzHMBn693UwxypsTfTm45fxNBdSjJ65WWD0gGtLKkeCDqW0MqxiCMCZuQZCn4s/O1X/I1R23A==
X-Received: by 2002:a9d:222f:: with SMTP id o44mr128581ota.321.1605545961368; 
 Mon, 16 Nov 2020 08:59:21 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x1sm829638oog.41.2020.11.16.08.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 08:59:20 -0800 (PST)
Received: (nullmailer pid 1804579 invoked by uid 1000);
 Mon, 16 Nov 2020 16:59:19 -0000
Date: Mon, 16 Nov 2020 10:59:19 -0600
From: Rob Herring <robh@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2] dt-bindings: adau1977: convert text binding to yaml
 format
Message-ID: <20201116165919.GA1804532@bogus>
References: <20201106102052.32582-1-alexandru.ardelean@analog.com>
 <20201110084754.46756-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110084754.46756-1-alexandru.ardelean@analog.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 lgirdwood@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 broonie@kernel.org
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

On Tue, 10 Nov 2020 10:47:54 +0200, Alexandru Ardelean wrote:
> This change converts the old device-tree binding for ADAU1977 from text
> format to the new yaml format.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Changelog v1 -> v2:
> * updated libraries to catch newer schema errors/warnings
> * fixed examples, added i2c & spi nodes
> 
>  .../bindings/sound/adi,adau1977.txt           | 61 ------------
>  .../bindings/sound/adi,adau1977.yaml          | 92 +++++++++++++++++++
>  2 files changed, 92 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/adi,adau1977.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1977.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
