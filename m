Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3466C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 05:30:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D9C206D7
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 05:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p5py3Njb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM7xYNKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D9C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEE991682;
	Tue, 16 Jun 2020 07:29:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEE991682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592285441;
	bh=0BqVTKsHLD5B5oH9wJSuDcSz2QtmPuYkGk2qB7JLVYg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p5py3Njb2TM2R5Fwt+TT6W6MjI4XQc+9MJ0HxK2v9HGRN8AW24aKHfEUjl8Q/lvVV
	 Bmcz01iTsgGjbvpgsus0dDVk+bp3E+8gnudL24bQI8gdIMKTfghTLxakjjbB0SIR+S
	 jlJNt9tMEuoz25hAHHk3qFSACg2E/l9AXOsbdC/M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8720F802A8;
	Tue, 16 Jun 2020 07:23:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 322FFF802BC; Tue, 16 Jun 2020 07:23:33 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E955F802A8
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 07:23:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E955F802A8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lM7xYNKX"
Received: by mail-pg1-x544.google.com with SMTP id l63so6453209pge.12
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 22:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=F8di4l+s/Ly7rCfnAJCSNumrdSsKS4ibEMc0wr155Lw=;
 b=lM7xYNKXNC3/18xNrWIVK8uekEsB6xz+aF3OvLQ+WQIAjqOxxrV8QNtErcVGyjuFYg
 g2ekGJtibX1TQHLUZjVom/gQ9oi3PiHmEHLFjd3KY7POCjycjtV/31bAAc+1sdmzT3wg
 Cx1zS4qoeLjGbtlpMuEJw+mtrkfV25ndvHW68jWZDEuri/PNWiNlS1GwyOUVSu8H+RDY
 UYtFd2wci0vd0yvpivgutSmG5c70wvCz7AH+y5R5KA6+n/DKwUZ0Qc5blx5dy8Gq7ljM
 9LF9mi16mdnjqFoTQpRlgZXl+AHQOlwBrEXSMqWB0bmXsUN14uYuObilLRMZRY638bir
 nDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=F8di4l+s/Ly7rCfnAJCSNumrdSsKS4ibEMc0wr155Lw=;
 b=V5uGv7a4verKyChGRjPsEGas4E/my1lBUQNlSwWA+mYyDu82vfWnyQEHOFzfS/mBS0
 IYy4/kDzErCHYvCCCsnYP0ZzgoqWTtrRuklfH1Wj/1CzENdrU6ufTML/bt99Am+o1SBd
 04PaBG6pIYTPPHRBBShsWalTlamsnMoT1ZP3AMsxMmV6E4gynHreWjGiM1uSSwEXVg2h
 H4UwiPg/ZuOcB5NKPUKkFgqiJwhwALSDQ/8B7DXAxOTQiUyGJDbc4umYiCLhz2hLRM4M
 BVwHRm5n1bDExNwrUd/YwsBL98UyV4uV8wkN+7JcAB3yx3TNL50LqgFfMkHAQnDXEVps
 18hA==
X-Gm-Message-State: AOAM5315Hlmhix3uu2QcEVYc0lE63zMrB7HQRANePM30IkaXkDKWAJeL
 0W9xYzcHMtzC4PbHRBt8Eco=
X-Google-Smtp-Source: ABdhPJy/DgyZOR7OSTrsOc0TGFWHgdklAdqqTv+6cq9ydXh1cUOIgbk3cVS/IZxiJP2tDbUJtD47xg==
X-Received: by 2002:a05:6a00:843:: with SMTP id
 q3mr579487pfk.107.1592285003585; 
 Mon, 15 Jun 2020 22:23:23 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id h6sm15684333pfq.214.2020.06.15.22.23.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 15 Jun 2020 22:23:23 -0700 (PDT)
Date: Mon, 15 Jun 2020 22:23:07 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl_ssi: Fix bclk calculation for mono channel
Message-ID: <20200616052304.GA24055@Asurada-Nvidia>
References: <034eff1435ff6ce300b6c781130cefd9db22ab9a.1592276147.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034eff1435ff6ce300b6c781130cefd9db22ab9a.1592276147.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Tue, Jun 16, 2020 at 10:53:48AM +0800, Shengjiu Wang wrote:
> For mono channel, SSI will switch to Normal mode.
> 
> In Normal mode and Network mode, the Word Length Control bits
> control the word length divider in clock generator, which is
> different with I2S Master mode (the word length is fixed to
> 32bit), it should be the value of params_width(hw_params).
> 
> The condition "slots == 2" is not good for I2S Master mode,
> because for Network mode and Normal mode, the slots can also
> be 2. Then we need to use (ssi->i2s_net & SSI_SCR_I2S_MODE_MASK)
> to check if it is I2S Master mode.
> 
> So we refine the formula for mono channel, otherwise there
> will be sound issue for S24_LE.
> 
> Fixes: b0a7043d5c2c ("ASoC: fsl_ssi: Caculate bit clock rate using slot number and width")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
