Return-Path: <SRS0=IN0D=YE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB025C47404
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:14:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D2C21A4A
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GQqErYYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D2C21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56AED1612;
	Fri, 11 Oct 2019 17:14:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56AED1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570806892;
	bh=AmbinCIjrtwYc3iBDyF6Nro+PwN+mf3HDnSb56if2o4=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GQqErYYJIXVQzS3GuaFk0RwvM88B0CPH+BZd1LM7HpCffr1NbaxdLshQI3PVJR+d4
	 uJdIng7EPeoKCOOXCWk5rpgQTWpcrwQBAQ5ieN4m/W84/V96oV0KiD+qbIET/Q0IBQ
	 piSn0QokKZYrBmbxZg3R5yQN0NL8iom+BwOFkL1U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D10A8F802BD;
	Fri, 11 Oct 2019 17:14:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3DDEF802BE; Fri, 11 Oct 2019 17:14:00 +0200 (CEST)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41097F80113
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2019 17:13:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41097F80113
Received: by mail-ot1-f66.google.com with SMTP id 89so8225789oth.13
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2019 08:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9Iafovyy6XzHHeXhOv1ugxykGatkGZoGKt/DDaK3zgI=;
 b=fbG1YjzGRfZyoUmtr1cnubrm5c0i9NagqjFLk417H1DdhCMFRpsLhLlor6lgAlfSz8
 jOEomeEJ0nMeX5UZUyDp6UE+gnF1wcrp4/ih4GnNeIsvriKVG2P0wY1JiyvWgUIo92l2
 Pbn5U6hMFhOQXyTSdil8eO9W32Dqz84MNcbpM+xjYvfWMolpG4pdqz+Bwq6N3lD6TRfx
 R4f3h3hCQlECSU0l3vb8QmkmzQ6gZBfNvcUa2mb82kPJfBKqkN3/gLFypejmAImmHu2+
 py/vYDnWUBhB2l/1sXCHzJVtwbIhqcEiYlomwod017wspjRdVheW3kv5VRR/cCuCfR96
 wgQQ==
X-Gm-Message-State: APjAAAW3MXe/267BSmte7SMzXy+N0u4erM3IuiCjiObVXfxVvMcoKBTT
 SYPHK3PkjtEZqEECFekUUA==
X-Google-Smtp-Source: APXvYqzazgtvEUjORZSImAH/Nk6JEWLFTs8GB4oD1DDIGfpusPeKu4KM7HJ2qrKdg4eKfanW/ihJWQ==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr12801334otl.352.1570806836304; 
 Fri, 11 Oct 2019 08:13:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i2sm2946148otf.19.2019.10.11.08.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:13:54 -0700 (PDT)
Date: Fri, 11 Oct 2019 10:13:54 -0500
From: Rob Herring <robh@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Message-ID: <20191011151354.GA12997@bogus>
References: <20191005085509.187179-1-tzungbi@google.com>
 <20191005164320.06.I0df85fe54162426e31f60a589d9b461c65df2faa@changeid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191005164320.06.I0df85fe54162426e31f60a589d9b461c65df2faa@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: gwendal@google.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, drinkcat@google.com, broonie@kernel.org,
 enric.balletbo@collabora.com, bleung@google.com, dgreid@google.com
Subject: Re: [alsa-devel] [PATCH v2 06/10] ASoC: dt-bindings: cros_ec_codec:
 add SHM bindings
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Sat, Oct 05, 2019 at 04:55:05PM +0800, Tzung-Bi Shih wrote:
> - Add "ec-shm" for binding to shared memory exposed by EC.
> - Add "memory-region" for binding to memory region shared by AP.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>  .../bindings/sound/google,cros-ec-codec.txt   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> index 0ce9fafc78e2..cb46bc082b4b 100644
> --- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> +++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> @@ -10,8 +10,26 @@ Required properties:
>  - compatible: Must contain "google,cros-ec-codec"
>  - #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
>  
> +Optional properties:
> +- ec-shm: Shared memory region from EC.  It contains 3 unsigned 32-bit
> +          integer.  The first 2 integers combine to become an unsigned
> +	  64-bit address.  The last one integer is length of the shared
> +	  memory.

This is an address accessible to the main CPU? If so, then it really 
should be using 'reg' and be translatable.

> +- memory-region: Shared memory region to EC.  A "shared-dma-pool".  See
> +                 ../reserved-memory/reserved-memory.txt for details.
> +
>  Example:
>  
> +{
> +	...
> +
> +	reserved_mem: reserved_mem {
> +		compatible = "shared-dma-pool";
> +		reg = <0 0x52800000 0 0x100000>;
> +		no-map;
> +	};
> +}
> +
>  cros-ec@0 {
>  	compatible = "google,cros-ec-spi";
>  
> @@ -20,5 +38,7 @@ cros-ec@0 {
>  	cros_ec_codec: ec-codec {
>  		compatible = "google,cros-ec-codec";
>  		#sound-dai-cells = <1>;
> +		ec-shm = <0x0 0x10500000 0x80000>;
> +		memory-region = <&reserved_mem>;
>  	};
>  };
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
