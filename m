Return-Path: <SRS0=fy3w=NW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FABBC432BE
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Aug 2021 18:54:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDA8610CA
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Aug 2021 18:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EDA8610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E64316FC;
	Tue, 31 Aug 2021 20:53:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E64316FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630436038;
	bh=bAr73vA2O3lHgDT56rXX6tCtK2ONgucK1O8GmPEEV9c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eSfDcAIA3OO7RqaXl34BvbJZYGbTaS2s98kuUgd3U0lT2p73JIBTuIsBQ2R7qICbB
	 u4/rRxX0fA+sn8gjX+JMlQQ5LMwKXtLMgWXKEcQ3W72UscNaKqwIJNZy9PxtppilHn
	 FVqA3hkUfKy+4jq0XHV2e5TlqL7J843DgzGiSyQM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6FA1F80254;
	Tue, 31 Aug 2021 20:53:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E1B1F8025B; Tue, 31 Aug 2021 20:53:07 +0200 (CEST)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3509F800BE
 for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2021 20:52:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3509F800BE
Received: by mail-oi1-f177.google.com with SMTP id p2so451681oif.1
 for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2021 11:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GaISQQcUmH3yFJZK19hxSWvQKue1oPZpb+E7tciH02Y=;
 b=unIlhq0QdCwugBgrKnDGjOntzWuRf4Kh5OBA9gXXqg6/gKb/Mf5EK3vBqbZX8n8/Dv
 vjDWLenV+29a8nq14nuMjuJUfVo7Ris210bjb4LauXTpNLV6T23qU6u6/h5MhW1YnHxJ
 LMfB+j/NsvZWib30OhMB9hm7uIJEuVBjUrbc0z7BQLCGRXsglmJsvdHBBYgKlXpUUgpD
 ebpx3GcjowXGXOIDZORVGrbGzRav3TNrDgnR0PvbwqWY1GBI6k5ajEm+yEBuzYTLtLh8
 659NE/5TcXp+wvTODwPrq+9Lx4BNQ/EhjP0RmeCJ8gbzss1y/ukwhLB5qHQ5ii056FYh
 /qpg==
X-Gm-Message-State: AOAM532lypeEu0iK6jJ1hToVwk9U+N4h74kAa61Q+Pv31Uns6aT3rSDW
 LYVHFHvrN2XtDHj56I4gZQ==
X-Google-Smtp-Source: ABdhPJygcfOd/qjKOVhQVKqkAkEAqQWY71ZQpai34B/CzPJbh/oTSTdmC6yWvPldPEsDQdPHWvqTSw==
X-Received: by 2002:aca:d06:: with SMTP id 6mr4253337oin.105.1630435976319;
 Tue, 31 Aug 2021 11:52:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id t1sm4027098otp.9.2021.08.31.11.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 11:52:55 -0700 (PDT)
Received: (nullmailer pid 466339 invoked by uid 1000);
 Tue, 31 Aug 2021 18:52:54 -0000
Date: Tue, 31 Aug 2021 13:52:54 -0500
From: Rob Herring <robh@kernel.org>
To: Trevor Wu <trevor.wu@mediatek.com>
Subject: Re: [PATCH] ASoC: dt-bindings: mt8195: remove dependent headers in
 the example
Message-ID: <YS56hvQHAH/zD/dD@robh.at.kernel.org>
References: <20210831083956.9804-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831083956.9804-1-trevor.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
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

On Tue, Aug 31, 2021 at 04:39:56PM +0800, Trevor Wu wrote:
> Drop the use of the defines including clock and power id, so that
> we can remove the headers which are not applied in the example.
> 
> Fixes: b5bac34fcfb4 ("dt-bindings: mediatek: mt8195: add audio afe document")
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8195-afe-pcm.yaml        | 40 +++++++++----------
>  1 file changed, 19 insertions(+), 21 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

Please pick this up for 5.15-rc1 (or don't so I can).

Rob
