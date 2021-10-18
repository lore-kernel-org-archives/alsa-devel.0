Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0037FC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 19:50:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8101F611EF
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 19:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8101F611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE8F984C;
	Mon, 18 Oct 2021 21:50:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE8F984C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634586654;
	bh=mOZT7+hIMgiu7ZFpGb2+/L6ZbXvddzQ/0K67h0KeDZ4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dd1wXdYJB3sK6BUObZfI+xc44edxAZwwC2nUnUka4MyftWRzBud726Q1IsHPKQ4qw
	 nEFK19/0sWJAz3V8tXw77GaRvKbrQJ9dbBxHGmmMat1/TtAEVOLK1RGmtYaPYc3a+q
	 rq3gRpM94s/cX4XAtE2/vj3fO3jeRQe7XXPiSIJM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BE56F80217;
	Mon, 18 Oct 2021 21:50:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68AC1F80224; Mon, 18 Oct 2021 21:50:01 +0200 (CEST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A90A7F80111
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 21:49:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A90A7F80111
Received: by mail-ot1-f52.google.com with SMTP id
 l10-20020a056830154a00b00552b74d629aso1227164otp.5
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 12:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=21IgNcOzTW10vAg0/6zH/SOZJHt58u5z1E5yUcMpGQ4=;
 b=Gevw8ILOS1jSaWOeJoGGl2c3CJ/vPVXFNbN61cFjYgLk3aETXsOuGeySi8IwuSvs3v
 FbjDBtr8SE91QCWVxrVVuUjEAFO/dLwOXC+6StjD2rL9Gdo5RtwNOdC/DeGuL2NJvajB
 HajprYDqM9siCCU7dEkRRdI7JXciqcO/OflAuIwJyic8uZUHPmpq42uJCY3rh/oQ8ueJ
 PHysHRHSNEq4ZY9nis3/kDdGWWFGDwXsUDNLN8Q6dBpmE2JKUWFC1jGHzpVO4iLHwLoD
 Ns/ky/5uJMCnRIOYh4h8TqzqosI33ruR018lbcx2lyvm3wE3EBkv/YTBECWOyunkYMQq
 ZMlg==
X-Gm-Message-State: AOAM530naSwyT1sqIwod+UXfP12+zhR0zJQg7bqcjdszxfBxhS9uL6fp
 LFU8hI6Cev7XOacAjiQ01g==
X-Google-Smtp-Source: ABdhPJzvzvwjO4OXfCnPr5/eILTq2Lq4LVXtAin4yo7u1XW3BSDA6T7gghsm8NbySfxKCRuzK53t9A==
X-Received: by 2002:a05:6830:23a6:: with SMTP id
 m6mr1567801ots.38.1634586591549; 
 Mon, 18 Oct 2021 12:49:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id j8sm2623027ooc.21.2021.10.18.12.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 12:49:51 -0700 (PDT)
Received: (nullmailer pid 2837570 invoked by uid 1000);
 Mon, 18 Oct 2021 19:49:50 -0000
Date: Mon, 18 Oct 2021 14:49:50 -0500
From: Rob Herring <robh@kernel.org>
To: George Song <george.song@maximintegrated.com>
Subject: Re: [v3 1/2] ASoC: dt-bindings: max98520: add initial bindings
Message-ID: <YW3P3ggca5CinwXH@robh.at.kernel.org>
References: <20211018083554.5360-1-george.song@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018083554.5360-1-george.song@maximintegrated.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 steves.lee@maximintegrated.com, ryans.lee@maximintegrated.com,
 george.song@analog.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org
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

On Mon, 18 Oct 2021 17:35:53 +0900, George Song wrote:
> add initial bindings for max98520 audio amplifier
> 
> Signed-off-by: George Song <george.song@maximintegrated.com>
> ---
>  .../bindings/sound/maxim,max98520.yaml        | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98520.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
