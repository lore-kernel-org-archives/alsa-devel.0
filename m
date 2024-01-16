Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A996C47077
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jan 2024 07:15:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B62A1741;
	Tue, 16 Jan 2024 08:14:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B62A1741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705389300;
	bh=0jXPULuxKjAHp1fGEKYMvFVw7W1lTlRo1G/fqz3Znm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Vq3dNyPzUCPG91+HRwF/sE3algPNvC/hH73xVqT6VaxIFz4t4AGVPDu4/67qMr+Er
	 My6OlW1wY3kkUHQe9Z+HIn2D1u69GcAswzlnwlqM4XpRnjyCu/cYv0NqNbJbhSRUfN
	 Xyozf+FFD8JArQq+jiaW1zryN40+Ld5nVyY0mU2I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E46C4F8056F; Tue, 16 Jan 2024 08:14:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2198DF8055B;
	Tue, 16 Jan 2024 08:14:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 476A6F801F5; Tue, 16 Jan 2024 08:09:48 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3E98CF80074
	for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2024 08:09:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E98CF80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=bKPsEzxb
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8AD8FF804;
	Tue, 16 Jan 2024 07:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705388978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yUvUcReGBkElI2bmZKIO4xQ6SjA4NJ7bZ4nmKyK7rFY=;
	b=bKPsEzxblr3OEfqCH5RxNFVqs9iTZyN9I7oFT2CKPJSeJx0AB+NoP4uHsoOcTfMU/A2fjt
	OzM2OXeg4hrs+cc0MRlgJG0bF2LTDQHBlwrhTqMHrLXVWcwguKPo3SOsxF348wksayN09+
	uJ2ehU5VT4RD20/jFueTGl0rDIZRy6RlwrNyi0kIjPzpDuyLAgmKMdtiUcRmTZ/zLRn4fc
	rPWHfHFXXHzCcwX13w6fiXq0ypvp5vZnZPiiiGsNBh8SLJQLNIiV1wD3T2isJAgePMrnET
	Fq3GxDjvsCDvgG2LR/qU6EQ/lFQPaqgXvl5xfzTKbNuQv3SMJkqfdM0Q2l63IA==
Date: Tue, 16 Jan 2024 08:09:37 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: dt-bindings: Do not override firmware-name $ref
Message-ID: <20240116080937.3f66ee0b@bootlin.com>
In-Reply-To: <20240115182017.1610055-1-krzysztof.kozlowski@linaro.org>
References: <20240115182017.1610055-1-krzysztof.kozlowski@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: HXZN7VXQV637KJYALWNRBCD27O2RHC3V
X-Message-ID-Hash: HXZN7VXQV637KJYALWNRBCD27O2RHC3V
X-MailFrom: herve.codina@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HXZN7VXQV637KJYALWNRBCD27O2RHC3V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Krzysztof

On Mon, 15 Jan 2024 19:20:17 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/fsl,easrc.yaml        | 4 ++--
>  Documentation/devicetree/bindings/sound/infineon,peb2466.yaml | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
[...]

At least for the infineon,peb2466.yaml,

Acked-by: Herve Codina <herve.codina@bootlin.com>

Thanks for this patch,
Hervé
