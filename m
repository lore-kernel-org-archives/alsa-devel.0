Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85498C4332F
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Nov 2022 08:05:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2B6B1816;
	Sat, 26 Nov 2022 09:04:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2B6B1816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669449916;
	bh=Q3ae5fcsJXVXYjRXnTdShKYoPBj7x8ti8dedQ1jviJ4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dFxDyh7zjNlX8G+g7V78poKb3x9vPWbgRmFI5EgyxeoR8vIilcnJ6JoFiMXeIyDAf
	 zMF5eU6y/DjrkWysAJZQwlvDnQz3Im30/GoyugBIKolYzn4DXe4IkwHO2WOSyvQMI+
	 026fzIM+TI0OZ2/J3xpObP3v3S8Fa/FnnO3FiZ/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62BFCF805E5;
	Sat, 26 Nov 2022 08:59:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA67CF80272; Wed, 23 Nov 2022 02:37:27 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4837BF80149
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 02:37:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4837BF80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="AJd4p4Y1"
Received: by mail-pg1-x52e.google.com with SMTP id b62so15587524pgc.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2022 17:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=57QTDQNjua4bD17eBQRGR4QYAKmDZiaeZv3y3ThjHNA=;
 b=AJd4p4Y1GJ2PPHHqMJkt2vAn6ERqJlfv48oiJrZolP8/Sh1CAzdLzBPA6Y9SygNMOB
 ZL09xzKfYY7O9Doh92VB3jb6Ja8HBaQeBTEaB8nC72ZjmyawK/usRw5XgujG3BFx/tAa
 YQzpVS/GviFMu850709iF5BIFlEAro2HnvijgpS0DgkaoVdPf+crlJ8hgf6xE8Hefq+w
 79hHmd2FIBoMnyNG0wJ0UGHjyN8DYJcXF/xPRlPXnE/3S7V0L3QNV1H73/xPNO9zBSaj
 Pg4w7ZIQmKiJxfxA9pfQlebDCPWdCV3XIz9WLiDa5A8wWXQqx8dPEJlxFOfUf9f5WHlm
 xytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57QTDQNjua4bD17eBQRGR4QYAKmDZiaeZv3y3ThjHNA=;
 b=xTWMlZNW9ePblnROcwoZZh97z3dmFWxFKXUf0y5IVRg2BEBZZ/8ahgh3JwsB4HcgoP
 RC0ZB0tihkjW+2SIiiwy+u1Z/OA+PYHwgyP6T+uq9M9NFT8+JGX020rdjyWDUwZI7oXm
 3mOSCp4gNZcHgPd//3rAHWFGGhKzlc3YveuNcQKvOXSfcc3tw5C3kWTgfHEXKJXi64u0
 O4agPBa670VNWD42r/qgLabWYuW1IpfjxQMr01IYkOV5OJHg2p4GdBC9rGv/lS5cIJvx
 Y/G88JPJU3zGMRe5b6oeiJqQcsYISTHah/UVO60DvsLHJS7Vm4jj1JZy4M4jMb8CQfMp
 2rdw==
X-Gm-Message-State: ANoB5pk6ffAGWo5Vl5P7qo1F2qcgWScVmX284OC52geYTjqbq5hh+h/Y
 QDKhs6lDGcPCCJAHnedeKIY=
X-Google-Smtp-Source: AA0mqf547JrxZeSVmkQLdlrpalzLSYM74m3LOUHFPzZ3vcYEWkifg+t/S5X1eHUvslK9HNQURfIwrg==
X-Received: by 2002:a63:de14:0:b0:477:4a61:eb99 with SMTP id
 f20-20020a63de14000000b004774a61eb99mr16322572pgg.48.1669167442801; 
 Tue, 22 Nov 2022 17:37:22 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:af8d:6047:29d5:446c])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a17090a674400b002189ab866bfsm204545pjm.5.2022.11.22.17.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Nov 2022 17:37:22 -0800 (PST)
Date: Tue, 22 Nov 2022 17:37:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 9/9] dt-bindings: drop redundant part of title (manual)
Message-ID: <Y315Ta+ST067iVmh@google.com>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121110615.97962-10-krzysztof.kozlowski@linaro.org>
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

On Mon, Nov 21, 2022 at 12:06:15PM +0100, Krzysztof Kozlowski wrote:
>  Documentation/devicetree/bindings/input/fsl,scu-key.yaml        | 2 +-
>  Documentation/devicetree/bindings/input/matrix-keymap.yaml      | 2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
