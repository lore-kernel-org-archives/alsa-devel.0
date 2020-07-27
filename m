Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62418C433E3
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:07:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F7820838
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EZsXxEPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F7820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40A2E1694;
	Mon, 27 Jul 2020 23:06:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40A2E1694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595884034;
	bh=yxXkkE7/udko/+wboOBIMBvUEKDxQ5STwaBcFO9W2kU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EZsXxEPBta3vdqoLEf+InbfSmd8GZPc/DEqLwI2aMwZ4eEPsFeBAEDMnYsgZylBI6
	 5Lk1ROZo+gC/P7+ksIyzN317jlhwIw/8Ce9hY7i9TyDJF4s+BqMj+5QSJFmqRU7JuU
	 lztGuNnV5xr2SGm095muQQEAyZPtFBwpq89+vQz0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 918F6F80158;
	Mon, 27 Jul 2020 23:06:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8037AF80171; Mon, 27 Jul 2020 23:06:22 +0200 (CEST)
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A816F800DE
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 23:06:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A816F800DE
Received: by mail-io1-f68.google.com with SMTP id j8so6136392ioe.9
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 14:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uNJA6hxthLWoViobyjxlj8lWj83PnXb0wbDuaLutL0g=;
 b=s42EfWCXgW4uX8IkBHYx56CNFm4nJvUTfHF6BDhZ8+xDGfYTYsdQB9l6RDQppoMSD4
 s1TaeG1cqvzt8knvfmYpgbO/O9hM3ECoG7PgJ6ivhpPZTOFKBKBkOMn8EGP+v4mb6at6
 zdY+1r/wUzblpvHeOg20/jizj1ZPVI5NKnadzB1jAzNvpS3p57VkLDtE36mHquqQi+dV
 onqELpvkJNrRoZ5PnjLGurq9bOVofD/fPbLdd/3FQ8tIHdVHjl6w0ng/n3FqLDO6M6Zx
 UiueVc7NeS9c4ZPoUiO2/nu5i1q3BUdDdlWJWgpDZtslV192z0qkfC3k2midDgynrFMs
 RJ/Q==
X-Gm-Message-State: AOAM533tfzXeELb5KhA+7nF3KWLfDALczoeQZdfBSg66Z2e9nzZ1eqfz
 H9bNMtql1yI0KvLZzEW72w==
X-Google-Smtp-Source: ABdhPJzzDamUTYXPVSulEAobeeT0K3y18tYf5sifUQBFezxPTGh0WBwGZkAmII2vPYeUhpNHtG2pZA==
X-Received: by 2002:a5d:9a86:: with SMTP id c6mr11888011iom.27.1595883974742; 
 Mon, 27 Jul 2020 14:06:14 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id l11sm4997492ioh.52.2020.07.27.14.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 14:06:14 -0700 (PDT)
Received: (nullmailer pid 871469 invoked by uid 1000);
 Mon, 27 Jul 2020 21:06:12 -0000
Date: Mon, 27 Jul 2020 15:06:12 -0600
From: Rob Herring <robh@kernel.org>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH v2] dt-bindings: sound: convert Everest ES8316 binding to
 yaml
Message-ID: <20200727210612.GA871439@bogus>
References: <20200724155933.1040501-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724155933.1040501-1-katsuhiro@katsuster.net>
Cc: devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Sat, 25 Jul 2020 00:59:33 +0900, Katsuhiro Suzuki wrote:
> This patch converts Everest Semiconductor ES8316 low power audio
> CODEC binding to DT schema.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> ---
> 
> Changes in v2:
>   - Change maintainers from Mark to Daniel and me
> ---
>  .../bindings/sound/everest,es8316.txt         | 23 ---------
>  .../bindings/sound/everest,es8316.yaml        | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
