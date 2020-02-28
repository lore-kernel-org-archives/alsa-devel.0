Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070A6C3F2D2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:09:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8711424699
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="irjXSR4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8711424699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5FCA16C8;
	Fri, 28 Feb 2020 16:08:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5FCA16C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582902583;
	bh=HHwEYyDSEKdV6Xycj4HlJPneyj3PZUumbO+wq7TktNg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=irjXSR4NdHPaDvBmUA6YkxXt5fQer3mfzlkF7GPi8Fl5rNd8uuD9zZnlnYjrL0eQp
	 jlyhS75EKJrjCXfh2MPLMulBCvbMiftL9CRcRUFDBBQO6y16Fk79+wnyDWypAxDFM6
	 qRC3MzCy9y+f81vXeke6SddCCM2KLQ8iQwDuE+c8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A144F8014D;
	Fri, 28 Feb 2020 16:08:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D298F8014E; Fri, 28 Feb 2020 16:08:51 +0100 (CET)
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68249F80089
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 16:08:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68249F80089
Received: by mail-oi1-f195.google.com with SMTP id j80so1120474oih.7
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 07:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GrxfLKNeb7VX7iUvU68jTNFGkoGVVgvbiiMbCe2hCME=;
 b=plr4+y1PuItbvi4q6nnMgWnk5NOWsPwXT3+LWei6YJaZfih5FUd8gjEMRhepnecSki
 NbGDifCRPx8BdN03iP1U69Liya9L+UFKk9l5oQsP6FQ9LmLmoPwM7BBPv+Abgu5CASx0
 wIY4dW0EOdfkpfA5+x2WIx5QtxFvramIftvrCLfR2/VUkqxcmXY2MRUWIR57fnZ8Ei5O
 0qCj2JS5Wa4yAMf20aoMaTxzDbi9qf1ATEJ/sVkJ4DzKo2d1dOchPIitwZDUQ3mKatBG
 +MtnNs51cB0XIYta73gDqnE++x1LRbC2SVaV1RyPxf8paJsnT1kdpzVBStU9yApkHh7r
 etIw==
X-Gm-Message-State: APjAAAU23DZbnH19n2XnT+hRwMQt9FL/o16jJ00vnHKXQLTjQq6ec/gi
 /O/hKOCfTdqe9miTJeuxSQ==
X-Google-Smtp-Source: APXvYqyIW4if0WiCCw0nWSFPDRi7C8E817zpUync88QJ06v4KoR749wkve/rgQKkMl0LMEvnPVD/GA==
X-Received: by 2002:a05:6808:45:: with SMTP id v5mr3356762oic.90.1582902526405; 
 Fri, 28 Feb 2020 07:08:46 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l12sm3204651oth.9.2020.02.28.07.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:08:45 -0800 (PST)
Received: (nullmailer pid 27469 invoked by uid 1000);
 Fri, 28 Feb 2020 15:08:44 -0000
Date: Fri, 28 Feb 2020 09:08:44 -0600
From: Rob Herring <robh@kernel.org>
To: Charles-Antoine Couret <charles-antoine.couret@mind.be>
Subject: Re: [PATCH 2/2 V2] ASoC: tas5756m: Add DT binding document
Message-ID: <20200228150844.GA26458@bogus>
References: <20200227232327.46309-1-charles-antoine.couret@mind.be>
 <20200227232327.46309-3-charles-antoine.couret@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227232327.46309-3-charles-antoine.couret@mind.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Charles-Antoine Couret <charles-antoine.couret@mind.be>
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

On Fri, 28 Feb 2020 00:23:27 +0100, Charles-Antoine Couret wrote:
> Document the bindings for the tas5756m driver.
> 
> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@mind.be>
> ---
>  .../devicetree/bindings/sound/tas5756m.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas5756m.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/sound/tas5756m.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/tas5756m.yaml: ignoring, error parsing file
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Documentation/devicetree/bindings/sound/tas5756m.yaml:  did not find expected <document start>
  in "<unicode string>", line 4, column 1
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/sound/tas5756m.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/sound/tas5756m.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1246173
Please check and re-submit.
