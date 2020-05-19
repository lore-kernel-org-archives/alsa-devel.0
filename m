Return-Path: <SRS0=hLTZ=7B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8B7C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 22:43:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09232072C
	for <alsa-devel@archiver.kernel.org>; Tue, 19 May 2020 22:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hC3fhYfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09232072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A3641798;
	Wed, 20 May 2020 00:42:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A3641798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589928195;
	bh=Z+yhUkb54ncq98pdzZqCBEveIFtHrDMflLjR/7kU9Eg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hC3fhYfcucTbOlUk7znVZGITFCNjYb9sQM83Fum4sxJvfubVJUJH2huUIeNJp9qvE
	 L9PcNZpN6WIKKNHPazYSC8xk4CcJ32MC9kyMVbQLHEdAHPM3cPDZpWXK+mFpURUz82
	 CeP4+SQdkxgeY1Nxwlwvhy1I0tU7ucD76FEGuCaY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C66EF80161;
	Wed, 20 May 2020 00:42:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CDC1F801A3; Wed, 20 May 2020 00:42:23 +0200 (CEST)
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5779BF800C9
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2020 00:42:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5779BF800C9
Received: by mail-io1-f65.google.com with SMTP id f4so986330iov.11
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2020 15:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qgFe2xy8/2xQB5QWY3CO3CsIleZgaMC14NjFZj3FgiM=;
 b=AQVeaGj00QhNYsVZJs11/BDdioCFSs2WT2vMeqjWYIhQTWVRdzwOhSctDHBuRYHIMc
 wf4/eulY+3WLcNV5qcAI6y/VTXohsPrFjWD/OPvG7iR/XQahaMcigzhEZnFUT9bY6Xfx
 rtyPX0BouFYv4pvjNaYFx/vZEDQrU5FgJjNU11i0oI11gfueK0mN7K+NlCfS+MnkOYmr
 Z+oBw3dr4k0hAFOHKnTaz1V2YEpNMf8L9cphgLEqJsuYMOIJNlTh8fQmM9E0LQG7gFgT
 3ywuSXHQLR2MF+aY6ZQNdnhq9CXTZuQk94/2tEpXgxXBOm+FucYG035fRgYLgl06AFKR
 u5gg==
X-Gm-Message-State: AOAM531m6TqKt39B6ld7EDtCePVbQHSCTj0CCKCfUmO9QdVJmajIVlw3
 Ad/X20B/gcfHH/DODlKZTQ==
X-Google-Smtp-Source: ABdhPJytDRwoiZt9xLZNqCqKB1TxQKbXQJnN0x8nPz/zWntjyvp5bG6L19VYqss8zFDavc6WNxSe4Q==
X-Received: by 2002:a6b:700a:: with SMTP id l10mr1152861ioc.170.1589928136705; 
 Tue, 19 May 2020 15:42:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id q75sm398796ili.11.2020.05.19.15.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 15:42:16 -0700 (PDT)
Received: (nullmailer pid 824100 invoked by uid 1000);
 Tue, 19 May 2020 22:42:15 -0000
Date: Tue, 19 May 2020 16:42:15 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/3] bindings: sound: Add documentation for TI j721e
 EVM (CPB and IVI)
Message-ID: <20200519224215.GB488519@bogus>
References: <20200512131633.32668-1-peter.ujfalusi@ti.com>
 <20200512131633.32668-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512131633.32668-3-peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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

On Tue, May 12, 2020 at 04:16:32PM +0300, Peter Ujfalusi wrote:
> The audio support on the Common Processor Board board is using
> pcm3168a codec connected to McASP10 serializers in parallel setup.
> 
> The Infotainment board plugs into the Common Processor Board, the support
> of the extension board is extending the CPB audio support by adding
> the two codecs on the expansion board.
> 
> The audio support on the Infotainment Expansion Board consists of McASP0
> connected to two pcm3168a codecs with dedicated set of serializers to each.
> The SCKI for pcm3168a is sourced from j721e AUDIO_REFCLK0 pin.

Would the audio graph card work for you on this? 
