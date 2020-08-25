Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E7AC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:06:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05F5207BC
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JNEb8uDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05F5207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EE0A167C;
	Tue, 25 Aug 2020 18:05:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EE0A167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598371598;
	bh=aGLGo98E6HiFPlDLRykNprtjv24L6n+HV+GRHpEpYMI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JNEb8uDf1ofrGYOilVVrVYtmBgFSShC5fegF5D54zQGMaGpo76QazPtynW9AJMR1X
	 Ke6WhYXQvMTG1QMcdtnzWGbxE+OF1xMkAYCPPJ1vVKA4o0ILUhd9R0pkb2jmkhkCNg
	 TWlJK+LFu27/ZfBlF5NmGsTtArLLUm6RH6/5R0Sw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01E4BF80245;
	Tue, 25 Aug 2020 18:05:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D42A7F8025A; Tue, 25 Aug 2020 18:05:45 +0200 (CEST)
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E42FEF80143
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 18:05:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E42FEF80143
Received: by mail-io1-f66.google.com with SMTP id b16so13032189ioj.4
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 09:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=USbVo7pdWQ2iWUYfdtVits61UbxkogYWPU+SGBVoiSM=;
 b=iApAtAMXcEISUOBry9QIrNuw6Zqn1HZSlp7Etlf9vrrU6HM6O1RcA3vgjwB5dnYUCW
 R2ywp763cIuw7HJTsvQUtNP0sa62GJa3IivSe5t76ikzA11FAwwsUb/Uq+WyV5rOc2gc
 CSSdIjUIabtfxq6o0fE+6HORi5ssfauYwfj2cfhEKfqHh6hpCNqreWDICIboI6lmQrXr
 5DhySAB31Eds6Duhs/prZ+b2wbnjdHq6DQAnvlFu77m9YWoplwJR0nyy5uAKB5lGcSJa
 J+MX7fh4q2rXpFRTX+xxU7X29j3f6888Q4Qq0f8ntNR7wpCddRt0lKy2B1SX7Gk7YI87
 umvQ==
X-Gm-Message-State: AOAM531uljcF5FPXDgFlV2uR3xFzrGDOj34RgRlqzMlDmv27VMOOIyVt
 aEhM0nGdktOXtsZzYBp7xA==
X-Google-Smtp-Source: ABdhPJyrmxHLtqigmu8qg0y8JrSWYH0+kDFnN8rsGoDoBHrPo16Cm4OAj/Vy435rF8nD8peSSuII4g==
X-Received: by 2002:a02:950e:: with SMTP id y14mr11193741jah.106.1598371535869; 
 Tue, 25 Aug 2020 09:05:35 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
 by smtp.gmail.com with ESMTPSA id z9sm9234336ilm.78.2020.08.25.09.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 09:05:35 -0700 (PDT)
Received: (nullmailer pid 862704 invoked by uid 1000);
 Tue, 25 Aug 2020 16:05:32 -0000
Date: Tue, 25 Aug 2020 10:05:32 -0600
From: Rob Herring <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: renesas, rsnd: switch to yaml
 base Documentation
Message-ID: <20200825160532.GA862290@bogus>
References: <87wo1nwdft.wl-kuninori.morimoto.gx@renesas.com>
 <87tuwrwdf0.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuwrwdf0.wl-kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
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

On Tue, 25 Aug 2020 13:37:54 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> It is still keeping detail explanations at .txt
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/renesas,rsnd.txt           | 520 ------------------
>  .../bindings/sound/renesas,rsnd.yaml          | 454 +++++++++++++++
>  2 files changed, 454 insertions(+), 520 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: example-0: sound@ec500000:reg:0: [0, 3964665856, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: example-0: sound@ec500000:reg:1: [0, 3965321216, 0, 256] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: example-0: sound@ec500000:reg:2: [0, 3964928000, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: example-0: sound@ec500000:reg:3: [0, 3964932096, 0, 4736] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: example-0: sound@ec500000:reg:4: [0, 3967025152, 0, 512] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1350780

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

