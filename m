Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36887ECAAD5
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Aug 2022 14:11:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 961C615E5;
	Mon, 29 Aug 2022 16:10:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 961C615E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661782291;
	bh=FttOGuMn6yJvsv3vvmzPkNHQOCpVhlGfSOYaNrPGKsI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ob9jihqgajmZHm0VhajUCTJEMKG+j6ZZk3efPeK0RjhxVIqxwkqlSFq14mf1VY8fy
	 L0kspQC4pcyp+KXst+i/J8RvWccdSfjIKEkFdMh/SLvuy3PuR+7CuT0qHfvx8bfaq6
	 rewD/CPuiVhMt2D/I+JFGps5bX9kWd8QjruDwLJg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A96EF8016C;
	Mon, 29 Aug 2022 16:10:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 167F9F801F7; Mon, 29 Aug 2022 16:10:39 +0200 (CEST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 159DEF80115
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2022 16:10:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 159DEF80115
Received: by mail-ot1-f47.google.com with SMTP id
 r1-20020a056830418100b0063938f634feso5958664otu.8
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2022 07:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=opbj1lT2rqww+Ko38iiUdytadU+k9CoQLS7KnrXSbyY=;
 b=O+Y7D3ANDnBhEgherPC2JdOS8lk2PX3OA1hsnDH9xwnq1Dmlxf+6XOfHMnIFFVZVQi
 1W6NS5LHYemMKYbMZto7DXEO3xz65T0UBLLxBHY8pcWErzwNUtN6HwHPu5VqtwryJofR
 jGObBbi5hTyn8d9N+SgxmSx1wgos53Hw3Qm6e+yho9CZQIO49/CTH0PxzGG3HSgLQZZ7
 6jWPZ9oik7/HG1hYPB2oZ9JYplD/zC4HO+pLfTHAPMqDPDf0Ucq5pykONwadnrCZxYvk
 tY6zl0Zd683Vr5qxPSE11eD2On5dViygqrMwjHdPAhcPcCNo/U788ZrtWMOWdWNVVRAN
 7Ozw==
X-Gm-Message-State: ACgBeo2A/Ls8JXg2IVmaaCp1PmzhbaW54FZMn1KXNHXbFi7MRninb+xr
 GV/rd/A+muQCC+HnypEDIg==
X-Google-Smtp-Source: AA6agR7WIHe/AiLYD102e5d5uKFjLIhVyxUpACShz6LmoyBGjUcs44MJ20snIPOKxNFUVwlVnmhpXw==
X-Received: by 2002:a05:6830:3914:b0:638:f80c:e964 with SMTP id
 br20-20020a056830391400b00638f80ce964mr6530478otb.220.1661782231113; 
 Mon, 29 Aug 2022 07:10:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 y5-20020a056830070500b0063b2875246dsm2805095ots.49.2022.08.29.07.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 07:10:30 -0700 (PDT)
Received: (nullmailer pid 1485236 invoked by uid 1000);
 Mon, 29 Aug 2022 14:10:29 -0000
Date: Mon, 29 Aug 2022 09:10:29 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220829141029.GA1470207-robh@kernel.org>
References: <20220823145649.3118479-2-robh@kernel.org>
 <99dfcc39-ab1b-1b24-c6b2-67de5509f5ac@linaro.org>
 <20220828180050.51c3e857@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828180050.51c3e857@jic23-huawei>
Cc: alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-stm32@st-md-mailman.stormreply.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michal Simek <michal.simek@xilinx.com>, Andy Gross <agross@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>, devicetree@vger.kernel.org,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
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

On Sun, Aug 28, 2022 at 06:01:41PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Aug 2022 15:04:33 +0300
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 23/08/2022 17:56, Rob Herring wrote:
> > > In order to ensure only documented properties are present, node schemas
> > > must have unevaluatedProperties or additionalProperties set to false
> > > (typically).
> > >   
> > 
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Applied to the togreg branch of iio.git and pushed out as testing for 0-day
> to poke at it before I push out as togreg for linux-next to pick up.

Thanks.

> Side note. Some odd entries in your cc list...  alsa-devel?

Blame MAINTAINERS:

STM32 AUDIO (ASoC) DRIVERS
M:      Olivier Moysan <olivier.moysan@foss.st.com>
M:      Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
L:      alsa-devel@alsa-project.org (moderated for non-subscribers)
S:      Maintained
F:      Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
F:      Documentation/devicetree/bindings/sound/st,stm32-*.yaml
F:      sound/soc/stm/
