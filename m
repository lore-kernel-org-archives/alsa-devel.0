Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C59EB64D7
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jun 2023 16:39:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BE9882B;
	Tue, 20 Jun 2023 18:38:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BE9882B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687279164;
	bh=Fm056OSTIhRo83KhL7siQR3ePTJMKL5KIdQMAtYyBoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=a6NYMdQfw9JhfauM7c3y8Nq9x5J2Cj8vn8RjeSyE/Ta8Sx84azI7iTxl/cAN3mQle
	 WHOmsdc/X46cUgAEk385g11gPw/mEsJryolRiGIx1z+nhHdM5svcXqfWGUKpv9M5ad
	 cjo+QainAgluvu+FhSFvX9ihv69xcYyXLJYBJAQs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F630F80124; Tue, 20 Jun 2023 18:38:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 064C9F80124;
	Tue, 20 Jun 2023 18:38:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A564F80141; Tue, 20 Jun 2023 18:38:02 +0200 (CEST)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com
 [209.85.166.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0B917F80130
	for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2023 18:37:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B917F80130
Received: by mail-il1-f172.google.com with SMTP id
 e9e14a558f8ab-341c362a851so18814125ab.2
        for <alsa-devel@alsa-project.org>;
 Tue, 20 Jun 2023 09:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687279074; x=1689871074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzHhBcGehlWwZFYVf8Mcmgg1mKcLxdLW5Zggyy+CCXM=;
        b=LkoKWvdukU3VlwaU6m+k5AymCCCt0GNnQXn6MjVBc+J8b3buO0ClaxtdX6c7Oilh0e
         7RL5Fvm/D9Hb4MEAWs+HhOqeluXxFoA5ERpuxO+ga7B2ZwGbyjKAl9qX3Nl/giQGYyv0
         gfUI8M6bt6TCnVz69iarKIvIHLxHdCIsEN+IG8j6Jx+clC/pb/VbmTZeXFm0hCN0z79C
         YFXFMWjyAkpDIvq+SK12Jbx3m/zfPQy0u3e236G46fmK9UuFLglvi6XRbnEWSCs/ynLn
         +7DgwL/LhJKx9JioRHGfqDGo+i/iFaH/z+y0mYukOjzUW4B9VLcg3gZMHdvMKiGUSmFE
         pKIQ==
X-Gm-Message-State: AC+VfDyJdeCUdWBVq9VdxFfw2GZz41IjVToE9ZlvgvgddtYlZatKqt2y
	3/wWBwVWskihNh4WPzSBnA==
X-Google-Smtp-Source: 
 ACHHUZ4zJSh5ti9pvnIfdniu0E1NqvpspqRuuhbVpluLjMmbPmBKj+IVLp/KcN4Qlye8SWQ/35QrFw==
X-Received: by 2002:a92:c80a:0:b0:341:c806:a8cd with SMTP id
 v10-20020a92c80a000000b00341c806a8cdmr8907661iln.6.1687279073923;
        Tue, 20 Jun 2023 09:37:53 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id
 a12-20020a056638018c00b0041f4bd6f285sm741308jaq.37.2023.06.20.09.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:37:53 -0700 (PDT)
Received: (nullmailer pid 3789063 invoked by uid 1000);
	Tue, 20 Jun 2023 16:37:51 -0000
Date: Tue, 20 Jun 2023 10:37:51 -0600
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: devicetree@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Conor Dooley <conor+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 alsa-devel@alsa-project.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v5 01/13] ASoC: dt-bindings: Add audio-iio-aux
Message-ID: <168727907001.3788984.8001897155371948964.robh@kernel.org>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
 <20230615152631.224529-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615152631.224529-2-herve.codina@bootlin.com>
Message-ID-Hash: 5DPPKHS3DYW3SJ5QSSOGVOTK2YVY7CH6
X-Message-ID-Hash: 5DPPKHS3DYW3SJ5QSSOGVOTK2YVY7CH6
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5DPPKHS3DYW3SJ5QSSOGVOTK2YVY7CH6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Thu, 15 Jun 2023 17:26:19 +0200, Herve Codina wrote:
> Industrial I/O devices can be present in the audio path.
> These devices needs to be viewed as audio components in order to be
> fully integrated in the audio path.
> 
> audio-iio-aux allows to consider these Industrial I/O devices as
> auxliary audio devices.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/sound/audio-iio-aux.yaml         | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/audio-iio-aux.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

