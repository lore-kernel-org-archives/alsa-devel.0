Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71120C38BE1
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:28:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024ED2084E
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iJGqSuUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024ED2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54CD01657;
	Mon, 24 Feb 2020 19:28:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54CD01657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582568937;
	bh=umAnb5ekYeQXE5qdZwgUn2od2g+XRXhwSwaqS5+ud0w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iJGqSuUmlhPQN23xrs0KhgMzeoBQOv+3zZ2RLyTF6al2AADwyPTMvdo8CtAG2gSDM
	 JRxlwn2q1+JnYl2H52zfj+7XBJm/8WCmjuxqXOAOa8+55vGS6fDRda27Vj0uleiTDV
	 27YgDlWkjGsaFkjmr2bXUG6YN9rO+GK6niRRyyk4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CACF6F800C6;
	Mon, 24 Feb 2020 19:28:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C8B3F8014E; Mon, 24 Feb 2020 19:28:03 +0100 (CET)
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D3BCF80090
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 19:27:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D3BCF80090
Received: by mail-oi1-f194.google.com with SMTP id b18so9895587oie.2
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 10:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8b3MliEDFbDrUpBm8jGhwYqreoGs6m8FNnF/yNIueEU=;
 b=uhOdlMf2Cwubnd2XNr8DtDw0obYZf0UNQDRLy4QnA8Nei+a1wL55AKWioYxSa1L4U6
 cXovIzhDbVfWWrAIigTq+sc9eTNrdvXwvFDmRVZWqa05Lap6UOthzFvmGNPTG30h2lls
 wX1GOmraX5WwG5xj3EE9IHRPI1Z2ztP9JMqbGyiVUescLog9ysA0Zot+CVV7/rPlF/Ax
 lbWY2Bb+rDgaKQX1Fn5S4u023GzK+fMq/U9iOP6gDZqY1xC1j3NFQqjj6SxooAeUTLG1
 QKQXA18jroeseZxLn5SDX3Dfwq2LqK/wqbGTsW/fasxUupFldQ2uRutkH8BSgVfrMtlk
 Vntw==
X-Gm-Message-State: APjAAAVoPYuCgFgg/1VqcAbfX1eavuu7T0kvMgdNQAjNjOpt8NcNMWpp
 i0gXIBaqEDIrJqR8E70gQA==
X-Google-Smtp-Source: APXvYqyzy4iiGXu+ZZ3t2yBP3j4K/yU2pKb0H/blTr6+iujeHVCL8mJihe7tO3CjLAVcADKqUCNWGQ==
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr318449oif.57.1582568876626; 
 Mon, 24 Feb 2020 10:27:56 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id v10sm4255017oic.32.2020.02.24.10.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:27:56 -0800 (PST)
Received: (nullmailer pid 13156 invoked by uid 1000);
 Mon, 24 Feb 2020 18:27:55 -0000
Date: Mon, 24 Feb 2020 12:27:55 -0600
From: Rob Herring <robh@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] docs: dt: fix several broken doc references
Message-ID: <20200224182755.GB27161@bogus>
References: <0e530494349b37eb2eab4a8eccf56626e0b18e6d.1582448388.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e530494349b37eb2eab4a8eccf56626e0b18e6d.1582448388.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>,
 =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 Vignesh Raghavendra <vigneshr@ti.com>, devel@driverdev.osuosl.org,
 Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>,
 Piotr Sroka <piotrs@cadence.com>, devicetree@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@st.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-spi@vger.kernel.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Sun, Feb 23, 2020 at 09:59:53AM +0100, Mauro Carvalho Chehab wrote:
> There are several DT doc references that require manual fixes.
> I found 3 cases fixed on this patch:
> 
> 	- directory named "binding/" instead of "bindings/";
> 	- .txt to .yaml renames;
> 	- file renames (still on txt format);
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/mtd/cadence-nand-controller.txt       | 2 +-
>  .../devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt      | 2 +-
>  Documentation/devicetree/bindings/sound/st,stm32-sai.txt      | 2 +-
>  Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt  | 2 +-
>  Documentation/devicetree/bindings/spi/st,stm32-spi.yaml       | 2 +-
>  MAINTAINERS                                                   | 4 ++--
>  .../devicetree/bindings/net/wireless/siliabs,wfx.txt          | 2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)

Applied.

Rob
