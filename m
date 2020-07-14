Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C0AC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:23:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D759D20791
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HtTNuuOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D759D20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 675701612;
	Tue, 14 Jul 2020 04:23:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 675701612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594693435;
	bh=miNMxiHmvHy3bPnk6VBibo6+2Qzrq/VkmOMGZpbqU4U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HtTNuuOnUqd2VmptHC0YdNi111Zv73CyYaQUxqqfLDr32VBLFJh94Pkf7dSeGH9/v
	 ovjAwOVss66P3pCmkF1ZbC0ukA1K12V/wNuNSJxwOx7VhuML9L67+rNgqhK48QT7+1
	 +HfyWmjKHZ7RDuTygoaRayNnn5YJnp0Ts5lHL84k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 066AFF801EC;
	Tue, 14 Jul 2020 04:23:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8BE5F801F2; Tue, 14 Jul 2020 04:23:03 +0200 (CEST)
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF304F8016F
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 04:22:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF304F8016F
Received: by mail-io1-f68.google.com with SMTP id l17so4212170iok.7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2020 19:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E9zs2BSIxknKvmLl7LMKCsZ/1jQO+w7iUmtbgUR1KY0=;
 b=t8eB/sxFv4lwbnxRqMc8u7VebqclsTTs3CCr7DK6S8c3Aqwam4Ijk+Ui6UBw3wlSW1
 YA03HQhC4cutNWsWb54dhK630ZqiUudQ4FRm5EJBewCgDLMsI7yePKiyHfYC2O5OQAkO
 c4mtKPzFKUK5rvL1JnC1YLKT4658/Cz4TZ82FC3KSbMyDZRnqyzsL2JKS2Qg5oLk17e5
 3sB+WwPP5D1BJ6kxvgmbbGNpCirK+8drMRrOHntTJWEKNqbaxiOzqXTn/dAOwLdRDIrR
 Dl7m5trkErr7IyuIwXJcr2yRc6HUSdGN7R2ueuaQjXMlF2V8W+RN+z+/SCbocAgYxTsR
 Oo1w==
X-Gm-Message-State: AOAM533UiUCVDMxA1GT7EHOoSuQ+2ZTqUFiLIr9orpnJI7k8e9R9xdCP
 SbzadIBbvR6mZ+9J6jC2dQ==
X-Google-Smtp-Source: ABdhPJzhWC9AKojuZk6j40YEWnleK5Ux6idoUrgJeNbKK3ONpxXf28xo2JdvFtsu/J7oIlPUbgRQ2w==
X-Received: by 2002:a6b:6c09:: with SMTP id a9mr2750394ioh.178.1594693374184; 
 Mon, 13 Jul 2020 19:22:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id h5sm8908133ilq.22.2020.07.13.19.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 19:22:53 -0700 (PDT)
Received: (nullmailer pid 1151513 invoked by uid 1000);
 Tue, 14 Jul 2020 02:22:52 -0000
Date: Mon, 13 Jul 2020 20:22:52 -0600
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to
 json-schema
Message-ID: <20200714022252.GA1151466@bogus>
References: <20200623114005.791643-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623114005.791643-1-yamada.masahiro@socionext.com>
Cc: devicetree@vger.kernel.org, - <alsa-devel@alsa-project.org>,
 Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
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

On Tue, 23 Jun 2020 20:40:05 +0900, Masahiro Yamada wrote:
> Convert the UniPhier EVEA sound codec binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Add schema for subnode 'port'
> 
>  .../sound/socionext,uniphier-evea.yaml        | 70 +++++++++++++++++++
>  .../bindings/sound/uniphier,evea.txt          | 26 -------
>  2 files changed, 70 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
