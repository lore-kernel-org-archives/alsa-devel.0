Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A615BC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:28:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7DB22BEA
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UazbAO6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7DB22BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9BF31657;
	Fri, 31 Jul 2020 20:27:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9BF31657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596220098;
	bh=0eqxh09ZP94CYeqLKpIF+pTKJVrdYDpmTViNSv/5i6o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UazbAO6RWTH1Ll1oJHlG8OuuC0Ejz5LIxPG04yfJTXw8FqP31H/Vc2Yqa7OY2wupl
	 hZJ2Jl6zxiod1LjvyuMlTI0mwYCMIKbyv7UIyXNYzZSEez0LSwKdQENAMV8nAb81AC
	 ZNEQd/zsLBkU/UlnXF6DbTkUWaS3T/+Jhf5I4FGE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 586C0F8015C;
	Fri, 31 Jul 2020 20:27:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01E95F80171; Fri, 31 Jul 2020 20:27:27 +0200 (CEST)
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8AB5F8015C
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 20:27:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8AB5F8015C
Received: by mail-il1-f194.google.com with SMTP id s21so26104330ilk.5
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 11:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oaGd/EIUlumWQy9Pm41SRzZ2KAZopmVPZLx/MEhynr0=;
 b=GdxCSMnSeCD2U8XUitNUpeyNqjKgPS4O7s+Y1+VqnowVNSyXtNsQRD95AD072mhuv+
 utaSxWQgql3SJOjN0RrOfw5sRI/zxwMn2hilVCs+TkwKGNpDO/yV6/psd+zanAux9+gz
 Bx2hSauyRrlczBRIADg/yg1hdr1AcnKT6ZodKP0TNcG5bCOabNazW3UqADZH7hFfIjye
 ZZTn+PehhxoAy+knTyi61dKdJn88GpIVDLxezNmJSlaeFQ2u14zH6ZbKat1KMHE9JUUC
 T60jhsIfSeVoD/meIEJxr2JCOvF+QNCdfHHp93sS+gJ7GW7ENElK8x19FhpfASryHjqV
 wtDA==
X-Gm-Message-State: AOAM5336jlUX2iv5ThDVeiZmh9zKyMz4NjOKras1K6WbKJsBEoAOuGqq
 cHx+KB55QanSor7jOfAyFA==
X-Google-Smtp-Source: ABdhPJwhIJ+PDeIEqoO3CED9uAsxszMYrDBCUOFn0M8IR4v2vZ7/a/swVVxxCF7eIePjl8Q3S2U52Q==
X-Received: by 2002:a92:660e:: with SMTP id a14mr5080012ilc.262.1596220037143; 
 Fri, 31 Jul 2020 11:27:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id u6sm5014967ilk.13.2020.07.31.11.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 11:27:16 -0700 (PDT)
Received: (nullmailer pid 531811 invoked by uid 1000);
 Fri, 31 Jul 2020 18:27:12 -0000
Date: Fri, 31 Jul 2020 12:27:12 -0600
From: Rob Herring <robh@kernel.org>
To: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v3 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine
 bindings
Message-ID: <20200731182712.GA531472@bogus>
References: <20200731084023.2678931-1-cychiang@chromium.org>
 <20200731084023.2678931-2-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731084023.2678931-2-cychiang@chromium.org>
Cc: Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 dianders@chromium.org, tzungbi@chromium.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 dgreid@chromium.org, linux-arm-kernel@lists.infradead.org
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

On Fri, 31 Jul 2020 16:40:22 +0800, Cheng-Yi Chiang wrote:
> Add devicetree bindings documentation file for sc7180 sound card.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  .../bindings/sound/qcom,sc7180.yaml           | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/sound/qcom,sc7180.example.dts:32.24-41.15: Warning (unit_address_vs_reg): /example-0/sound/dai-link@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/sound/qcom,sc7180.example.dts:43.24-52.15: Warning (unit_address_vs_reg): /example-0/sound/dai-link@1: node has a unit name, but no reg or ranges property


See https://patchwork.ozlabs.org/patch/1339316

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

