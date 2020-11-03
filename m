Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0166C2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:01:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99AF206D5
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eDPyv3tT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nPPPBxXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99AF206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 783C51748;
	Tue,  3 Nov 2020 08:00:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 783C51748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604386880;
	bh=+SdvMivsVGTcGje08PhNzFwvLW2iRIiIIdrchVwZ+34=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eDPyv3tTDdNVLTIU3BxeOp0N53TYvrQGUsqzi/bFxEW7KVH8Qmy9w73Q3WxIIkHbj
	 X3Z3Wzy7bcgoA2xfrGmkW94sB8kqFWudZ8z+Vix3Aj8xsDByan1xdTRjrPMR3HNMoF
	 JyeCEFnwHcTiDbTzszlr7xWvogYqDjK/+uypyFIg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10F78F80083;
	Tue,  3 Nov 2020 08:00:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0269DF80171; Tue,  3 Nov 2020 08:00:29 +0100 (CET)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25FF7F80108
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 08:00:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25FF7F80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="nPPPBxXf"
Received: by mail-lf1-x141.google.com with SMTP id y184so18801168lfa.12
 for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2020 23:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xd9jmL8NLRJagrGwF9PSXuFGxAsb2QDRMyRb3WHvNB8=;
 b=nPPPBxXfD3t0mgR3L4eyvK3/ip01O16uclOf5uHPMNlPNhNVlAmqasJhy/a+r4og75
 VW9Ub+qibTJzFwSdatbGsTSVcWLdZ5vbShHtw0xfiQO99DR2mPq/8XmHeP/Qm68xKuAQ
 wwzecgg1L6Bv7EnTCa3Mad0MpPdOosUjlcauyy+nwM415UHSyR2fio4Zz3qJO+UyyZXF
 cu9R4m9TE+Oy7OOiEHRm7uB1NTt4czRAQdjxrYBxdQqcOWXQh7I8dnfczwb8cKc2gwv4
 e56usYVODCCZFNyfMYh4MGEeNfdW3bvgu48JhPWqdAeVATErc5slE6HbbmHhyKAe+72u
 XKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xd9jmL8NLRJagrGwF9PSXuFGxAsb2QDRMyRb3WHvNB8=;
 b=mah/K7TxB7VBvaCjxBQze587P9wp14ftTg1UMr7UmWLl3TnA4r2Z6fJaJy7MLn1UMI
 Qmxsl/fsvaoXxVsi1iNpsMubgITyY8iI8aZbmjsOZGbzLXr8pW227zPqnYqWHWiY8R/8
 P99RY0s7AXMReeiHviY3imRzWs7vSx4/1hcGBjrqQo/nHoIYa5iCBuMuAsdF2LPrdfYR
 61sJuBGrneYnIeO4pLrWqKTJ7A6bhnFkcMt2VQEYSd+8v0hdDz5UW9z+eLbg1sSGikul
 WWURbp6NvzkBris02xrifOYnjek99pwqxY/952UE24jqc6PiQ6dJco+T0gperHaakQQN
 GteA==
X-Gm-Message-State: AOAM5338QyRx/9Pg6XSIY75qwMK6EVHgfzTVS9QaemA8UAUlarhdeHco
 GV51ws2kRsislDqdC+UryxsJx9j7HNlSJilu/SYFIw==
X-Google-Smtp-Source: ABdhPJzi0uI6+FMH6ZkQJyTAi3yavIsi+kzHjb9xYY0N60Cx/lyDiUSdCeqHLAosIiGo/QeKWaOn0+S9nHNTkTOnzlE=
X-Received: by 2002:a19:c345:: with SMTP id t66mr4461115lff.536.1604386823858; 
 Mon, 02 Nov 2020 23:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20201103025347.510940-1-ajye_huang@compal.corp-partner.google.com>
 <20201103025347.510940-2-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20201103025347.510940-2-ajye_huang@compal.corp-partner.google.com>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Tue, 3 Nov 2020 15:00:13 +0800
Message-ID: <CALprXBbPQBsRFWgGBhHo5=5GkcUEODe5pcqz7seeaOkxTb3c8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ASoC: google: dt-bindings: modify machine bindings
 for two MICs case
To: Ajye Huang <ajye.huang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Douglas Anderson <dianders@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Patrick Lai <plai@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 Andy Gross <agross@kernel.org>, Tzung-Bi Shih <tzungbi@chromium.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Cheng-yi Chiang <cychiang@chromium.org>
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

Hi Rob,
Could you please kindly review this patch ?

 I had got your "reviewed-by" on v1 patch, the v1 depends on this patch series
(https://patchwork.kernel.org/patch/11773221) at that time.

Now, that patch what I depended (11773221) had made modification and
it was Applied to
   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
commit e158d2d83cab ("ASoC: google: dt-bindings: Add sc7180-trogdor
machine bindings")

I noted what I did on cover letter
Changes from v1 to v2:
- Documentation: Modify the dimc-gpios property description and examples.

That is why I bother you again to review it. Please let me know if
this looks good to you.
Thanks!

On Tue, Nov 3, 2020 at 10:54 AM Ajye Huang <ajye.huang@gmail.com> wrote:
>
> Add a property "dmic-gpios" for switching between two MICs.
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  .../bindings/sound/google,sc7180-trogdor.yaml | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> index efc34689d6b5..9e0505467e57 100644
> --- a/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> +++ b/Documentation/devicetree/bindings/sound/google,sc7180-trogdor.yaml
> @@ -34,6 +34,9 @@ properties:
>    "#size-cells":
>      const: 0
>
> +  dmic-gpios:
> +    description: GPIO for switching between DMICs
> +
>  patternProperties:
>    "^dai-link(@[0-9])?$":
>      description:
> @@ -81,6 +84,7 @@ additionalProperties: false
>  examples:
>
>    - |
> +    //Example 1
>      sound {
>          compatible = "google,sc7180-trogdor";
>          model = "sc7180-rt5682-max98357a-1mic";
> @@ -128,3 +132,57 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    //Example 2 (2mic case)
> +    sound {
> +        compatible = "google,sc7180-trogdor";
> +        model = "sc7180-rt5682-max98357a-2mic";
> +
> +        audio-routing =
> +                    "Headphone Jack", "HPOL",
> +                    "Headphone Jack", "HPOR";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dmic-gpios = <&tlmm 86 0>;
> +
> +        dai-link@0 {
> +            link-name = "MultiMedia0";
> +            reg = <0>;
> +            cpu {
> +                sound-dai = <&lpass_cpu 0>;
> +            };
> +
> +            codec {
> +                sound-dai = <&alc5682 0>;
> +            };
> +        };
> +
> +        dai-link@1 {
> +            link-name = "MultiMedia1";
> +            reg = <1>;
> +            cpu {
> +                sound-dai = <&lpass_cpu 1>;
> +            };
> +
> +            codec {
> +                sound-dai = <&max98357a>;
> +            };
> +        };
> +
> +        dai-link@2 {
> +            link-name = "MultiMedia2";
> +            reg = <2>;
> +            cpu {
> +                sound-dai = <&lpass_hdmi 0>;
> +            };
> +
> +            codec {
> +                sound-dai = <&msm_dp>;
> +            };
> +        };
> +    };
> +
> +...
> --
> 2.25.1
>
