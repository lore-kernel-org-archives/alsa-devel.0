Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3224ACCA473
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jun 2022 17:27:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B1E217A3;
	Fri, 24 Jun 2022 19:27:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B1E217A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656091670;
	bh=MRajG9OlcBiPR0fVGrTl/o/aahagiomfsMJw1fySdTk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WydtefyfNijkpuezcnbA1ukI/eJZx+qzYY7tRGmdWz3wEQ0UlVGDt0MsclAG5EYZL
	 GOZ+q+s5PnoUI31XtbSnRHh7PF+CrL2K1rc+xi5pi7gB3+MDfx1yL7MxsINC+btGsm
	 MzG8oHe4uyKkFzcwDah2BARYzuJO3Aiikl52D5BI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 057DBF80137;
	Fri, 24 Jun 2022 19:27:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 287ABF800CB; Fri, 24 Jun 2022 19:26:58 +0200 (CEST)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
 [209.85.166.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 209C2F800CB
 for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2022 19:26:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 209C2F800CB
Received: by mail-io1-f46.google.com with SMTP id a10so3365475ioe.9
 for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2022 10:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=nz2qQEgaL087Hhf4qoKzeVlUqnLzg/kAouulSnIEDmM=;
 b=kr13eIH5mLbdOl4Ny1P88X/MZgJDSeZDQvFjRkkauaYfrcb6RvhguQf5sMAlM5vvYi
 NPR0I6xekbnhFqrzKsu7LRr+F8vjPU8fox4M7tYRzfserikRERIfUkf5gLkxbRph/uJh
 /HH4+KZCmqyT7cPrjlvtxa/m/RXmOdz7GBm69SOwstpyUCmP4HWwbJA3Wtb3JFlJ435t
 HnRMWAYFeyaefX9A9ZSgWEcvkXXASogUNKWgjwIJdmBehl9oIQcbhE9LrVeFPLt+bRn1
 snPM5XfjvW3tD9eSC0Kkn/P1MWF7jxvRKOD6p/byIHyN0aTNt/4WWS+DXCrIbZTfBHot
 43xQ==
X-Gm-Message-State: AJIora/dJE4UFOIg4l+Vn9hxNdNwghEaTQj25C4x+HhzYnxTjTAOJh6n
 Xk+Jo9GZzm57x6j0Sl/V8g==
X-Google-Smtp-Source: AGRyM1s8DeK7lzgekbYZjos/351Am8lOtX0eBpG6oBqhJM7yv+oxiGXrJ2AZn+FOBZZgPNGP9OZceA==
X-Received: by 2002:a05:6638:164b:b0:335:de33:26fa with SMTP id
 a11-20020a056638164b00b00335de3326famr150425jat.31.1656091609513; 
 Fri, 24 Jun 2022 10:26:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id
 d126-20020a026284000000b003318c717b59sm1292545jac.39.2022.06.24.10.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 10:26:49 -0700 (PDT)
Received: (nullmailer pid 146344 invoked by uid 1000);
 Fri, 24 Jun 2022 17:26:34 -0000
From: Rob Herring <robh@kernel.org>
To: Daniel Mack <daniel@zonque.org>
In-Reply-To: <20220624104712.1934484-3-daniel@zonque.org>
References: <20220624104712.1934484-1-daniel@zonque.org>
 <20220624104712.1934484-3-daniel@zonque.org>
Subject: Re: [PATCH 2/8] ASoC: dt-bindings: max98396: Add #sound-dai-cells
Date: Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.398007.146343.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, ryan.lee.analog@gmail.com, robh+dt@kernel.org,
 broonie@kernel.org, alsa-devel@alsa-project.org
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

On Fri, 24 Jun 2022 12:47:06 +0200, Daniel Mack wrote:
> Add this mandatory DT property to the yaml documentation.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  Documentation/devicetree/bindings/sound/adi,max98396.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/sound/adi,max98396.example.dts:32.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/sound/adi,max98396.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

