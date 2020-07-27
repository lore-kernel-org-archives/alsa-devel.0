Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839CEC433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:01:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34C820729
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Pif+wKsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34C820729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A0D91694;
	Mon, 27 Jul 2020 23:00:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A0D91694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595883687;
	bh=sO/IjFAokq/HE1A/fNgK14oSwdbVqrh3AzX3YWDvsE0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pif+wKshPXjuId2Brk6EPU/R+3HSwQ1OBv9wqEDSqW4lj2UUWf7aUUOfGYj79RxRb
	 caMMgNxlJ/+nYAoHPhOs046HPLCgp5fe72Y5lwubJmbwFGPsm5cgaEpIMtmmKYBimd
	 pckv3mHogqkSifUfKAWfntlNMmqnplyEPkQXO1rY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E55D7F800AD;
	Mon, 27 Jul 2020 23:00:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF130F80171; Mon, 27 Jul 2020 23:00:35 +0200 (CEST)
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05417F800AD
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 23:00:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05417F800AD
Received: by mail-io1-f66.google.com with SMTP id a5so3253208ioa.13
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 14:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Q/xx8a2iBuQvh2CskhteFtxckcB5mAiI21DtCGwJE70=;
 b=QBw75I5wZKfl52povCOWzsmKnfr7LIF2+GzY1KRlFTIOTZ2gqpqswf0cgNi+ozyb8D
 NlV7CE0oVY7ZLKAo0zarkyJksuxduzsIKeGUwrx1il/o4Tgug/o0og+/KK7CmnNfaPBp
 hEc5b6V4oXYtCcpVLoKRsS3NdACHx7mSmZyEL1TXHTH9jx2EvGwVT0iYj0CdeQH+NOPx
 zgtj6XA5r4ZFf7BJ4BSndD7wAsBJik5uHsv3VxidiAy9Q1Ch7a5GiZ9WDzGfvSz2Aab1
 mXUJRwrAwEkR+HMnq7j6TmnV02EsbPyEcqHxuWHiXTIY16WtiN+SRm+ffUma5bHLtt/d
 641w==
X-Gm-Message-State: AOAM533zbHRFd1gWPRLTJf2/7Hl6QQ1VIQp39r0ficUsZgQ55eKmoGSM
 im1rRCbhIDb36LdQbAV8RA==
X-Google-Smtp-Source: ABdhPJzdCLTZ2NA/wRoY6sUwazpy2vMTI1rQNQTsNfv0kTp2JW8MZpYqzkgO5mWrLnkse06fqotpVQ==
X-Received: by 2002:a02:bb05:: with SMTP id y5mr19148048jan.98.1595883623966; 
 Mon, 27 Jul 2020 14:00:23 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id q5sm8914029ilm.73.2020.07.27.14.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 14:00:23 -0700 (PDT)
Received: (nullmailer pid 863116 invoked by uid 1000);
 Mon, 27 Jul 2020 21:00:21 -0000
Date: Mon, 27 Jul 2020 15:00:21 -0600
From: Rob Herring <robh@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: tas2562: Convert the tas2562 binding
 to yaml
Message-ID: <20200727210021.GA863046@bogus>
References: <20200723160838.9738-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723160838.9738-1-dmurphy@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
 broonie@kernel.org
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

On Thu, 23 Jul 2020 11:08:37 -0500, Dan Murphy wrote:
> Convert the TAS2562 text file to yaml format.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/sound/tas2562.yaml    | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
