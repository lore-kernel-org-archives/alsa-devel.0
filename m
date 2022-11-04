Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B47C433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Nov 2022 21:53:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 805F21621;
	Fri,  4 Nov 2022 22:52:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 805F21621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667598829;
	bh=UnPRkrZZlbIULT5uoHM2ziGHJnjnlxtrtV0AlpnW1hU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=awSsjH9aD2GThSyl9m4aJJaLuSN93nRhAWRA1knRYb8lomzt8lfmQDvMO9CbFK1Ag
	 E6zxwZM7PJDkI6S24lNBOtwdYeVi+hVsWbtsX93cki2xVQgOaQACKMC1Vh/vXhpm3m
	 2hUxI4h/4Nx3/1NIGlZP10YYXMczdFmdImZfTLN8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE3FAF8049E;
	Fri,  4 Nov 2022 22:52:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F238F80155; Fri,  4 Nov 2022 22:52:47 +0100 (CET)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4BC80F80155
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2022 22:52:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BC80F80155
Received: by mail-oo1-f44.google.com with SMTP id
 r76-20020a4a374f000000b004988a70de2eso857477oor.2
 for <alsa-devel@alsa-project.org>; Fri, 04 Nov 2022 14:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gcaftyW/+TrxlNzLFepPQcr49mClWw57ztjikQx867c=;
 b=M7B42wOfWnrH+gKWGWAcbss7LpdmrqFbz+LYkS6ff7w1kyb2sK3TTRh4EcO/NpjVb/
 hbgrvHkKTsclYPe7+/Rb6S+096ycBH6Fd9sXb3uaPn8h4RQ6ui6FvzNUgeRtmb7wW4J/
 NMHU4YPWGf6anSCp9EissLppYM/ocayY5fhQjJpNJtct5ssUGviOa3aPgpmL3MeHE2fl
 eMrUi/HS6hLK2hAU3phbMy+ydliKyLFYZdMsPClWuFnXb7xdeSh6vGryy2yl7aLZ3rC4
 4DqbvoKOGimyK35q/JdoWeLGLHF9SarbSSFbGCwmXLyQfLUNIoas+NcYhcgrY+tWF2Eh
 K9qA==
X-Gm-Message-State: ACrzQf2gS0Us2HmFgiyRmqP6dyJAmb4E85kQlf6rGMmkCyIe9fWfvC4b
 7pc1AnV2hzYcLmpQBHIoPw==
X-Google-Smtp-Source: AMsMyM4gGiFUX7wv5obU69nMFlLoibwDc4W5TMCdNLIk8IhFdrIWjLX+V4GKGPt8BstCU/5P/m7g1w==
X-Received: by 2002:a4a:94a6:0:b0:435:f61e:d7a1 with SMTP id
 k35-20020a4a94a6000000b00435f61ed7a1mr16021538ooi.82.1667598759132; 
 Fri, 04 Nov 2022 14:52:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 x7-20020a056870434700b0013c955f64dbsm74173oah.41.2022.11.04.14.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Nov 2022 14:52:38 -0700 (PDT)
Received: (nullmailer pid 2891709 invoked by uid 1000);
 Fri, 04 Nov 2022 21:52:40 -0000
Date: Fri, 4 Nov 2022 16:52:40 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v2 4/8] ASoC: dt-bindings: rt5682: Add DBVDD and LDO1-IN
 supplies
Message-ID: <166759875979.2891653.11675024922325754885.robh@kernel.org>
References: <20221102182002.255282-1-nfraprado@collabora.com>
 <20221102182002.255282-5-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102182002.255282-5-nfraprado@collabora.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
 Bjorn Andersson <andersson@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


On Wed, 02 Nov 2022 14:19:58 -0400, Nícolas F. R. A. Prado wrote:
> The rt5682 codec has two additional power supply pins, DBVDD and
> LDO1_IN, that aren't currently described in the binding. Add them.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Made names uppercase
> 
>  Documentation/devicetree/bindings/sound/rt5682.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
