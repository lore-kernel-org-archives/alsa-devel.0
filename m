Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AEAC2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 19:45:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB7F24656
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 19:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HX+Ed1Tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB7F24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B65961745;
	Tue, 17 Nov 2020 20:44:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B65961745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605642319;
	bh=t9RODlfwxXX3BVzVOcWLyzFZsORO3tyS+V6MmMQJACE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HX+Ed1Tf/2O/JxrhZb5kmuUxbDsheqfX2t599V2YyLzvAKgnnRkIFKL4nRDLFKGvs
	 hfw9GtbpDtnsZfbHz4TyEFVgVWsoWxhvIolB//d3cSorQ2gmbJrMUelzzwIaoVhcKP
	 LxydqAHNNVzV4PWl21p3SQnPW3HqcAtTXvoTxois=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F31CF801ED;
	Tue, 17 Nov 2020 20:44:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5E62F801F5; Tue, 17 Nov 2020 20:44:27 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2ECFF800FE
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 20:44:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2ECFF800FE
Received: by mail-ej1-f47.google.com with SMTP id gj5so3624677ejb.8
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 11:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yziYQyPxC5NocOLvc/D7Cx6g4iNMssV0rEbkjl3HvFk=;
 b=QVS7ksoM2C0GuTye8Gu1nRRuU8bc4iarMC1hdiCv9v4ARMpSeaWkzi2IPgTj17Nivc
 w9vbBrOQFJ4Mt2a/0JL3L/d8Iu/FWFTW8ilfUa06E2PUkjghJ0F3WDwkgkHm+5UiSJOp
 fmk/yUYR9stEKX9QC0vJ3PU5c1tPy0NXwxlj+/ULArzY+BdNiNUKtKToYnmz/WvWA2E3
 Vpy886dyc/K+3YEYoK8RW7Bl5FMYcCBsCNFhvsr8vXh7kMarHX62WYHDnBF/gZOpxvJS
 vx6FX0OkEQIXfuDNoRLUuCeh4A6LeSmyyET2fG9v0Oi5Qchmeuqdq17WxPcxrybk2czT
 MtAg==
X-Gm-Message-State: AOAM533Xfqp7mcmc9HsfYXlBY5arxXUYCEyNHqxhrwTNwEqsI01jfuDC
 0+2bP7FRor7Co0i2MHpr1v4=
X-Google-Smtp-Source: ABdhPJx8AykOkF01fEUTuFmZotpO8hRrDGX6Om39ql/vxyGII7lHd1SQRyUgaKuHUcoQnDgcflg7EA==
X-Received: by 2002:a17:907:11d9:: with SMTP id
 va25mr3043307ejb.431.1605642255883; 
 Tue, 17 Nov 2020 11:44:15 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id p4sm11802131ejw.101.2020.11.17.11.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 11:44:14 -0800 (PST)
Date: Tue, 17 Nov 2020 20:44:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zou Wei <zou_wei@huawei.com>
Subject: Re: [PATCH -next] ASoC: samsung: fix platform_no_drv_owner.cocci
 warnings
Message-ID: <20201117194413.GA108001@kozik-lap>
References: <1605529740-68757-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1605529740-68757-1-git-send-email-zou_wei@huawei.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, broonie@kernel.org
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

On Mon, Nov 16, 2020 at 08:29:00PM +0800, Zou Wei wrote:
> ./sound/soc/samsung/midas_wm1811.c:534:3-8: No need to set .owner here. The core will do it.
> 
>  Remove .owner field if calls are used which set it automatically
> 
> Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  sound/soc/samsung/midas_wm1811.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
