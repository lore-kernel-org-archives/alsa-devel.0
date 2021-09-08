Return-Path: <SRS0=cWdV=N6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5504C4332F
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Sep 2021 12:00:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BBD61100
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Sep 2021 12:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8BBD61100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F4F51678;
	Wed,  8 Sep 2021 14:00:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F4F51678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631102451;
	bh=EucDs045bpM90Ue4vuYW/OnMzFfxwabUdpjlHq/GeMI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cxhEY8EuCeMrYRCeFcHO0qKmPyN7kXfrM3hgYU16TheKxJJUCeeKYX6ud347P+9F8
	 TdMsSqZDz7CESG4Sp06BE6aL40hVbF0ipvxw9NMJbt3AclncFMZ/GpMCeQjeMKeSsX
	 zRi7xLAf/4KhhegyqjVrog1sMeYV9+3HEisI2pgo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE4E2F804A9;
	Wed,  8 Sep 2021 13:59:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B446F804B3; Wed,  8 Sep 2021 13:59:56 +0200 (CEST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3550EF804A9
 for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2021 13:59:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3550EF804A9
Received: by mail-ot1-f41.google.com with SMTP id
 l16-20020a9d6a90000000b0053b71f7dc83so2531588otq.7
 for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2021 04:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T4PU4tWJUcseqPugoo0HufAKZOsFvcQVYr/eQZCWYQY=;
 b=sMONyh3RH06LJscEfP/I5N+CcAECiXuP/G/CigWOmgmw1cWG+z8OPMGJckivONnwKW
 zKyyEW4YXptEwPhwqDMAp+8orcHvFq3WP0kP8ZKgshUzZnVv6aTXjtpdLxZCFfDVI6fx
 TlY+vbNQgTIhra7Ksn81Wyf0c29pampNfcEIjI+f+eXfj7PUFbVCfs9XHFRaNtM70X2w
 RYgjN30IMk63k3q3ABkBIppcXiBWpzmg1Xs93frDycwOVTTWf344WxiVEiPWFSohjSyi
 B9rQ2kXDNzmGw19PhGRNP6eDSa7rbbI7eYQr4Gm9JP4B2vH647lVkw7d6kuc8JsWtrMG
 e44Q==
X-Gm-Message-State: AOAM532Lltp7nswXVlUVBHrDxRcaBEAo1bNe2LOfdQdDRhdhNfNtJlz/
 HWQeNQA80ogH+sEtctcHSA==
X-Google-Smtp-Source: ABdhPJxuHJ6yMrpw2gpAVb4IKjHUL2sPKiA67QNtUQ82sqhj9xVUipj26dRMHxVd/lFHOhcAXuahNQ==
X-Received: by 2002:a05:6830:2b0d:: with SMTP id
 l13mr2655859otv.39.1631102387599; 
 Wed, 08 Sep 2021 04:59:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id m2sm373098ooa.42.2021.09.08.04.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Sep 2021 04:59:46 -0700 (PDT)
Received: (nullmailer pid 1852019 invoked by uid 1000);
 Wed, 08 Sep 2021 11:59:45 -0000
Date: Wed, 8 Sep 2021 06:59:45 -0500
From: Rob Herring <robh@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v3 3/3] ASoC: Remove name-prefix.txt
Message-ID: <YTilsXG9j0UMz5BZ@robh.at.kernel.org>
References: <1630686919-19495-1-git-send-email-spujar@nvidia.com>
 <1630686919-19495-4-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630686919-19495-4-git-send-email-spujar@nvidia.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 stephan@gerhold.net, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, jonathanh@nvidia.com, broonie@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, jbrunet@baylibre.com
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

On Fri, 03 Sep 2021 22:05:19 +0530, Sameer Pujar wrote:
> Since schema name-prefix.yaml is available and references are updated,
> remove txt based doc.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/sound/name-prefix.txt      | 24 ----------------------
>  1 file changed, 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/name-prefix.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
