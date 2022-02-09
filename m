Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B09C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Feb 2022 21:03:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D495F18BE;
	Wed,  9 Feb 2022 22:02:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D495F18BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644440588;
	bh=0uQoH8O7jy+a4m+KKuuUanG/F9QQn/PBe+BJ8aeTv1E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PS0hx72ALR14ldRbUJbV/So0hOHQTyr9wUVuYE4pz/VJKBSoJj4e19DBiCKZnJr8W
	 fgmexR+0yDVqo9JKuHgztFGgHyZ5ubzW6cLkkWoiU21mC4oY4nbL0GuYbt+3CdKK4n
	 Q0XlWivAZwqWNqrowc5RaWvpFFGuJ0K/QjzjyRw0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EA83F800A7;
	Wed,  9 Feb 2022 22:02:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD981F8016B; Wed,  9 Feb 2022 22:02:16 +0100 (CET)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E939F8014B
 for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2022 22:02:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E939F8014B
Received: by mail-oo1-f47.google.com with SMTP id
 p190-20020a4a2fc7000000b0031820de484aso3918307oop.9
 for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2022 13:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uqMJ5pzDSIfGFtp8phHCNpFXexGgfsJe1tkP341IGSw=;
 b=Zomg8srIWSk2Vv+w/6wulOwB102LW6bxMQyPViRCCkPO5gDQlIdveIUZPItgKYfvKL
 qC2LyQ/uQBC9Jml0+ODodVchyH8YdNzYUjDWZdfoEemoU415uqL3Hf2myaq48sbgA+vu
 u0vX63JxRYJ106a6RsRLnxMWIaeGjFruW2/MKa6YzpEkxUTAuRlluJH/L9wQfMfBHK5y
 rkqbsy9V7YUL1N9GGcMIFUJs2rj+nOUKCrx/9xEI1y4dBqqrTX/42hRR3+mzQQA7U17D
 7qD9YRVUDw1RP29N0cLkI9z6VH6IjZGL4jl9n5ZJKg0fZiBQMs+4n/X7zQFB9dTegwiD
 prWg==
X-Gm-Message-State: AOAM532eFIwsefU9x+LgbtSCamNsrwqgxvniL0tWefAmvq5em1WMt67j
 oJajCbpENynhcPm7SAb/Kw==
X-Google-Smtp-Source: ABdhPJzXACJWwdiM5VhZ/DDuTscLU4MFdCxK6TgQGBOID8HvPrRhukIR3/QEt6KA8gv9Ks5tKVBJ3Q==
X-Received: by 2002:a05:6870:e7c5:: with SMTP id
 q5mr1605332oak.284.1644440530853; 
 Wed, 09 Feb 2022 13:02:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id l15sm7101269ots.28.2022.02.09.13.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 13:02:09 -0800 (PST)
Received: (nullmailer pid 904638 invoked by uid 1000);
 Wed, 09 Feb 2022 21:02:09 -0000
Date: Wed, 9 Feb 2022 15:02:08 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 5/6] ASoC: dt-bindings: samsung,snow: convert to
 dtschema
Message-ID: <YgQr0BTV4WDnDXrd@robh.at.kernel.org>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
 <20220129122430.45694-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129122430.45694-4-krzysztof.kozlowski@canonical.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Jonathan Bakker <xc-racer2@live.ca>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>
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

On Sat, 29 Jan 2022 13:24:29 +0100, Krzysztof Kozlowski wrote:
> Convert the audio complex on Google Snow boards with Samsung Exynos SoC
> to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/sound/samsung,snow.yaml          | 74 +++++++++++++++++++
>  .../devicetree/bindings/sound/snow.txt        | 31 --------
>  2 files changed, 74 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,snow.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/snow.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
