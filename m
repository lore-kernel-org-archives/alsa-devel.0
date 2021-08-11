Return-Path: <SRS0=gvoF=NC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F11DC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 18:26:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13FB610F7
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 18:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A13FB610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96778172B;
	Wed, 11 Aug 2021 20:25:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96778172B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628706358;
	bh=IAw/mA4lggiQovXp4hNUsxGrAs4WDvJ37fmSi4Jku6A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nZLB0zM4aSEZDR8jSW5GqCcwGYyQUwMYJtOHd2v0bSI4eW+hC8Nm0/kWVnaNxRMtM
	 GjO5xcTR5jnNXxFRCD+cqhdbMnGnVGB5uBk1VvKNMEsCK92L2GB3EvGi7dm29OEnXt
	 ZQMBoSaq3UNIp4YVNsswvZaTwjZo5Kj+lEInkRq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 302BBF8020D;
	Wed, 11 Aug 2021 20:25:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1F2BF802D2; Wed, 11 Aug 2021 20:25:06 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49D93F800F4
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 20:24:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49D93F800F4
Received: by mail-pj1-f50.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so11019452pjr.1
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 11:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uR0s0AU+M7YxxJS85wJoKJfjFhScm/FPYXJ1t4tDEUM=;
 b=mEilV60D4LCmO03UNrq0KzAOyt+5WhBeKZeh0eGTohC87T7EpsixeGLtcCgkFIGMrj
 Q/bRMAZ0y9HwxyPucgZpUPZLxTiwP5pvUeqq2BIXzY7Br9CeRWBZ4XnN5WCMOHmrD5Nw
 EUlO/cqNrC8JO6sHt/vqFouH0zxlUMpFtV+em5pVvBOhK+G17cGmwjUnzYbVQj/g9yTO
 g50ZAa7VRuB/vExEPxn2HcnNg8IxapBZmY7wUSXlbkV1SmXVvIiWnQCM/6bBaPPBVWzZ
 MyAKtGPrqET4X25GoFwc6yYd5oGJlF8ysZmFjhzyhVPh+ePnKPCxij6K5d+l5bgwFKFj
 jQEg==
X-Gm-Message-State: AOAM532kvKdaZhB1XQ0rP+R67NmtHj6vuoENObp3TKFmDLopSUk6REP/
 nqlhGfavGpi7v+5Rtx/zzQ==
X-Google-Smtp-Source: ABdhPJyGrWyK5wGdhAncfGSofyVJ4NqhVg2p8ntFX0yjQ+DE10PUC1LDoID8zGN8l2MM9cl7QHpKiQ==
X-Received: by 2002:a63:5b24:: with SMTP id p36mr40450pgb.91.1628706292194;
 Wed, 11 Aug 2021 11:24:52 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
 by smtp.gmail.com with ESMTPSA id r3sm195193pff.119.2021.08.11.11.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 11:24:51 -0700 (PDT)
Received: (nullmailer pid 39491 invoked by uid 1000);
 Wed, 11 Aug 2021 18:24:47 -0000
Date: Wed, 11 Aug 2021 12:24:47 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 06/20] ASoC: dt-bindings: replace q6afe-clk with q6dsp
 audio clk bindings
Message-ID: <YRQV74TApmx949vZ@robh.at.kernel.org>
References: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
 <20210803125411.28066-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803125411.28066-7-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, broonie@kernel.org, bjorn.andersson@linaro.org
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

On Tue, 03 Aug 2021 13:53:57 +0100, Srinivas Kandagatla wrote:
> DSP Audio clock bindings have been documented with DSP services bindings
> which makes it difficult to reuse them, so pull them out in to a dedicated
> bindings.
> Also as part of this change convert them into yaml format.
> 
> q6afe-clocks were part of q6afe bindings which are deleted in previous patch, this
> patch just adds replacement bindings for clocks in yaml format.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../sound/qcom,q6dsp-audio-clocks.yaml        | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6dsp-audio-clocks.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
