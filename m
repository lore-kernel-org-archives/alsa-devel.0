Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44457C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Jan 2022 17:52:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA6B21AA8;
	Tue, 11 Jan 2022 18:51:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA6B21AA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641923565;
	bh=rdKh6MpTy7+tSNLZYf0C23vpccBlumjfJSxYfn2a4dE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WlNZYHubNkW1/dvCSZu7EWu6t2o8/D0lUvEQvY53Lsb3yJlCMOkzM8m19h2iH78gP
	 d6pjMnYrGVWxvEW00gBu+Y3WfIZEUa/RooQDX7IPTuBbaHK6DnRLo6DBwrpzd/vOtt
	 cvuSa/tGHF86EJeX0VRED7rNN2da7eR/KQ5K/aRk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8315CF8025E;
	Tue, 11 Jan 2022 18:51:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 088A0F80302; Tue, 11 Jan 2022 18:51:53 +0100 (CET)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86722F800A7
 for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2022 18:51:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86722F800A7
Received: by mail-oo1-f53.google.com with SMTP id
 c1-20020a4a9c41000000b002dd0450ba2aso553186ook.8
 for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2022 09:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UifqrbSv4P6oUwIS9VVpUp4MVpz/i09ZMQyiV9QJa6A=;
 b=Aqf9Knd1h/uRnBFoYygtfwkZge8dbzlcJLRJUPcC8fXtpAkLCv2Czq7YY09JestmVS
 Ab6KN8Vah3pI70HQ9TCTrVVTrd5MNdZ7V+sonkV50Bo1fcLYTxw3zu82IvlxLQkF2d5K
 OR3N0WMrsqZJKrsCFx67wmhjwXTKWcqJpQAsmKD2HaVnJxcqvVhxHkj4+AjQH9fVvdWp
 JrZsm5kKINVgQow6UfJT96cfvpjbS+Fg4jNK3VALIoxOkmdcYMgV1DpsWOTAChPJwRTn
 NwkJ/NgH0B1/3d6l3zRm7CZBBsTuVIR0gr+vdrYPja2m7qD1FKqksxg6/9xT4FMfkik2
 35Fg==
X-Gm-Message-State: AOAM533jzd6Dgc39FG1zfdQchozNTnvtK9IVdKofDgA6yrRZnd25cxaB
 dzEqAluHIKKyh/DhcbNFfA==
X-Google-Smtp-Source: ABdhPJznNaT1VvHIngLtpJFtz0iASueDANoXRX2e5SW6ZAucUfj28fstai6hZocWcmtpqr5MeaK/UA==
X-Received: by 2002:a4a:3bd4:: with SMTP id s203mr3882712oos.18.1641923507894; 
 Tue, 11 Jan 2022 09:51:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id x13sm2018165oof.19.2022.01.11.09.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 09:51:47 -0800 (PST)
Received: (nullmailer pid 3228864 invoked by uid 1000);
 Tue, 11 Jan 2022 17:51:46 -0000
Date: Tue, 11 Jan 2022 11:51:46 -0600
From: Rob Herring <robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Drop required 'interrupt-parent'
Message-ID: <Yd3DsoMYTylcOWDo@robh.at.kernel.org>
References: <20220107031905.2406176-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107031905.2406176-1-robh@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, John Crispin <john@phrozen.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Suman Anna <s-anna@ti.com>, Lee Jones <lee.jones@linaro.org>,
 linux-riscv@lists.infradead.org, Bartosz Golaszewski <brgl@bgdev.pl>,
 Jassi Brar <jassisinghbrar@gmail.com>, Michal Simek <michal.simek@xilinx.com>,
 Jakub Kicinski <kuba@kernel.org>, Greentime Hu <greentime.hu@sifive.com>,
 devicetree@vger.kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, linux-gpio@vger.kernel.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org, - <patches@opensource.cirrus.com>,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Thu, 06 Jan 2022 21:19:04 -0600, Rob Herring wrote:
> 'interrupt-parent' is never required as it can be in a parent node or a
> parent node itself can be an interrupt provider. Where exactly it lives is
> outside the scope of a binding schema.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/gpio/toshiba,gpio-visconti.yaml  | 1 -
>  .../devicetree/bindings/mailbox/ti,omap-mailbox.yaml     | 9 ---------
>  Documentation/devicetree/bindings/mfd/cirrus,madera.yaml | 1 -
>  .../devicetree/bindings/net/lantiq,etop-xway.yaml        | 1 -
>  .../devicetree/bindings/net/lantiq,xrx200-net.yaml       | 1 -
>  .../devicetree/bindings/pci/sifive,fu740-pcie.yaml       | 1 -
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml       | 1 -
>  7 files changed, 15 deletions(-)
> 

Applied, thanks!
