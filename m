Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F977C4320E
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 16:59:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367966187C
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 16:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 367966187C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A0651616;
	Tue, 24 Aug 2021 18:58:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A0651616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629824381;
	bh=kaIBwYNCSfhBm+neIod2xhdzpEPNBc1CTBjCF5x0Lt0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vOW8+b6ALGMAHdIhgWARBoL8/Doe3Hihj/EYNeG7m/6gQjn66qnLy6qhUGzh6eY1O
	 WRulX9JCETL2724jaTRYPr2H9mSuEXPULznR20w27iVWvBASn3ol7utBPex9ytvrJp
	 wXfFI3k3LW9RpL7uxG3TwXQeQh7unqjujgn0sEDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF8CBF801D5;
	Tue, 24 Aug 2021 18:58:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A118F801D8; Tue, 24 Aug 2021 18:58:49 +0200 (CEST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4353CF80171
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 18:58:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4353CF80171
Received: by mail-ot1-f52.google.com with SMTP id
 c19-20020a9d6153000000b0051829acbfc7so47823719otk.9
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 09:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gLpwSrgDVrehm6j3+KekuLUcZGEgcjkIq/MzS6C4s2Q=;
 b=XNBMr4oyysm3zchI7DHoeNB5/BhmNBRRtoXD2jKVvol5KOffJEnDivOF06TSrqe0nG
 d3TFVUme/rQBq6Wu0rj3atkHkFlEEzAyZWbf0hZ0d27GmGea6X8vcA7QXluQKBsN0yWC
 rlKzb6H50bulx7gzkaxEoEegI1DVVzAp/zOmrjTdUqi/ub/yhzYzUfWiJrWtNWsXwFdU
 KVXU6HtUQot+iFlaYGs+QfRhiNtkLgqMlAXWN/60vCsBcOp0go6luGzXyMDQszzQ0lGS
 fZTqAAjjSavWWFvCEvpsbpQtThDvKFh2s/O4wS7rL1bDrCXtsEor59cRJwyafnmfi7kX
 gcgA==
X-Gm-Message-State: AOAM530BK/DiDjM+euT2R5I4ktOhShGV6fSn5AaykOo97Ye4+Tms3PLc
 CGw/uZB+86xgdJpskr5txg==
X-Google-Smtp-Source: ABdhPJxznu0po8jvGOG/R35j+O3vsQwjCgnWz2hyBX4naV/clJHvdyP+gZ5KOtm8KTStXZyLTR4ZRg==
X-Received: by 2002:aca:aa88:: with SMTP id t130mr3493936oie.3.1629824318887; 
 Tue, 24 Aug 2021 09:58:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id v5sm4172939oos.17.2021.08.24.09.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 09:58:38 -0700 (PDT)
Received: (nullmailer pid 625890 invoked by uid 1000);
 Tue, 24 Aug 2021 16:58:37 -0000
Date: Tue, 24 Aug 2021 11:58:37 -0500
From: Rob Herring <robh@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v1 6/7] ASoC: dt-bindings: rockchip: pdm: Document
 property 'rockchip,path-map'
Message-ID: <YSUlPU+yxepPrcvL@robh.at.kernel.org>
References: <1629791446-13528-1-git-send-email-sugar.zhang@rock-chips.com>
 <1629791656-13698-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629791656-13698-1-git-send-email-sugar.zhang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
 broonie@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org
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

On Tue, Aug 24, 2021 at 03:54:15PM +0800, Sugar Zhang wrote:
> This is an optional property to describe data path mapping.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/sound/rockchip,pdm.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
> index 54d94438..b2d7e47 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
> +++ b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
> @@ -24,6 +24,22 @@ Required properties:
>  	     pinctrl-names. See ../pinctrl/pinctrl-bindings.txt
>  	     for details of the property values.
>  
> +Optional properties:
> +- rockchip,path-map: This is a variable length array, that shows the mapping

The schema says this is a fixed length array.

> +  of SDIx to PATHx. By default, they are one-to-one mapping as follows:
> +
> +   path0 <-- sdi0
> +   path1 <-- sdi1
> +   path2 <-- sdi2
> +   path3 <-- sdi3
> +
> +  e.g. "rockchip,path-map = <3 2 1 0>" means the mapping as follows:
> +
> +   path0 <-- sdi3
> +   path1 <-- sdi2
> +   path2 <-- sdi1
> +   path3 <-- sdi0
> +
>  Example for rk3328 PDM controller:
>  
>  pdm: pdm@ff040000 {
> -- 
> 2.7.4
> 
> 
> 
> 
