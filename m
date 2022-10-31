Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E148CFA3741
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Oct 2022 18:44:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 459AB1664;
	Mon, 31 Oct 2022 19:43:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 459AB1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667241884;
	bh=55x1depy2JzNFhSFL66vM4cLxC6hBA5Lbs5WSknMC7Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a23gLlvBdm8xCe3UClZ2OHTi7sAag6mjoCFmEJsFOegugkzDvbs8SLmwRdC0nqxkU
	 2zhU2bqs4Qp+1O0KjMmnev6PVGGhr0FANRtHnfS0pvl6IkzpwU9JjjsE9bgAoK92JO
	 eDKONY1GD35kuvSp3fVYyo0QaDb51s7qyatYJcM4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D232DF8015B;
	Mon, 31 Oct 2022 19:43:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11DB5F80163; Mon, 31 Oct 2022 19:43:53 +0100 (CET)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36A80F800E1
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2022 19:43:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36A80F800E1
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-13b6c1c89bdso14374488fac.13
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2022 11:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riEhJI8G7uoCQmZTrlcGBLPUnlTnsywRFiMnVaXjKWk=;
 b=ViIG2JzjABOw5I2LvFOOH29cH04li+L7a7VZfIUiB5Flqvc/gyA3/Z+TkVrL/P0LxG
 CTkFjnZ6td9OgsFBpg4q4z/ZOzwBs8S8wn02jSqhO4Bu7elRPuOXkwLgCte2d9Ppwtj6
 mRgHB98+NVrxcOA/ATggxAGPKCNP5LSte6eBNo3RzeL97xby1vREjM18DhlXVP66N77s
 hgekZg83bCCKdfBzu5o7SmJIikFGNURjlnAwE5V8tjOwxeh1FwtKUEmOjztU4+OSlpan
 zNnbfgb1n4LeruAUlYXyd4n7pwMceN+C0Fati7ClsOUhK/eeqjIhXxwl5M/6CLkWBvjn
 YjCA==
X-Gm-Message-State: ACrzQf0sTaukGy5nCC7kt6O9UJuq1paZ9ROOmEN7WmBaGeqwW1mhyz/Y
 qyTkBvAWO6FGHLFKTFR+uw==
X-Google-Smtp-Source: AMsMyM7NZtP3wDok5vjddQFKN4tnOsm2GF6RDetCJiSa5VMKaFm3TvtUFz0VGHdGPXkd/ZambwEHQw==
X-Received: by 2002:a05:6870:428a:b0:13c:4dd3:9890 with SMTP id
 y10-20020a056870428a00b0013c4dd39890mr14304964oah.295.1667241822059; 
 Mon, 31 Oct 2022 11:43:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 t3-20020a056870f20300b0012752d3212fsm3379647oao.53.2022.10.31.11.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Oct 2022 11:43:41 -0700 (PDT)
Received: (nullmailer pid 3240044 invoked by uid 1000);
 Mon, 31 Oct 2022 18:43:43 -0000
Date: Mon, 31 Oct 2022 13:43:43 -0500
From: Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: Document dmic_sel-gpios
 optional prop for two DMICs case
Message-ID: <20221031184343.GA3235956-robh@kernel.org>
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-2-ajye_huang@compal.corp-partner.google.com>
 <Y1vDYNOwZNOco1hq@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vDYNOwZNOco1hq@sirena.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 angelogioacchino.delregno@collabora.corp-partner.google.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>
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

On Fri, Oct 28, 2022 at 12:56:16PM +0100, Mark Brown wrote:
> On Fri, Oct 28, 2022 at 06:24:49PM +0800, Ajye Huang wrote:
> > Document dmic_sel-gpios optional prop for switching between two DMICs.
> > Ex, the GPIO can control a MUX to select Front or Rear dmic.
> 
> > +  dmic_sel-gpios:

s/_/-/

> > +    maxItems: 1
> > +    description: GPIO for switching between DMICs, ex Front/Rear dmic
> > +
> 
> If we're going to do this we should also allow the bindings to label the
> mics appropriately so that the control presented can reflect the actual
> hardware.  It does feel like it might fit better to do this separately
> to the DMIC driver as a mux between the DMIC and the DAI it's connected
> to but equally with the way things are at the minute that feels like
> it's probably disproportionate effort.

Are there other needs for DAI muxes? We already have a mux binding, so 
defining a DAI mux would work for any type of muxing control, not just 
GPIO.

Rob
