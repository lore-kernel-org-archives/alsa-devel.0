Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA20C433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 20:38:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600DD61132
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 20:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600DD61132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16D6B165D;
	Thu, 15 Apr 2021 22:37:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16D6B165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618519097;
	bh=TAZOJGZ+XH5bNYJunJnHkE8I9CwaSaw05mIdDwS99pQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lRyue4NQLWnR0Dv2kK41M+Qf9phTggKy5fT/QyATsSgQ15DEVMagJl3AL0usDqQiZ
	 FmfyVR7ri6NBQHQ6nEzJh+p54Mxq9Q/sajheDbZRPpajd7k+H+7T+ndKetwSx5xdqd
	 n++p6oWnv8H93av8AC/Nub/LvMJA8s0G+q5ughQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24837F8032D;
	Thu, 15 Apr 2021 22:36:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B63A3F80423; Thu, 15 Apr 2021 22:36:37 +0200 (CEST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B5E8F802E3
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 22:36:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B5E8F802E3
Received: by mail-ot1-f50.google.com with SMTP id
 w21-20020a9d63950000b02901ce7b8c45b4so23787175otk.5
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 13:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TVWoOZSHf10Y+tHRIXNRspTGFjz0DsA6m8OWQyKDUOI=;
 b=U+3VQAXZMqQr3wQlXl9Y0RiLQd0YiJ/WijBDGdYrbZgG01ZBRXPuFtiMUFEy1AbhIm
 E2ojqsYi2Fo21DKO79bnTLUnmZ9ybpX22lOoovuoKpF56Me7uXAcGXly4u+pXgTz2Mdz
 0UGxwmzI1xj3NH//ZQWkp+6zPvtgO9pbqZzC0G9BeNhEZzoW2DxivMukNCuz+hcOUM33
 FS9Bk6LaP3i2Va3ziUQyFx4p/SgholxHrFNBqQyDtFi/9mSGh58qV6nEv+TGZHUbokWK
 2iQOBv3QDmPQqGp3gnGYhsHwqYyUiGZeGFrWH5fFA3KexfGAmHRb6vL0sXFJaK+mj9U+
 SrvA==
X-Gm-Message-State: AOAM531brKQBgFqAUq8Wfi9G9lRg9rNO9U30SiT26rmkNw4msQ0SkWIs
 N0OL3KJU0pnXUVtpYUrVUaHbDkVHMg==
X-Google-Smtp-Source: ABdhPJyD2gFCR2X0gACDKiW5lZzJttoGCo7WmNjMCtGp8RuwEVLfYupRV5at1oHQGVdJGFD11C4gLw==
X-Received: by 2002:a05:6830:1e10:: with SMTP id
 s16mr867100otr.28.1618518988676; 
 Thu, 15 Apr 2021 13:36:28 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id h25sm754218oou.44.2021.04.15.13.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 13:36:28 -0700 (PDT)
Received: (nullmailer pid 1840238 invoked by uid 1000);
 Thu, 15 Apr 2021 20:36:27 -0000
Date: Thu, 15 Apr 2021 15:36:27 -0500
From: Rob Herring <robh@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v3 2/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'ports' does not match any of the regexes
Message-ID: <20210415203627.GA1840177@robh.at.kernel.org>
References: <20210412100638.3349-1-thunder.leizhen@huawei.com>
 <20210412100638.3349-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412100638.3349-3-thunder.leizhen@huawei.com>
Cc: devicetree <devicetree@vger.kernel.org>,
 alsa-devel <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

On Mon, 12 Apr 2021 18:06:38 +0800, Zhen Lei wrote:
> Currently, if there are more than two ports, or if there is only one port
> but other properties(such as "#address-cells") is required, these ports
> are placed under the "ports" node. So add the schema of property "ports".
> 
> Otherwise, warnings similar to the following will be reported:
> arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dt.yaml: \
> sound@ec500000: 'ports' does not match any of the regexes: \
> '^rcar_sound,ctu$', '^rcar_sound,dai$', '^rcar_sound,dvc$', ...
> 
> A given binding should just use 'ports' or 'port' depending on it's need.
> Both are not allowed at the same time. The check is done in "allOf".
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../devicetree/bindings/sound/renesas,rsnd.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
