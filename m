Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DDFC4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Nov 2021 21:28:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15D3418EF;
	Thu, 25 Nov 2021 22:27:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15D3418EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637875686;
	bh=75S+hBrFEX3VzSy/0739q0wIlGlNXGImZl2tfL9tNzo=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mL3ueuAE+C7vFvzAOgleXPXfowRxiIWUbH29KyXRxWgOZJsH2sLW2RgKF+5znC9jo
	 9ofKxFFLz7kQ9+ZD1U/YjQc413VjqIRjsSIbF0QhWFDCE3oRbHslEPZrm+tou6BGw/
	 8fhozOs1mn4soxEH2/AevotLkzcwYTBvS3yTFCCY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB93AF804BC;
	Thu, 25 Nov 2021 22:26:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10745F804B1; Thu, 25 Nov 2021 22:26:36 +0100 (CET)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06674F804AB
 for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2021 22:26:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06674F804AB
Received: by mail-oi1-f171.google.com with SMTP id o4so14895684oia.10
 for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2021 13:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=Irmkz+2IkREM42YOJmVlq/heQU408FIz6tCFuZLCU8s=;
 b=Jmc5nw4oT9YlapX9bA0RjAgLmIAVh790tq52U111UTAwJLf8SU4KlZ2Ap/ZQBD+UWp
 axk12wTO5z3YkzmdVuYrc0luJyZeLpkT44mHWoL/TiZ6N2Zb4dpZY2voC6zs0/T93Ftl
 sADhvq9xIuC10gT3yVVTddK/KfgBj78hN9xkvo4pt8G52OI7S60xpiJ4IChzEPW4OccW
 Hm6/+EUIJ9zo6rRSLoXyrVD8zpkQKMf+bl8Al5kEIM739mXtj1BM2LidSqybtheia/tq
 oiHHCFuh0Mc11V+LyTF6Mmjyt85xM6dkntPvv5etnSu8dIPDYmVog/s85GIXMrQAb1Ys
 wVbQ==
X-Gm-Message-State: AOAM530spcRJrPNXqxtv9gUFlAbXituoPYQrptQqa6t5npLahIw9t4v6
 D2faIy5kR8dtCUcTwHxauQ==
X-Google-Smtp-Source: ABdhPJyEIeYGx4xMc1J7Gwjxw4a3IIrOE4Xx6LFo3WAtPewKP4oi94Bvlm37BYHDgo8Y45xaFqR2Wg==
X-Received: by 2002:a05:6808:3d2:: with SMTP id
 o18mr18848517oie.14.1637875586898; 
 Thu, 25 Nov 2021 13:26:26 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id p14sm670414oov.0.2021.11.25.13.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Nov 2021 13:26:26 -0800 (PST)
Received: (nullmailer pid 2858319 invoked by uid 1000);
 Thu, 25 Nov 2021 21:26:02 -0000
From: Rob Herring <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
In-Reply-To: <20211125144053.774-2-olivier.moysan@foss.st.com>
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
 <20211125144053.774-2-olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: stm32: i2s: add
 audio-graph-card port
Date: Thu, 25 Nov 2021 14:26:02 -0700
Message-Id: <1637875562.357461.2858318.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Olivier Moysan <olivier.moysan@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 amelie.delaunay@foss.st.com, fabrice.gasnier@foss.st.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, alain.volmat@foss.st.com,
 arnaud.pouliquen@foss.st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 25 Nov 2021 15:40:50 +0100, Olivier Moysan wrote:
> The STM2 I2S DAI can be connected via the audio-graph-card.
> Add port entry into the bindings.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1559750


audio-controller@4000b000: 'port' does not match any of the regexes: '^port@[0-9]', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/stm32mp157a-dk1.dt.yaml
	arch/arm/boot/dts/stm32mp157c-dk2.dt.yaml

