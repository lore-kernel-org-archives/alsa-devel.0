Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EF5C17461
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:26:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF6E21D71
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NoL4l1sr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htgooDky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF6E21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF8C016D0;
	Tue,  5 Nov 2019 14:25:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF8C016D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572960402;
	bh=MxyHRxKd/si6AnAqh77V5tPjRsCy9lvr9HsK3lxxbLA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NoL4l1srvRJMA/qz9cAB9anC8TNOomPxUgNTLK4pq2NS8Y4+1ciD7wX6v4MzjcZge
	 c3Cp0yJValk+/GrjrJr0gdbmfkdkKlg6x2XaRpwidgySCamDMMXX2XsFjlf9Jv4G/9
	 t/eypGKveYDnbWOQsNkV/1KtM2cJswW60n7nS6P8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 508E3F80446;
	Tue,  5 Nov 2019 14:25:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1682F8049B; Tue,  5 Nov 2019 14:25:50 +0100 (CET)
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F3DBF80271
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 14:25:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F3DBF80271
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="htgooDky"
Received: by mail-lj1-x244.google.com with SMTP id n21so8199901ljg.12
 for <alsa-devel@alsa-project.org>; Tue, 05 Nov 2019 05:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oP2Qg5DulasBMIF938P1Bp5KL5tW1M0zdz+2GVaj+Uk=;
 b=htgooDkyaSv71Ti+556eAKWXlqMjpxkAkSOki+vleaBb6Av+WzlFduwJhyDFzZZxOZ
 0RyJiO0Z7zhxnuLxk6elZgul0SSMAmNWjfH8yz3iCC9YaQFHYrL/y/xQp8RdE+vT9e2E
 PngH+tXC+ktbnz7hEgGDXmhwX43XFwEqyzK+mv2tBGLw38RDkA/zJAVke51imLothgPi
 1GtM7Sxz+UvM5Iw2d9/g4J9unmhAExVIZ9sIALS8Yi0mhIp2PydULQBs7JnM1j0ZTzOi
 uPwTifHGSQadVDNDCxtIoQNt23BlJTEfXTi9ZSDdZmNio9+GMRgThfeecurQ1kgrdiFb
 J06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oP2Qg5DulasBMIF938P1Bp5KL5tW1M0zdz+2GVaj+Uk=;
 b=JTZlyLBAM8x+8sLSgA3gpqtz7fsAkOZcxUYsyROQpCi82kMZZ6/ZpyVMWidak/t68L
 zKas+df9QkVP6GWR85r/ZplE3Z/1mLVKnq13jq46GBRC27mV54Ei6zo2oVK+SVLpCTfC
 3wPjNtUiDnXTN4a2ZrrAkQTlFSUkoEYdGu8ti1vUVtt8AWEECwQBqRXg3gdW6NFejQba
 Z19pJzxGDfiBdChI5OQ3bRr6j+Q3l+DPWbEHEyxXSyOPpJq05AaGMAhu08OgBl2BVsBd
 ZlnccHw+665MsDne5+BoR5ZoBvH9X5SMSILaxpRkzf2IbKS9PQ7XLT8KghkcPPE7sm5Y
 Lgpw==
X-Gm-Message-State: APjAAAWKDq3R5Dqr4jVOOm7KDzfUGUrDSOiKX3bgbNB5sqvo8jf668ca
 sOChO3wwg4TVsnE48pW2tGv2b+qCKBOnFicPKOvjRSafVcs=
X-Google-Smtp-Source: APXvYqwGVvtw2JLHo5RcIlsIMDfC4bj7A1mhDFHbnNes729TrLIAwbe19y/dMBfnRaFx7NDuYWTABRX2z5TR4cfVNKY=
X-Received: by 2002:a2e:a0c9:: with SMTP id f9mr23474840ljm.77.1572960346944; 
 Tue, 05 Nov 2019 05:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
 <20191029112700.14548-9-srinivas.kandagatla@linaro.org>
 <CACRpkdYc-3Nk7VGj8mAjaM4C0dc_X7ZOK0cptW2Sr+kKwvyFVg@mail.gmail.com>
 <4f0e22ab-6aa1-2ed1-a85b-fb66531e0b2a@linaro.org>
In-Reply-To: <4f0e22ab-6aa1-2ed1-a85b-fb66531e0b2a@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Nov 2019 14:25:35 +0100
Message-ID: <CACRpkda2CdbPe7jsomZSxdJ1wE65OmNYDsZNj1OmfzdvG4kWng@mail.gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, bgoswami@codeaurora.org,
 Vinod Koul <vinod.koul@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, spapothi@codeaurora.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH v3 08/11] dt-bindings: pinctrl:
 qcom-wcd934x: Add bindings for gpio
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

On Mon, Nov 4, 2019 at 10:35 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> This controller just has Output enable bits, No pin control properties.
>
> As you suggested I can move this to drivers/gpio in next version.

OK perfect, thanks!

NB: this probably also affects the compatible-string which contains
"pinctrl*" right?

Yours,
Linus Walleij
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
