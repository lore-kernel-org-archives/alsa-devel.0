Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47EBC55183
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:07:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AC42078C
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="apFfYs5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AC42078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC43B1680;
	Mon, 20 Apr 2020 23:06:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC43B1680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587416836;
	bh=eJI8SaHUVitkkNN3aDf1BFV7eBtN5QCsq3lm3QLB/S4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=apFfYs5nokalETdwGQSmBZpbgC04MyYOaQ6jNjgRkIrDjxO6LXrEPvtM9xvX7KTrb
	 EPI8LuIk2k7nmIqQNkvqzDPnbIAVBtaUe/U7Y9VnXXAg+tGBrGjWBdkIgtqeh6qs9w
	 kTzb4d0v4VP4Tdwh7cDAxc5g1h079MvidTybMYqc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 397DAF8013E;
	Mon, 20 Apr 2020 23:06:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F2A7F801D9; Mon, 20 Apr 2020 23:06:24 +0200 (CEST)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41DD4F800E7
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 23:06:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41DD4F800E7
Received: by mail-ot1-f66.google.com with SMTP id i27so9416970ota.7
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 14:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uB24L/EHWMUmjNtmjWGehiMAvY3CkKcJfhSvIbdPK9U=;
 b=ZJ6vMKZ5zdYSGAJFNMg1+j0Atb5AkgWCCIYXk9uM7GMm4wK1Q1Q5nPfVRM3FjrXCID
 q35Y4T8qrLjARF/csNKLuUTyKhkkmJLZJhIg46MdA57LJgHEffLZTVjEEwNHmWpStTtp
 q9uOo+cDYjW1zjZZ4/dPbyt8JqngO8kZg1oOmAjxEBLw/0gF3o5kEQ3/PKLcJi83t/zu
 8mgaRCs1WqJKENWRRO6zadEq9m1Jcvn1vrx9/fMrl044Q0QWw7r3/+xniFPaI3aVxcRM
 ftp07jjsVzOlrMunPsAyHzNjBey38qYOMujxsOPLQM3Yfi/lURj/1Dhb3/GX6TPghpaV
 44Uw==
X-Gm-Message-State: AGi0PuY1+T3yqXuiL5nTSf70+FHoophVS1xIiLtxh/xzM0sH4JMRAso3
 50S/A03RzMKEePY2AiDJgA==
X-Google-Smtp-Source: APiQypJ61QuLn0gRFwjv7tBbNaZhcCNVOe5uH4hWnq+9Kov3OqipkZNTDsd+9hUszKj/zQnlos6E3g==
X-Received: by 2002:a05:6830:1b65:: with SMTP id
 d5mr10613823ote.141.1587416771097; 
 Mon, 20 Apr 2020 14:06:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 33sm205505otn.50.2020.04.20.14.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 14:06:10 -0700 (PDT)
Received: (nullmailer pid 28621 invoked by uid 1000);
 Mon, 20 Apr 2020 21:06:09 -0000
Date: Mon, 20 Apr 2020 16:06:09 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v8 6/7] ASoC: dt-bindings: fsl_easrc: Add document for
 EASRC
Message-ID: <20200420210609.GA28583@bogus>
References: <cover.1586845137.git.shengjiu.wang@nxp.com>
 <396a73da2a2fa8b77d0b773d321500b3e504d919.1586845138.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396a73da2a2fa8b77d0b773d321500b3e504d919.1586845138.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, nicoleotsuka@gmail.com, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Tue, 14 Apr 2020 14:56:06 +0800, Shengjiu Wang wrote:
> EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> IP module found on i.MX8MN.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,easrc.yaml  | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
