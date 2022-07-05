Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53D8C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jul 2022 18:22:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 088C216B8;
	Tue,  5 Jul 2022 20:21:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 088C216B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657045340;
	bh=g5TAZtxdOGWHu775VKiNDmn3jJuzFVt2Fl4OTJ2b+eQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W6VpM1xZLgFvPH6PMLxGo201aKd2BgwfOf7dAlM7ogJW5zq2LAnxVkwFba4eQX5Te
	 pB2zxjsubhSDJOuYsPzEqYrR1UJ5DkoVJRx7/4piho+aTaTANptnM/8MpH2fvYVyGv
	 bAxaPAlDjj3GdNivlBbO0/N+dyGtnmkosdFKm+50=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 991EAF80153;
	Tue,  5 Jul 2022 20:21:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D072F8015B; Tue,  5 Jul 2022 20:21:28 +0200 (CEST)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3384BF800CB
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2022 20:21:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3384BF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="F3fNQ79b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657045281;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=UQh/AeOwYOytT9lqqjisAb47n38WBxn//wzctNCCTb8=;
 b=F3fNQ79by2v5AKFvK+zRv9SKkf0apyfCvsx+N92TJvadUYg7J0WihSKHGF9SiaL8kU
 DyAksPcDRyWyDkk8ZcZcygD38a76rQLfJHWhmY2OgOT7F55LQFy7uRMWOS13gM5P0Rak
 BTvLhejkSg8OjDfw8eAE5cRgSKreJcAzixCwZmbf/mrryMy0/iGgk/O6DnODBp3Sl3ew
 9l3T5ujxr+/3DzoYJxNsjI3Fw5P2y5p8Suc/6ug/kiUcCsAoVHRKEmRN6hdjsg5OyonK
 YMKOTP6fWL4uaywR4oL1Vo95Q71c+QPrpNplngB1uVeVGIAAJVHMkWDJcncjw8lQFqlw
 Isrw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK85/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net by smtp.strato.de (RZmta 47.46.1 AUTH)
 with ESMTPSA id yfdd30y65ILKJAG
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 5 Jul 2022 20:21:20 +0200 (CEST)
Date: Tue, 5 Jul 2022 20:21:10 +0200
From: Stephan Gerhold <stephan@gerhold.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: qcom,sm8250: add SDM845 sound
Message-ID: <YsSBFjW6riKOZZcz@gerhold.net>
References: <20220705174702.763247-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705174702.763247-1-krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
 Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-kernel@vger.kernel.org
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

On Tue, Jul 05, 2022 at 07:47:02PM +0200, Krzysztof Kozlowski wrote:
> The Qualcomm SDM845 sound card bindings are almost the same as SM8250,
> except "pin-switches" and "widgets" properties.  These were not
> documented in SDM845 text bindings but are actually valid for SDM845.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Integrate into SM8250 instead of creating new file (Stephan).
> 
> Cc: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../devicetree/bindings/sound/qcom,sdm845.txt | 91 -------------------
>  .../bindings/sound/qcom,sm8250.yaml           |  1 +
>  2 files changed, 1 insertion(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> deleted file mode 100644
> index de4c604641da..000000000000
> --- a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> +++ /dev/null
> @@ -1,91 +0,0 @@
[...]
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be one of this
> -			"qcom,sdm845-sndcard"
> -			"qcom,db845c-sndcard"
> -			"lenovo,yoga-c630-sndcard"
[...]
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> index 4ecd4080bb96..7cdf9e9f4dd3 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - qcom,apq8016-sbc-sndcard
>        - qcom,msm8916-qdsp6-sndcard
> +      - qcom,sdm845-sndcard
>        - qcom,sm8250-sndcard
>        - qcom,qrb5165-rb5-sndcard
>  

Looks like you forgot the db845c and lenovo compatible? :)

If you add them feel free to add my:
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks!
Stephan
