Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3545C43334
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Jul 2022 20:56:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5B9516B4;
	Fri,  1 Jul 2022 22:55:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5B9516B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656708976;
	bh=+/YkwecrwQ9E+Ogn5Ut2/InTxhfiEAru634IdVzzdYs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K/jA8oPSNgalAxCOgLXGaeTo0Y1mX7nY/Gv0FoS+0/s72Fmja62O06Bs9eabmx1Oa
	 WsFkBGWTLUOPpiJOf+Gkq4sHob6h6HrPCsZ0IbAh2mLUHDT6/OA8pBxdzUNs4/ifRx
	 WpnC1ioo+hKG13CAPN694mUABPviYIZg1uaD+yLA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 174D8F8014E;
	Fri,  1 Jul 2022 22:55:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CC2AF8014E; Fri,  1 Jul 2022 22:55:04 +0200 (CEST)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com
 [209.85.166.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F050AF8014E
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2022 22:54:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F050AF8014E
Received: by mail-il1-f170.google.com with SMTP id p14so2140322ile.1
 for <alsa-devel@alsa-project.org>; Fri, 01 Jul 2022 13:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3LPZ1DizPYBScxcXuGY/3z+PsYKOTpV0UZkb5MuqFe0=;
 b=QOBIxujbEZf4PeUS772DQfYKUErWO7btXsFrE43tCW03SjuhXmzgtNuGIRTCc3U8N6
 zJih50+0L87USgNkHTVNFzJi5q+YuqL8f7TwvvdEkmCm6dltwkjbTAc5xB2iA7r1yndW
 af2n3wY9uM30Jj5YzE8msDpKC70FBVnYz1ZIwTtCm7+JlkdiI1wmy78NkiiWqyEbW+Jh
 0GHX4UX78b8ZdS1ULCC1G9O1l4akwGtF9TEIyzoARX+R4QqWtPQ5ZdLs505kotG2cJMs
 NkSvxM3g9cVakZFuQ4nrgEzzaX6ZSsfeC6ZX8PnksSHhoCGoWdx4sW1pTxhsxeV4NaOK
 p4QQ==
X-Gm-Message-State: AJIora/y8KbqI8uwXEyE9TXK/5zLHFy3TQN3KMKsH41i42etDe4wFx0a
 oxmUR1lqBq72k2rj2i5r9w==
X-Google-Smtp-Source: AGRyM1vTE3uUzjOrJeeGSTgJ/tO4QiastKGHmlTULq10GRjmMlObeExibr8KirXpiJJiC7qDmehj1Q==
X-Received: by 2002:a05:6e02:1187:b0:2da:97e5:6609 with SMTP id
 y7-20020a056e02118700b002da97e56609mr9630603ili.274.1656708895013; 
 Fri, 01 Jul 2022 13:54:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a056e02080600b002dbf4c67b1fsm295715ilm.46.2022.07.01.13.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Jul 2022 13:54:54 -0700 (PDT)
Received: (nullmailer pid 1511647 invoked by uid 1000);
 Fri, 01 Jul 2022 20:54:52 -0000
Date: Fri, 1 Jul 2022 14:54:52 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 6/6] ASoC: dt-bindings: fsl-sai: Add two PLL clock
 source
Message-ID: <20220701205452.GA1511590-robh@kernel.org>
References: <1656667961-1799-1-git-send-email-shengjiu.wang@nxp.com>
 <1656667961-1799-7-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656667961-1799-7-git-send-email-shengjiu.wang@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
 broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
 shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org
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

On Fri, 01 Jul 2022 17:32:41 +0800, Shengjiu Wang wrote:
> Add two PLL clock source, they are the parent clocks of root clock
> one is for 8kHz series rates, another one is for 11kHz series rates.
> They are optional clocks, if there are such clocks, then driver
> can switch between them for supporting more accurate rates.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
