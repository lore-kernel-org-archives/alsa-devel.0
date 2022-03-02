Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1EFC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 18:27:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B1CD1E09;
	Wed,  2 Mar 2022 19:26:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B1CD1E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646245636;
	bh=Isxar0EW0YYDC4JSdOUXwTeZTdlocZR+YIHwLGI7gBQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KoQ/tE44aWRsB8f/vUwctjijAUHA+Q+eQxptdLyyBPwKdcm1iwVHdxyDljCd32F67
	 7RwPg2lsyFjhwg27SSCDo1iiBeuQV2IKq0p0iNa0Zc3VQs9CjucZwqKe0iFT6aFgiQ
	 QNlXVntu3HjQiNVSN+2H3Z934aTEW0E6juq29JRY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8978F80054;
	Wed,  2 Mar 2022 19:26:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA2CBF801D5; Wed,  2 Mar 2022 19:26:23 +0100 (CET)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80F7AF80054
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2022 19:26:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80F7AF80054
Received: by mail-oo1-f47.google.com with SMTP id
 189-20020a4a03c6000000b003179d7b30d8so2900247ooi.2
 for <alsa-devel@alsa-project.org>; Wed, 02 Mar 2022 10:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gp5Jdmk2dY01jJhkaIqI8FmvvsypijQinV6Nl2+9H60=;
 b=HGb4DzepBTfcX/bnhoa/YFt+YZEvLuSh/mgAEPtqbwCMtQXk/BS1k4CDaynw5MVFoK
 MUOoE6EZVmMpUlzQITH2vrPB1lx/SXFeztjdE0hfdxepL6N1HF/38cRPKarihXsSjKTu
 R2RScP/7ohEn+FAg8jiaJny9v3PdhWHB5KUckqUtEKmACjTUXevwhqNtsc6U0LfbulRT
 WpJCMkFA1rsuDI2dX0OccncIseXEojo6Wvzg5ccwOZnj4hlypzkI/jCy9ELGQJjOawMk
 XNJswTELYIdnxC8raGUlUkvzDVsthEK+pPntnMGLF8eJNrFdsntBNAefnOhKoFzMh1yu
 kExg==
X-Gm-Message-State: AOAM531/rrBhfchMFUlTV9GtBs5UqPpPZNXQgC8mPjy2QQa+pmn7Ibyt
 htg4+RaNrPKmkAiovaCL5A==
X-Google-Smtp-Source: ABdhPJzd+O7A99MupgLERBXMFwobcVlOnqp9kDZUoS0YxaahYN/XpsZZcmkdwvpvhNVcY83SHENxSQ==
X-Received: by 2002:a05:6870:64a4:b0:d9:adda:905f with SMTP id
 cz36-20020a05687064a400b000d9adda905fmr865258oab.147.1646245575833; 
 Wed, 02 Mar 2022 10:26:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213]) by smtp.gmail.com with ESMTPSA id
 e199-20020a4a55d0000000b0031ca56292bbsm3236471oob.46.2022.03.02.10.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 10:26:15 -0800 (PST)
Received: (nullmailer pid 4006322 invoked by uid 1000);
 Wed, 02 Mar 2022 18:26:13 -0000
Date: Wed, 2 Mar 2022 12:26:13 -0600
From: Rob Herring <robh@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add schema for "awinic,aw8738"
Message-ID: <Yh+2xUpQLftfZ0UU@robh.at.kernel.org>
References: <20220301123742.72146-1-stephan@gerhold.net>
 <20220301123742.72146-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301123742.72146-2-stephan@gerhold.net>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
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

On Tue, Mar 01, 2022 at 01:37:41PM +0100, Stephan Gerhold wrote:
> Add a DT schema for describing Awinic AW8738 audio amplifiers. They are
> fairly simple and controlled using a single GPIO. The number of pulses
> during power up selects one of a few pre-defined amplifier modes.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/sound/awinic,aw8738.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw8738.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
