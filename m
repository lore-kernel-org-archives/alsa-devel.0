Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C24C32771
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 22:59:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B12AF3E8;
	Tue, 27 Sep 2022 00:58:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B12AF3E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664233145;
	bh=AtuKrdqQh2/RmrpyK9w44bUNqygx951GjG6AHBelMWg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VTRTqHqP7kIYGEWh1iL80pdiPL/oy/9OCJVAUB8J9puXpaaTKpAA7y7DXc1DGaLZ6
	 +n0QDUXozwdBjkA2NV2+oPK7nhJPlPXrsGkbJQ7/1O9THT7z8HJEFFoaLQWMRPqOaO
	 dvfE1VK0+ac6ALibpY0yluNj58iNwPkOO4taCg6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4031EF80254;
	Tue, 27 Sep 2022 00:58:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 423ACF8027D; Tue, 27 Sep 2022 00:58:14 +0200 (CEST)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51231F80115
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 00:58:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51231F80115
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-130af056397so11208601fac.2
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2022 15:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=epyIDE9t3WUpMt89cRPv2cckD3O12ExvX3hn7aJqqwU=;
 b=b3fsOKdS7jAzYa4nNsdk08BC4WNNVK8NwGp9R1rwYPG3VW6kqXdmlWCkCJLUuSKQCB
 MeG4l/mfG50licpzQ5QhNvA+8/yLqRGbbSpf0PlpBWyIfQcaYDdqhuBkj2bRB9jd4Uv9
 zDZ3oyfnz6ERsFJlKNtg7GUYYBYryJC6zYwSBCy1nXEutLGujF/8W/G3Km/kEzIzYbq6
 63DmScBTudD4xA5m7F6AKa5fIhRTFNCQ2i6B4ZY46WeYpWm9PYWnNBDpWQei6puqtHEe
 Wx4uA2LruPqSt1EXRii9LrTmsBhYxPhI8UTMf+vFEnMt6n54bil7Mz7wTjb2f8i5NgHT
 HoXA==
X-Gm-Message-State: ACrzQf2MhrcvrUSqRhlwyZG4JWDCI6261KYPwxtWyw7FcEAV4L7b/jU2
 iXDUx0aBwVain4ThVGwx1w==
X-Google-Smtp-Source: AMsMyM4Y3XzNfRebEVuyawLZnrgxtX+upc5Kkaue5quLOYpoJkfUPf0wfRF02DeA4T6MtSd44EbMXA==
X-Received: by 2002:a05:6870:b684:b0:127:aefe:eaee with SMTP id
 cy4-20020a056870b68400b00127aefeeaeemr599766oab.53.1664233086342; 
 Mon, 26 Sep 2022 15:58:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 x18-20020a056870b41200b0012d6f3d370bsm9829017oap.55.2022.09.26.15.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Sep 2022 15:58:05 -0700 (PDT)
Received: (nullmailer pid 3120697 invoked by uid 1000);
 Mon, 26 Sep 2022 22:58:05 -0000
Date: Mon, 26 Sep 2022 17:58:05 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 10/11] dt-bindings: slimbus: qcom,slim: convert to DT
 schema
Message-ID: <20220926225805.GA3120664-robh@kernel.org>
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
 <20220923161453.469179-11-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923161453.469179-11-krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

On Fri, 23 Sep 2022 18:14:52 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm SoC SLIMbus controller bindings to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/slimbus/qcom,slim.yaml           | 86 +++++++++++++++++++
>  .../bindings/slimbus/slim-qcom-ctrl.txt       | 36 --------
>  2 files changed, 86 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
>  delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
