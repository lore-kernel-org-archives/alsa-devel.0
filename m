Return-Path: <SRS0=jGB1=OZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541D0C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 22:47:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB86F611C5
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 22:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB86F611C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A70A51657;
	Wed,  6 Oct 2021 00:46:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A70A51657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633474026;
	bh=jogaCHS7GolngHSWNwCTYcCrGEKRzKRPMEwTvWvAOCc=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XuvunMXHBmrhEVdWZ48x3k8VbkLcm77WonwbIJU6dR7s/3Uyod4V242HqTL16p/zM
	 1jAw883XiYfv7+jYQan0a6xYoyTAlto7cRDh2c1zF9CG/HScE60xcC1JcfTCqHAdR8
	 yZtYLKCfEztsEixowfHF7fGvey8bFeI2N0DbcJRU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FB22F80259;
	Wed,  6 Oct 2021 00:46:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3F34F8027D; Wed,  6 Oct 2021 00:46:13 +0200 (CEST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40733F8020D
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 00:46:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40733F8020D
Received: by mail-oi1-f169.google.com with SMTP id s69so1319212oie.13
 for <alsa-devel@alsa-project.org>; Tue, 05 Oct 2021 15:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=1pxND7BCUQcsSSy7TZxTVSdJeMVhe7/yxhkqlpU5RsE=;
 b=U39rVBtXw5r0LJH3fClcpv414kGMOrHKO+L8uiaBBMh2Jm7cYMfH7ItxgA//sGnJLt
 0V/ogd88wvd18xcBZHPCwXyFWpWN+KmrRhmYm1E6JB21anTfLFKBqYuSmqpfxHQ6x42y
 EwTwSjN+AxyczKQv4rW1w6NzXj0YHHnIeB4gIBBTQAq/jQ/y+vYAZMwsaZS/ir6IIFcO
 2pRNgNz25AvCJOb8NUkm5+AV7jDCkcCQYbYz5W6N2865LoTLVpZavLx9wPF9b1QGrYIG
 kx23ChQeUgMMW7IVhrKD7AxMlURkju6oE5zTwQ1ADqDQrfhRcVhWDnxgTt/ow3QIWS5s
 9/zg==
X-Gm-Message-State: AOAM531/MXhCq+sP1nKbcZZAFf/NCxKD9vnLMRLsSOW1+B2DDVC93x//
 lXIWWyovijMJ1CnXoNouAg==
X-Google-Smtp-Source: ABdhPJzOguD4l2kCjKfnxpvalktU+y3R8MfzP+cj3IqJDlV+LBYM1M+tbREdb4g60bxvG1vfkOBTew==
X-Received: by 2002:a05:6808:bcf:: with SMTP id
 o15mr4696483oik.171.1633473965166; 
 Tue, 05 Oct 2021 15:46:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id k23sm3760510ook.45.2021.10.05.15.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 15:46:04 -0700 (PDT)
Received: (nullmailer pid 106773 invoked by uid 1000);
 Tue, 05 Oct 2021 22:45:59 -0000
From: Rob Herring <robh@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
In-Reply-To: <1633441974-15353-7-git-send-email-srivasam@codeaurora.org>
References: <1633441974-15353-1-git-send-email-srivasam@codeaurora.org>
 <1633441974-15353-7-git-send-email-srivasam@codeaurora.org>
Subject: Re: [PATCH v2 6/9] ASoC: dt-bindings: Add SC7280 sound card bindings
Date: Tue, 05 Oct 2021 17:45:59 -0500
Message-Id: <1633473959.357662.106769.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, lgirdwood@gmail.com,
 Venkata Prasad Potturu <potturu@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 plai@codeaurora.org, tiwai@suse.com, robh+dt@kernel.org, agross@kernel.org,
 rohitkr@codeaurora.org, broonie@kernel.org, swboyd@chromium.org,
 bjorn.andersson@linaro.org, judyhsiao@chromium.org,
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

On Tue, 05 Oct 2021 19:22:51 +0530, Srinivasa Rao Mandadapu wrote:
> Add bindings for lpass sc7280 based soundcards which supports
> audio over i2s based speaker, soundwire based headset, msm dmics
> and HDMI Port.
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 69 +++++++++++++++++++---
>  1 file changed, 61 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: reg: [[0, 1658351616, 0, 425984], [0, 1659895808, 0, 167936]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: reg-names: ['lpass-hdmiif', 'lpass-lpaif'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: interrupts: [[0, 160, 1], [0, 268, 1]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: interrupt-names: ['lpass-irq-lpaif', 'lpass-irq-hdmi'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: iommus: [[4294967295, 4128, 0], [4294967295, 4146, 0]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1536654

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

