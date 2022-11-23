Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF754C4332F
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Nov 2022 08:05:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E25AB182B;
	Sat, 26 Nov 2022 09:04:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E25AB182B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669449901;
	bh=rUPpYbUUGmgOAkiDHusTJuG8ADtS22Ey9WaSxSLtmts=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y9KM6lA/9QPIjwD6Dg/RpQsXDGfxTLpttSrXYtq9tP6eTc6pNQmlyaNq5IVR2uU0K
	 nH3CpAGGs/r4rJZSJf+1vN8+uVlVYgeVDre5rOfuuSOqWfAABEA//kj0SURZiUFKm1
	 bd5MAS62LWPYItIHYzTXLIYJCK62rATByYrQOlzY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1618F805DA;
	Sat, 26 Nov 2022 08:59:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9374EF80272; Wed, 23 Nov 2022 02:36:19 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28EB9F80149
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 02:36:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28EB9F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="oUgfZGpf"
Received: by mail-pg1-x52d.google.com with SMTP id q71so15518459pgq.8
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2022 17:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VnT85l1YGrgftRmY4cs0kf1GLdUSkFh5ZyBQMsB8/d8=;
 b=oUgfZGpfTt3n+gdaAcgz00Mug4dCBCNB/xDdXlVP+K6uV0glmqUHVVcqvQO8b0rrYS
 k3IzWT0SIbOyFZv/D/7QcoURlIYUwvOvNaTu7L+CZNAwJYt1nt0rIwdpZN55gZjFPVDI
 QJECxzixlHdMg1q1pT9qIYI9+GhiFa1fqTUgbMKyAYcqpJDuaoCiKXQVuUOwTk0jlTjZ
 3Uev4hAehD0PGurOWFjtKN6iyx6GnRSSpFJyRNen7Sb0J7XCDoK3YT/eXmH0m93Yr+Jz
 aTw2wWkj5t9YMQ8PpTDjD/+uILOjduYoHPN5Xsw8eSbyvQHXUtHPQgtQs1cq8HHs6mn/
 8jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnT85l1YGrgftRmY4cs0kf1GLdUSkFh5ZyBQMsB8/d8=;
 b=Go8/ruifLMO50H4wcFLunXBfp+62DmJsDutE/WW6qz8db8iY1jxJ+Y/8wCtxEZKJC/
 CW9unviY6V4EYS7/zuOklZ9DMvL+RKQOcUK8RDUvm4l5nADdyCqaJXAljBdJ3e8WPmqc
 2hIPlwH2KNmkc1mL1LxZktHQ0vWHlgF7P7mzCeFak1kwVFkerT/pQZwI5zBaqmjeOZO8
 mHgyVwLRSzPkDRMktlPzkGFT6IDyB2TRNETYB+TrQEOwGkgDmohdQBkoKxIFYSsf6jJ2
 P1oZyNqUInV5HOM5ZCaVb207XV33H9nAhcmu7urtd1GIqWh1URhCKROD93tThz8LPEro
 JwBQ==
X-Gm-Message-State: ANoB5pl7k44hASQxEqgokayaoUdibmFeP7hXff3uc1TAoYCyOvrDilnZ
 EqPjB4Kp8d21albhxRv1Zcs=
X-Google-Smtp-Source: AA0mqf78pgAVtMq8pq+tCGwJHeM7QPMfI1EDDft+2+fSPKOuH2O4/vhP5xQpLF4Y0UoxHBvM5RyLQA==
X-Received: by 2002:a63:ff0b:0:b0:477:362d:85d3 with SMTP id
 k11-20020a63ff0b000000b00477362d85d3mr5493742pgi.395.1669167374414; 
 Tue, 22 Nov 2022 17:36:14 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:af8d:6047:29d5:446c])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170902b68500b00186b758c9fasm12680124pls.33.2022.11.22.17.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Nov 2022 17:36:13 -0800 (PST)
Date: Tue, 22 Nov 2022 17:36:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 7/9] dt-bindings: drop redundant part of title
 (beginning)
Message-ID: <Y315CQUTFYocBnfS@google.com>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121110615.97962-8-krzysztof.kozlowski@linaro.org>
X-Mailman-Approved-At: Sat, 26 Nov 2022 08:58:53 +0100
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pci@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mips@vger.kernel.org,
 linux-mtd@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-rtc@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>
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

On Mon, Nov 21, 2022 at 12:06:13PM +0100, Krzysztof Kozlowski wrote:
>  Documentation/devicetree/bindings/input/gpio-keys.yaml          | 2 +-
>  Documentation/devicetree/bindings/input/microchip,cap11xx.yaml  | 2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
