Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B611DC388F7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:05:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8834C247D8
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SDa14z5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8834C247D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CB0D850;
	Wed, 28 Oct 2020 17:04:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CB0D850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603901130;
	bh=0oLycWCoCQVQrMzBkUGFl4QlcufE3gRJ6rVdoEI58ps=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SDa14z5V0nxIBNF1fWrun2AMNiIhQoVadPz1TGh8KWEUsoejSpYm6Q5De3g5DTmOD
	 KDvpTWBulo3QLzp0emUXeUYS0ZIllVFewfD7LEhiH2I2segvzlyUBruPQTpMAFQzQX
	 izC6/ce7ZuEbUI8+3iIGl3OgvUaSRWlc5HqY1JzY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA5A5F801D5;
	Wed, 28 Oct 2020 17:04:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52193F80212; Wed, 28 Oct 2020 17:04:38 +0100 (CET)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28E05F800FF
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 17:04:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28E05F800FF
Received: by mail-ot1-f66.google.com with SMTP id n15so4682789otl.8
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 09:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PHfkq2GIgrBhlirWwFbPBHgiYurDsTixDdYprqWD+Wc=;
 b=Vjyx2pfdj84nvXH4ktzIELpRR+wE8sskfPsB6WewtbN70TanZR4n1iWSJy+6CaIcAt
 xDF932pcJYwXmy9WMzkC2xKZF9j1A8DjbfZQpjXxlo+ghx6mwSiJ4M15n5EE0k9oxsxU
 JRqEDE3hgMpj0zJ7LODsCEWH5JyZfd3auNpNj65yIj13Pe8JL/YSof0rTrRfNyqzckcz
 GiEbpDi6DkQXgf7AGp/Vj8hEIukri+0+EyqGp7IY5vGzAR1NhmUwo3YzxroKV+Q1JNlL
 KfgBm9HAN07yZz388KguE2WArc4mqzfiVjp4wXsbMnBk0qVXOGyKPcpcZUq++KwvqcDU
 uCaQ==
X-Gm-Message-State: AOAM532qH66x/45gRdbhp8THeMcNUMX2Vx76sCy/A1eRNsQdwaJLZcYY
 I5zKxxyetsTDynMdWOw1Bg==
X-Google-Smtp-Source: ABdhPJx5rbPL2vDT9KgX5Jp6773wb6fBHFQ2bUYzR1oysz2iTs2skeRf4thvqhm6psmEVygYKD6J2Q==
X-Received: by 2002:a9d:3d26:: with SMTP id a35mr8047otc.54.1603901069581;
 Wed, 28 Oct 2020 09:04:29 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x25sm2725124oie.17.2020.10.28.09.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 09:04:28 -0700 (PDT)
Received: (nullmailer pid 4105730 invoked by uid 1000);
 Wed, 28 Oct 2020 16:04:27 -0000
Date: Wed, 28 Oct 2020 11:04:27 -0500
From: Rob Herring <robh@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v3 1/3] ASoC: dt-bindings: audio-graph-card: switch to
 yaml base Documentation
Message-ID: <20201028160427.GA4094628@bogus>
References: <87a6wfay7t.wl-kuninori.morimoto.gx@renesas.com>
 <878sbzay6u.wl-kuninori.morimoto.gx@renesas.com>
 <75ca7528-3177-46cb-73c5-46e32e63ad44@nvidia.com>
 <87h7qgw848.wl-kuninori.morimoto.gx@renesas.com>
 <eba1f18a-0b2e-d52b-593a-9ef5304f9199@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba1f18a-0b2e-d52b-593a-9ef5304f9199@nvidia.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Tue, Oct 27, 2020 at 11:33:49AM +0530, Sameer Pujar wrote:
> Hi Morimoto-san,
> 
> > > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > > 
> > > > This patch switches from .txt base to .yaml base Document.
> > > > 
> > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > (snip)
> > > Since I am trying to re-use most of audio-graph for Tegra, can
> > > 'compatible' be moved to a separate schema?
> > > For example,
> > > audio-graph.yaml -> defines all the common stuff
> > > audio-graph-card.yaml -> audio-graph.yaml + 'compatible' property
> > > Similarly, tegra-audio-graph-card.yaml -> audio-graph.yaml + Tegra
> > > 'compatible' property
> > I'm not expert of Json-Schema, and it sound very expert technique for me.
> > (It always indicates me unknown errors...)
> > I'm posting this patch since many month ago, and not yet accepted
> > for many reasons (audio-graph DT is very complex).
> > I spend many times for it and finally come to the point where it
> > can (might) be accepted.
> > I'm sorry but I want to finish this work,
> > this means I don't want to customize it any more.
> > If I try it, it needs more month...
> 
> I am not a json-schema expert either :) From earlier comments on Tegra audio
> graph series, above re-use is possible I suppose. I depend on your
> audio-graph documentation and for 'compatible' I am seeing error. So I
> thought it may be fine to split audio-graph into two json-schemas now
> itself. Otherwise I need to do it separately in my series if I want to
> re-use your audio-graph, which is fine with me.

I think this part must be sorted out. Defining the graph schema could 
come later though.

With compatible dropped from audio-graph.yaml, 
audio-graph-scu-card.yaml would look like this:

allOf:
  - $ref: audio-graph.yaml

properties:
  compatible:
    const: audio-graph-scu-card

unevaluatedProperties: false


However, What is 'audio-graph-scu-card' supposed to mean compared to 
'audio-graph-card'. It's never used by the driver or in any dts file.

Rob

