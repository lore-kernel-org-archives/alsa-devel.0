Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A3DC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 01:08:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401556135F
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 01:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401556135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD4C51669;
	Tue, 18 May 2021 03:07:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD4C51669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621300105;
	bh=BECYvRhIR/B9jVAnv6QeyFYpeL0mEwzitw9UxYfmH8c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TJJyjV/CuUyudLRkt8ektCsSik8DJ4w+1WjthVB6vV8yjjK15WhG2mX0YJZi2xoJi
	 HiOgt5f41BINIrxjt9MI0I1gDp3/bD2WH/xx3/JRqX1U6XfYQwPbzaI3BStJDR6x0B
	 xDwEf86DXfO05WotIdvkqCnapSp7gR6LYZDVALzY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63DC8F8016E;
	Tue, 18 May 2021 03:07:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A13BDF8020B; Tue, 18 May 2021 03:07:33 +0200 (CEST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC7ECF80082
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 03:07:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC7ECF80082
Received: by mail-ot1-f52.google.com with SMTP id
 n32-20020a9d1ea30000b02902a53d6ad4bdso7241017otn.3
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 18:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=RSWBFgh4U3fXaI0FPGkNU81cGV7B7UdUHy8FTnRJEgc=;
 b=rS8pB271QJbfOQhgHLG5ls/5HsQvcyxsalMDgorOSMW9QxTOgJddxMTVLzkoi1hWIS
 IHoo/PcMN5VZwlUwxI3uGX6nRJiagxggjnMndL9v5evY9m2Ul8cclma0MqBL+jHM8yyj
 jG6k0NvXcFskBVSZV5xGrDLzr4kDlJCeY9ts2lLgM9zPhLqlVTwg2JNlUdYhd2xv58z4
 MRA2kDUqyy481nC1ndybMPwiO9g7NZNWzPHnNfiT8054nffzv8q/ic3RbHTtUqtKwPcJ
 j+5JlkIoj0opNN8RjyHEsbOR+iYvueGqby02ykgNydZnVclYKbJLJsVxJr1UaWgZmrn/
 2j6Q==
X-Gm-Message-State: AOAM532Rjst74ue9SDWfFukrNgmxTgkPb/6fo9hYmSWjeAUsOz3N7Lxm
 hhBcqEYoj3Qa/X84OvAKTw==
X-Google-Smtp-Source: ABdhPJwO+xckwuD8LWIwNzuBekxk2H6l0hAMeJR5B8q5WM1RQ3tznp9OjEdrNVb7txFADpm++jo7wg==
X-Received: by 2002:a05:6830:4014:: with SMTP id
 h20mr2056453ots.62.1621300045034; 
 Mon, 17 May 2021 18:07:25 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id q2sm3397487ool.3.2021.05.17.18.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 18:07:24 -0700 (PDT)
Received: (nullmailer pid 3567313 invoked by uid 1000);
 Tue, 18 May 2021 01:07:23 -0000
Date: Mon, 17 May 2021 20:07:23 -0500
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] dt-bindings: sound: wm8750: convert to the json-schema
Message-ID: <20210518010723.GA3567261@robh.at.kernel.org>
References: <20210512205926.780-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210512205926.780-1-zajec5@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
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

On Wed, 12 May 2021 22:59:26 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/sound/wm8750.txt      | 18 --------
>  .../devicetree/bindings/sound/wm8750.yaml     | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8750.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/wm8750.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
