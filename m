Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4010CC54EAA
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Jan 2023 14:05:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44786850;
	Mon, 30 Jan 2023 15:04:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44786850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675087534;
	bh=Jjn0+53ZdOQE+LOUNUWOAoLOD0dkghjv0CHfLtqKrqU=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=f2oOyH7i6IOS91ucmQgVsDKGMaKGdooZK7W/j4m5AgbnXBcDw7v8KPGkxKF2cpK5h
	 m0VYRW25zEFxoHWPNqrrQQvlDu+1Vc0lNI8EXjdL096MVm8ZV+aLgUX7yqUmV+SsD6
	 J7AT0NLwWcoj3QivLIg93HpnQvd9IAfF4b4r2Dgs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4242F80236;
	Mon, 30 Jan 2023 15:04:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3ACECF8032B; Mon, 30 Jan 2023 15:04:43 +0100 (CET)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E6D3F800A7
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2023 15:04:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E6D3F800A7
Received: by mail-oo1-f44.google.com with SMTP id
 c29-20020a4ad21d000000b00517a55a78d4so57579oos.12
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2023 06:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5PM6NWeOBEY09iZrw1cZRUwWoqH70HFpiwLA+LMZM0A=;
 b=IvZBM6VVzHlPMcQjUtBsVXu3r2rjZH6osIWJ0vmAzxAqyRwyVL4QtG6CmDZtwT5ix+
 ai+N4xA0m+VKf/jVgfNDwkgiej5MtygY6Mr87+5z8dDGuIeTc0alilThlZ+lR1Vc0O8a
 6AsO9c0TC/MtL83xrsGhSjPNVQb7sxHfkhSmaD9e7wi4phqrCmOQ6+sxvQeQa2tu8TkS
 G666QK9gWFmF0/1gBgPtxM5r9vsElPIYtO8mfClgX/XeXTcO6UfJOR4/A9mt9hsEBVLM
 wy/QPj0XNoHt8Hw45eQ6ZU88fP7CJQNW8bSIyPQkwQ4JasggZDu4ZofdqbaT+C5bKphB
 t9wg==
X-Gm-Message-State: AO0yUKXoEz4CQAcdX5t7z2qyAoB810J8xKmdyOOKBCH5EkKu3il5Ziul
 UCLNymPgmEjDivpixmA2Zw==
X-Google-Smtp-Source: AK7set9jQ0BRP6WzHuitihRJ6AWAlAoW6QT/CNQYxhfOWXLPaS8b0vMZhLk0bkNRXvcw/EUI2QFD/Q==
X-Received: by 2002:a4a:d643:0:b0:517:6158:dbc4 with SMTP id
 y3-20020a4ad643000000b005176158dbc4mr3532528oos.2.1675087479460; 
 Mon, 30 Jan 2023 06:04:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 bq10-20020a0568201a0a00b004f8cf5f45e9sm4979833oob.22.2023.01.30.06.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jan 2023 06:04:39 -0800 (PST)
Received: (nullmailer pid 2346649 invoked by uid 1000);
 Mon, 30 Jan 2023 14:04:38 -0000
Date: Mon, 30 Jan 2023 08:04:38 -0600
From: Rob Herring <robh@kernel.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>
Subject: Re: [PATCH v4 2/2] Modified the schema binding and added the vendor
 prefixes.
Message-ID: <20230130140438.GA2329394-robh@kernel.org>
References: <20230126020156.3252-3-kiseok.jo@irondevice.com>
 <20230126020156.3252-4-kiseok.jo@irondevice.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126020156.3252-4-kiseok.jo@irondevice.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 application@irondevice.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, Jan 26, 2023 at 02:01:56AM +0000, Kiseok Jo wrote:
> Signed-off-by: Kiseok Jo <kiseok.jo@irondevice.com>
> ---
>  .../bindings/sound/irondevice,sma1303.yaml    | 32 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml

This is now in linux-next and breaking the bindings checks:

make[1]: *** Deleting file 'Documentation/devicetree/bindings/sound/irondevice,sma1303.example.dts'
Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml:28:1: found a tab character where an indentation space is expected
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/sound/irondevice,sma1303.example.dts] Error 1
./Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml:28:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
./Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml:28:1: found a tab character where an indentation space is expected
/builds/robherring/linux-dt/Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml: ignoring, error parsing file

Please send a fix. DT bindings also need to be sent to the 
devicetree@vger.kernel.org list. IOW, use get_maintainers.pl.


> diff --git a/Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml b/Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml
> new file mode 100644
> index 000000000000..eb87374cc812
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/irondevice,sma1303.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Iron Device SMA1303 Audio Amplifier
> +
> +maintainers:
> +  - Kiseok Jo <kiseok.jo@irondevice.com>
> +
> +description:
> +  SMA1303 digital class-D audio amplifier with an integrated boost converter.
> +
> +allOf:
> +  - $ref: name-prefix.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true

false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>

Why do you need this?

> +    i2c_bus {

i2c {

> +		sma1303_amp: sma1303@1e {

Drop unused labels. Node name should be 'amplifier@1e'.

> +			compatible = "irondevice,sma1303";
> +			reg = <0x1e>;
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 70ffb3780621..271ff119764a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -635,6 +635,8 @@ patternProperties:
>      description: Inverse Path
>    "^iom,.*":
>      description: Iomega Corporation
> +  "^irondevice,.*":
> +    description: Iron Device Corporation
>    "^isee,.*":
>      description: ISEE 2007 S.L.
>    "^isil,.*":
> -- 
> 2.20.1
> 
