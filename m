Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3951C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 02:59:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388952075F
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 02:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EsLtXNVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388952075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DEC51755;
	Fri, 29 May 2020 04:59:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DEC51755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590721194;
	bh=vHl7MtUtMB049QR3RJzoF4LPTtbcjRmk+Xv5R0hoO7g=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EsLtXNVHEcZGRlKg8GfmtGLY7+EKlSSMvLF56BuyHFW3RV9FsjlXRmj0O3GEsEWRl
	 6uUJ4kw3L/PY0W6z+Exr7hIeHHfw7imEFy6rjBa6rIwY5y1ZLuCOlk5xrPLyL+3Xom
	 HVv+wt4SS920OdLzVgh52IhZ0oqZRBC5NTvTsf5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3AB2F80107;
	Fri, 29 May 2020 04:59:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20D8DF8014E; Fri, 29 May 2020 04:59:01 +0200 (CEST)
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8C6DF80107
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 04:58:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8C6DF80107
Received: by mail-il1-f193.google.com with SMTP id 9so1013539ilg.12
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 19:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m6kcwlIC7SKtx9thDsfIOgDZfkogbuD8SNG7gHAFV2g=;
 b=Llo6zYiKATYDkDE7wu74XeWzBH5iFUt0FxS0Sv/W5t13pUWSEGUp5anepA4LOnJw6O
 6ZGcrGXL270VmMS2CO1AwgipvlUE6qihpnZT+9ZXGiy/ObAX3Bms2yxORbI68gXboCPm
 GSqsnb5nVEqvLa+ybFCiwEk+eD387wzcF2/UlnH/ZNYy8GEBa0PHCVIecdeiLFpv4aDN
 JX/KyXkleZHLmS6Um6HawWFUUyvNO6O1urXxviKEGKqLj+1iEEzutgXtr+OwdY2SQRuX
 tp4yVLE5mbdin2rkM9HL16R+g1j2QyvZDrbgFyefhLsDDTiVuw61NDSz8iPEm+JnuNb6
 ME4w==
X-Gm-Message-State: AOAM5331Ngf93vD9dzRQZgoklZkGOXCeUqDe/oLozNhAkjDjlKBpHoOf
 ccxAiJsPj5pxwjCwkEyO8w==
X-Google-Smtp-Source: ABdhPJzvfcF83aDlvSVv+tXYOmvv+ugf8LjGNXP4oxa2f48ct9MiDm/qpBCJ2AWztc8Ety30ZSqprg==
X-Received: by 2002:a92:9c04:: with SMTP id h4mr5267706ili.190.1590721128061; 
 Thu, 28 May 2020 19:58:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id p75sm4101531ilb.23.2020.05.28.19.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 19:58:47 -0700 (PDT)
Received: (nullmailer pid 1186722 invoked by uid 1000);
 Fri, 29 May 2020 02:58:46 -0000
Date: Thu, 28 May 2020 20:58:46 -0600
From: Rob Herring <robh@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] dt-bindings: sound: tlv320adcx140: Fix dt-binding-check
 issue
Message-ID: <20200529025846.GA1185629@bogus>
References: <20200528144711.18065-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528144711.18065-1-dmurphy@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
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

On Thu, May 28, 2020 at 09:47:11AM -0500, Dan Murphy wrote:
> Fix dt-binding-check issue
> 
> ti,gpi-config:0:0: 4 is greater than the maximum of 1
> ti,gpi-config:0:1: 5 is greater than the maximum of 1
> ti,gpi-config:0:2: 6 is greater than the maximum of 1
> ti,gpi-config:0:3: 7 is greater than the maximum of 1
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/sound/tlv320adcx140.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the quick fix.

Reviewed-by: Rob Herring <robh@kernel.org>
