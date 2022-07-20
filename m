Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D939FC43334
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jul 2022 22:35:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32288171C;
	Thu, 21 Jul 2022 00:34:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32288171C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658356541;
	bh=NAChMKZ1vBX9zc0ywAlHT4xZ12IJDo2Av0OWiKX58XI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jsf2Y8esXDZ8nsQpk9Tj8pOhvIqgUP0mFk9KCSTiGX/u5+EqsJZVzHh3l1L7vmb9k
	 2FB1TG2TaPGtggxzvW57dxS1pd0eLpN5NGK30rxe+1WnL+ywUEgTKvJbViqnv0CBYh
	 cSRgo5aLqPdo7Dl2zJztBly9jA/iNl7JHXFQCN8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9318F80139;
	Thu, 21 Jul 2022 00:34:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3828DF80169; Thu, 21 Jul 2022 00:34:48 +0200 (CEST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
 [209.85.166.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FB7DF80118
 for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2022 00:34:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FB7DF80118
Received: by mail-io1-f49.google.com with SMTP id v185so16220ioe.11
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2022 15:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E6+mWpMrbSxs+PG1o/Ja8+UNIibcv7CaFySMKY6pWrQ=;
 b=IwSbalu8oQdlL68YKidpFi+SDcqH0wjGNNfGh/piXT/iDlnZWHDg1gudX9tuX8C2zs
 DdSuK2kNqo3XII9/UjIrSqID+P6uwygtiAbkskYVQ5uuw+8WkmG1aynx2myM97uexa7C
 sCeme6q5cYXV1AYw3T84qqN/FOPae3eS2EmB6ec6dtEU1UD7ngSUM9VEn0Pp9F//S56w
 Gt2BH94uh0lMevIJRij1VoPYZZQHbAABsUrNYbo7+IzQCjMOhSNZPbNC01+I9kVAIiwM
 VoJd+TgSf1WgWdma/GMN8gfVpMbIzKQr9qMWmyJzpG3bVKubpaaRB1CMOvicg/BuI6Kg
 4Jmw==
X-Gm-Message-State: AJIora+2DUZso4GlWB/bVYxwufDF7Vi9j+SPdRvGo98Qo7HGTwL+TGih
 +VwdqFvGP47vMgf/KDlsvQ==
X-Google-Smtp-Source: AGRyM1sh0oRJIroxwJHSQ5BZYJWkp0XtTpGBLLU6OxZOfS7tLPMkY29N0yIUe2xwmQ7ObeUkjy11xA==
X-Received: by 2002:a05:6638:d45:b0:340:5c58:51f4 with SMTP id
 d5-20020a0566380d4500b003405c5851f4mr17519298jak.280.1658356476346; 
 Wed, 20 Jul 2022 15:34:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id
 e101-20020a02866e000000b003316536ebc1sm57851jai.73.2022.07.20.15.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jul 2022 15:34:35 -0700 (PDT)
Received: (nullmailer pid 4103876 invoked by uid 1000);
 Wed, 20 Jul 2022 22:34:33 -0000
Date: Wed, 20 Jul 2022 16:34:33 -0600
From: Rob Herring <robh@kernel.org>
To: Zhu Ning <zhuning0077@gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: sound: es8326: Add dtbindings
 documentation
Message-ID: <20220720223433.GA4099826-robh@kernel.org>
References: <20220718053237.20146-1-zhuning0077@gmail.com>
 <20220718053237.20146-2-zhuning0077@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718053237.20146-2-zhuning0077@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, broonie@kernel.org,
 Zhu Ning <zhuning@everest-semi.com>, David Yang <yangxiaohua@everest-semi.com>
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

On Mon, Jul 18, 2022 at 01:32:37PM +0800, Zhu Ning wrote:
> Add device tree binding documentation for Everest ES8326

For the subject, don't repeat 'bindings' and 'documentation' is 
redundant:

ASoC: dt-bindings: Add Everest ES8326 audio CODEC

> 
> Signed-off-by: David Yang <yangxiaohua@everest-semi.com>
> Signed-off-by: Zhu Ning <zhuning@everest-semi.com>
> ---
>  .../bindings/sound/everest,es8326.yaml        | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/sound/everest,es8326.yaml

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
