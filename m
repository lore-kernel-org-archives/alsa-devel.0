Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66100C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 17:42:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B6801F0A;
	Wed,  2 Mar 2022 18:41:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B6801F0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646242949;
	bh=w/4wgRYJN343CLyLLi5ba5uHNeby0o/MRmCREA97fNY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xi9+IfGJYw8N22Fm74G5QjiQ8X+wBvLY6iBA0lxxjLhtZR3z0nARVYP8ykE5y+Y0I
	 wbtMO6EYOnF31lI8wUFopu6EGyeEZPv29b36a9zOM06nXDZoayDR/AGP/aOG9kJ6Wd
	 4r4BrT27kC+/BIyRt45WlcLLVsc/age5CTb2onrs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89207F80171;
	Wed,  2 Mar 2022 18:41:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F12A2F801D5; Wed,  2 Mar 2022 18:41:36 +0100 (CET)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8B20F80154
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2022 18:41:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8B20F80154
Received: by mail-ot1-f51.google.com with SMTP id
 k9-20020a056830242900b005ad25f8ebfdso2291397ots.7
 for <alsa-devel@alsa-project.org>; Wed, 02 Mar 2022 09:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6IxKBTtEzw8gh7TxlNKKlosnx/4N4oHWRoIc0tYEz0g=;
 b=2M0HpwU177RUuYQLknS5PqdDbSAJm1wpo7r3gcfijxFuBuooH9sJms1ksfqZCcZFL/
 qdGFWzKwt8oQhGgT558WvbVDErcVX3SkcZ1rxsgV/A17ZWjXNhhNeMyIwCCpdVZsrh9T
 jKNzWLcZ2VBwAPC2R3j0Y8neyaz27waLpolLhgpEykUyBcuViM6pNUYWZX+aktHXsh7x
 oS795teEI6aNZH6hjT91SxhGhPXzNZmr8hAWTjbH1Fdq32AbvRYowxj+wUXK5vJIWSke
 YLN8l2sAlBLa1u838qXTMYQd8fkqqEzDzp08Pc59b/lPQz599UWw/UrHFSTyKwD8Y7tT
 bviQ==
X-Gm-Message-State: AOAM532C85B7hdMgW1qXQkcKgylI3nHK3av8xVYtZmkBLr6ZUOVu+isK
 GzYXt+npHEWy7NJY+QQUEw==
X-Google-Smtp-Source: ABdhPJz3HvtB/9nZ9y7vb8pIEBLrCJ2Y7Sw6RsXgoFqpwwNdFPpxjRViFygumN6TFDWeQkduH6QHww==
X-Received: by 2002:a9d:7845:0:b0:5af:39b7:ff32 with SMTP id
 c5-20020a9d7845000000b005af39b7ff32mr16742817otm.8.1646242884726; 
 Wed, 02 Mar 2022 09:41:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213]) by smtp.gmail.com with ESMTPSA id
 w15-20020a056830144f00b005af6bad7fb0sm8156248otp.68.2022.03.02.09.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 09:41:24 -0800 (PST)
Received: (nullmailer pid 3939788 invoked by uid 1000);
 Wed, 02 Mar 2022 17:41:22 -0000
Date: Wed, 2 Mar 2022 11:41:22 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH v6 3/3] dt-bindings: soundwire: qcom: Add bindings for
 audio CSR reset control property
Message-ID: <Yh+sQjCRWsPRqCD3@robh.at.kernel.org>
References: <1646224982-3361-1-git-send-email-quic_srivasam@quicinc.com>
 <1646224982-3361-4-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646224982-3361-4-git-send-email-quic_srivasam@quicinc.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, yung-chuan.liao@linux.intel.com, vkoul@kernel.org,
 linux-arm-msm@vger.kernel.org, swboyd@chromium.org, tiwai@suse.com,
 agross@kernel.org, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 rohitkr@codeaurora.org, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 quic_plai@quicinc.com, sanyog.r.kale@intel.com, bjorn.andersson@linaro.org,
 judyhsiao@chromium.org, Venkata Prasad Potturu <quic_potturu@quicinc.com>,
 linux-kernel@vger.kernel.org
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

On Wed, Mar 02, 2022 at 06:13:02PM +0530, Srinivasa Rao Mandadapu wrote:
> Update description for audio CSR reset control property, which is
> required for latest chipsets to allow software enabling in CGCR HCLK register.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
