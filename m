Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BC1C38145
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Sep 2022 11:50:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EBDF16E5;
	Thu,  8 Sep 2022 13:49:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EBDF16E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662637841;
	bh=9K5NCNInE6b0PrzO24w1Cdrk91fIL74ya5tTvGbOKXc=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DtW/I1HcAxFZen7EWcv2OGCVkwdG4UqDbwEIkkE9mQtWukoihyEXMYK3GUWJ5y61i
	 GCP3Jy7Jxi2JsqVF6WWJeniv91xFd77AIE0WYgu3NT07PkP9YpFVj4eUUQCbKTjOz5
	 m8p1xgIm4kT+sGqirBt4r0MUvhHGe6IGjnfPfRsI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7D77F801F7;
	Thu,  8 Sep 2022 13:49:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5D5CF80217; Thu,  8 Sep 2022 13:49:48 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9A5AF800CB
 for <alsa-devel@alsa-project.org>; Thu,  8 Sep 2022 13:49:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9A5AF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="pe7ujTnM"
Received: by mail-lf1-x135.google.com with SMTP id a8so5698130lff.13
 for <alsa-devel@alsa-project.org>; Thu, 08 Sep 2022 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=srioTK6KsCPJy0yU+c6+tCB1HEEi/KQ9lo+WsB/Dyi4=;
 b=pe7ujTnMRAtFZJxkWsN5z/obj9g6VXrSDkMirgfCrTziYv9bw0qHLSdPjKnOaBZMu2
 gFJHxrTrCEmPkpDpAoKuRyCfBfxIyeyONErIBJBGmNEtLdN1GrlbWPUHvZzUtw5CmJvO
 CobR7oIhLc4ioRiIOpMh6Gf6ZVRwlpDxyn16h8IddatEBjNJsbEfifqrjI7tLDKNaksv
 mmxNKAYOMD8xwq+7fIaDoF5ZejgFoHy9vmRUnZDu4sE6yk5aYm7ePzKx1oXcd4SsFI1A
 +9IhMt7OczyNJ75DwKHYVHqgL9qNwbGI2NvA3czQldQWgNYoviTpLAlJBZN3mX/wEKQm
 awoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=srioTK6KsCPJy0yU+c6+tCB1HEEi/KQ9lo+WsB/Dyi4=;
 b=C3vdN7I+un6LtKwtpUc/N1kSk0wbTfqyEAtrnygh6xT14/5485cJthbTPBZ3o2sxfD
 FiyIclpvb+Q//B5kk8ILCpYfm3T0NU8FdoNTXFhC5wCZ8WsmKoxr9tOzKQDMbRHadbsC
 kBgENCo04/hFgtcDlkIq5OhlmncqNS5idRQZEgYUfFnHPd9b/b7SFO9Mgee6YwxFyuFG
 IEUSRtG5r7TXgEP4Ke9X+BSSnlW0noBqsJUqj7hKPIb0C8JFCEWg4CZmAuhzIrv0xior
 XMpTpkUpD8wcdV4Z2D4cRKExKupEU1kskeTiDlMzCjqakkDRa6RjyYmoUSfH8W6ZjIKH
 nVuA==
X-Gm-Message-State: ACgBeo0Rl5/t/NYmsfqrydscOMtTDnnMf2DGDzhjtHcTt+UK1bIWfRAH
 f7aHZ0SiDqma3RWaK1qklAA8Gg==
X-Google-Smtp-Source: AA6agR4oUsEtw6uTpZlyCNzA5SlmDM2bsf9JfE82EcGp2pWiO/h1kTgoyWh83rCQTlx51j+HQcNLnw==
X-Received: by 2002:a05:6512:1520:b0:492:daab:8382 with SMTP id
 bq32-20020a056512152000b00492daab8382mr2830583lfb.151.1662637776115; 
 Thu, 08 Sep 2022 04:49:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl.
 [78.11.189.27]) by smtp.gmail.com with ESMTPSA id
 o9-20020a05651205c900b004947e89ae4bsm202530lfo.294.2022.09.08.04.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Sep 2022 04:49:35 -0700 (PDT)
Message-ID: <aeabc681-9416-d25d-693a-30ba99f1796d@linaro.org>
Date: Thu, 8 Sep 2022 13:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/8] ASoC: rockchip: rk3308: add audio card bindings
Content-Language: en-US
To: luca.ceresoli@bootlin.com, alsa-devel@alsa-project.org,
 linux-rockchip@lists.infradead.org
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
 <20220907142124.2532620-3-luca.ceresoli@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907142124.2532620-3-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Chris Morgan <macromorgan@hotmail.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Johan Jonker <jbx6244@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On 07/09/2022 16:21, luca.ceresoli@bootlin.com wrote:
> From: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> Add device tree bindings document for the audio card based on the internal
> I2S of the Rockchip RK3308 SoC.

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  .../rockchip,rk3308-audio-graph-card.yaml     | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml b/Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml
> new file mode 100644
> index 000000000000..8445a69dcdbb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/rockchip,rk3308-audio-graph-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3308 Audio card based on internal I2S
> +
> +maintainers:
> +  - Luca Ceresoli <luca.ceresoli@bootlin.com>
> +
> +allOf:
> +  - $ref: /schemas/sound/audio-graph.yaml#
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3308-audio-graph-card

Is "graph" part of device name or you just put it there because of other
schema? The compatible should reflect the device name, not some other
pieces in Linux or in bindings.

> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sound {
> +        compatible = "rockchip,rk3308-audio-graph-card";
> +        dais = <&i2s_8ch_2_port>;
> +    };
> +
> +    i2s_8ch_2 {

No underscores in node names. Generic node names. This does not look
like related example...

> +        i2s_8ch_2_port: port {
> +            i2s_8ch_2_endpoint: endpoint {
> +                remote-endpoint = <&acodec_endpoint>;
> +                dai-format = "i2s";
> +
> +                /* The RK3308 acodec has no clock dividers, use the CPU */
> +                bitclock-master = <&i2s_8ch_2_endpoint>;
> +                frame-master = <&i2s_8ch_2_endpoint>;
> +            };
> +        };
> +    };
> +
> +    acodec {

codec or audio-codec

> +        port {
> +            acodec_endpoint: endpoint {
> +                remote-endpoint = <&i2s_8ch_2_endpoint>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d53a8e74cb1e..079bdd95dc49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17594,6 +17594,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
>  F:	include/dt-bindings/sound/rockchip,rk3308-codec.h
>  
> +ROCKCHIP RK3308 SOUND CARD DRIVER
> +M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml
> +
>  ROCKCHIP VIDEO DECODER DRIVER
>  M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>  L:	linux-media@vger.kernel.org


Best regards,
Krzysztof
