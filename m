Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B7C432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 12:51:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E25610CE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 12:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51E25610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D24117B1;
	Thu,  2 Sep 2021 14:50:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D24117B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630587083;
	bh=qFjfjVpGOsKXI12iar5Zts75GgdYjA7bDPBjNZm9iWc=;
	h=References:From:To:Subject:Date:In-reply-to:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sLWDDk/YykRpQYiC7ih1mdpi4xMwBjbgl82uouxI6/bgxbaHgal/Ai8mwc7ZfY+AC
	 fXNV+tpUP/lpySIq5Ptk7FsFlW+QcKtKa8SPN0o3EinBe6G5qzofpgL8zKnWR9KoAR
	 rgsvUq2vSTMph/PvuIngCHtENt0Ovn+E4GNZttdo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75A9CF80125;
	Thu,  2 Sep 2021 14:50:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4EB8F80269; Thu,  2 Sep 2021 14:50:30 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CE75F80125
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 14:50:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CE75F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="oSqbiZE3"
Received: by mail-wm1-x32b.google.com with SMTP id g135so1190694wme.5
 for <alsa-devel@alsa-project.org>; Thu, 02 Sep 2021 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:date:in-reply-to
 :message-id:mime-version;
 bh=a67C6dNL5nIJT92Nus3ptLY8+mQH3bjCFrhDFLwmJFM=;
 b=oSqbiZE3H987kD4hq6o9Ds4oDd3rs+cX4AFxRA6Ef6dJ8+NceyxkAikOSVSziB+BjE
 bunyHly9lgp52gmixcJFwTO+qIhQwz+mO5cB70pOD/wE/qSr4jQsEwviDcn29O3ZRbGm
 2smfKt0cLilFMBrhxz9oLoBT9Vf+T/W2Q75wTVKQbZbDjvCkdCKJnQH5Ys4+7AVVSNoY
 qkGXeuuHloTvVyfmtruFOxY7d7s1qx8iPFbYIitgZdO6la4enQhKVkcSHd+s6l8G4p+i
 5YliV3McHq4EwYehkeoh6Q/2sdAJtCyNfOSG/Wt95LvbeIXPPDy0piWpYHJGc3SRdTxv
 r1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
 :in-reply-to:message-id:mime-version;
 bh=a67C6dNL5nIJT92Nus3ptLY8+mQH3bjCFrhDFLwmJFM=;
 b=b5PvjVj5wzaxLwelOsRs15r7q+BuTHXSlSbCbEEOchf/juhxHr32r/hwP/iIUu8d9m
 a5A71odTWyS6s906K/xiYuWrOv2+4t7p2W91o++rJs7swvKxDcFnoyjfSuM0w2wwm8rJ
 3y6HsHBQZKEWslvuxrL4QYVloK8UdVFRDhUYHfy0Yz+NjYPC1vn2e/Q9NZyGJ3jhWlTi
 +XDJBUphRL8rKAMkdgBevL7L8mBhe6fv2J8nN+62CcuQlwqMefPqYo0YIJkVsgryYYTL
 FB1iwfZV2H9KTY0920O8jApL7GwXxnMwYSjMTOf2OI6Pn+9nCA6iLIMiyPwi1LTjuc9/
 ZTNA==
X-Gm-Message-State: AOAM531tRmzhEJeJL+QNu5JVkYxvTH4OHPT3T9InaQDjg9qsywxKYRV3
 ebWzilpfH8V5/+bCPFhcxaKJcw==
X-Google-Smtp-Source: ABdhPJzdZJ+Ta6IS5+ARF1e91+6ra1TrvOd1v2Bx44u/bXB4BQfewSiivQ+Jp8r2eWIdUAEwOPPJMg==
X-Received: by 2002:a1c:98d8:: with SMTP id a207mr2918351wme.16.1630587022216; 
 Thu, 02 Sep 2021 05:50:22 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id q17sm1728988wrr.91.2021.09.02.05.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Sep 2021 05:50:21 -0700 (PDT)
References: <1630562033-13231-1-git-send-email-spujar@nvidia.com>
 <1630562033-13231-2-git-send-email-spujar@nvidia.com>
User-agent: mu4e 1.6.5; emacs 27.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
 lgirdwood@gmail.com, robh+dt@kernel.org, thierry.reding@gmail.com
Subject: Re: [PATCH v2 1/3] ASoC: Add json-schema documentation for
 sound-name-prefix
Date: Thu, 02 Sep 2021 14:47:27 +0200
In-reply-to: <1630562033-13231-2-git-send-email-spujar@nvidia.com>
Message-ID: <1jpmtr5egi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 stephan@gerhold.net, linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org
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


On Thu 02 Sep 2021 at 11:23, Sameer Pujar <spujar@nvidia.com> wrote:

> The 'sound-name-prefix' is used to prepend suitable strings to a
> component widgets or controls. This is helpful when there are
> multiple instances of the same component. Add relevant json-schema
> and is inspired from sound-name-prefix.txt documentation.
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/sound/name-prefix.yaml     | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/name-prefix.yaml b/Documentation/devicetree/bindings/sound/name-prefix.yaml
> new file mode 100644
> index 00000000..b58cc9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/name-prefix.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/name-prefix.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Component sound name prefix
> +
> +maintainers:
> +  - Jerome Brunet <jbrunet@baylibre.com>

Since this file is referenced using "AllOf", am I going to be listed as
maintainer of all the drivers using the property below ? I'm not sure I
want that ... :P

Maybe it would be better to drop the above ?

> +
> +properties:
> +  sound-name-prefix:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Card implementing the routing property define the connection between
> +      audio components as list of string pair. Component using the same
> +      sink/source names may use this property to prepend the name of their
> +      sinks/sources with the provided string.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    analog-amplifier@0 {
> +        compatible = "simple-audio-amplifier";
> +        sound-name-prefix = "FRONT";
> +    };
> +
> +    analog-amplifier@1 {
> +        compatible = "simple-audio-amplifier";
> +        sound-name-prefix = "BACK";
> +    };
> +
> +...

