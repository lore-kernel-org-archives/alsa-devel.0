Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD159C636D6
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Feb 2023 13:33:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F2BFEAB;
	Wed, 22 Feb 2023 14:32:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F2BFEAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677072800;
	bh=GCexlCc6q0YIleEdHXJ8A2Lj9iQ1o949khcqEXouHhg=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=T61D5a5IqMU2G5+KE20BtaqU6TIRSjPsefNMwLhAqvF07WCUVPZUCqNEVosEm2tFz
	 t7ZfJmXcXQZoZDEZSrXBQHFpcmt2YTnst859WC5wJidtwJFJdDxBVdtr8Hs3oVxsqY
	 fBFf3P4RtJ3irImqQcytFu5jDf69U68uAhIrKzhk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C2FE3F80083;
	Wed, 22 Feb 2023 14:32:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2FEFEF80266; Wed, 22 Feb 2023 14:32:07 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2F6FCF80083
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2023 14:32:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F6FCF80083
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=cboTumAA
Received: by mail-wm1-x333.google.com with SMTP id
 iv11-20020a05600c548b00b003dc52fed235so5353572wmb.1
        for <alsa-devel@alsa-project.org>;
 Wed, 22 Feb 2023 05:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyYX0RfftztzNQ8Ex28d1K9RdtJ42UqMq/VeELB++KA=;
        b=cboTumAALVn0tztGHhz524kh3qEE1BaKuwQ+9TKzGCagRocvzz9VniWUMM70t4S3Mh
         wXtPaXnHMx9upygBI1p0ty72+s7JUI2ujbm6H2GRfV3Hl4jX9TU2SuDR4KwtVR6AJDow
         gn0xOeqCqIjAjDxlZA1J7ejlHlTGnQVjXnYvYdXgIxNzkmomxQfLqmPwVHdgn9tHg/Sr
         4uMPIGJ6GqQE6c8YmOBAJLM1efuG9fdu41l/xX014LpI6plim0AJ5ZkYlQOF5NyuIR+P
         MJuc/Oe8sYLQuDGjl2rGKrr3Ke6rXMtEpNt4zFZkBs72wkb8RpnSCPTk0zCzf2JKl00V
         803A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyYX0RfftztzNQ8Ex28d1K9RdtJ42UqMq/VeELB++KA=;
        b=hlkiWH1l6oVLCFLLdCNmQzdspiKT7zTSu0cztUvvXMVjEin4fGxyzyH0rRw5wBSff7
         q857qSGLPp84mihnD5sjiOcANlOs1eeiWkARE/oQAL9ghr6e4qe15U5HcvuH3PvMFo+e
         GqDiF9ReSjsLiX6gtuuhuDgbvFhLa3dYXJUVyr/Pm4eZQSuK/EU0yp4hJYfgtq58MFzs
         qWeUR1ehFitKCPgyVsukxt7kOWB7Y4w4eNU8MYQJ8jcOXr7TjHcBsDRehZV5laOWrp13
         d0iCbrKgwOnb87XcEYm2iIgdoZCHDxmF9rtkUiAPhQ+/NQKdukH6TBuQdpJeAL2O9iLW
         w/5g==
X-Gm-Message-State: AO0yUKWlW2kDI1tcfdM4buEYvwub/IPBH5LxqALZdJ8D/XpKSyGqSvyC
	whaeNDx1iIh3IFsojhsOIXaoue0jGcM=
X-Google-Smtp-Source: 
 AK7set/gESPrf22n9AJwmTDxhH2PBFDYBYEXN0r91+GYDbxXdjcQ1Ws8FAyeME56gFOWtdYsGsfRGQ==
X-Received: by 2002:a05:600c:a287:b0:3e9:372:10b3 with SMTP id
 hu7-20020a05600ca28700b003e9037210b3mr1655060wmb.25.1677072718790;
        Wed, 22 Feb 2023 05:31:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id
 t6-20020a1c7706000000b003e1fee8baacsm7000775wmi.25.2023.02.22.05.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 05:31:58 -0800 (PST)
Date: Wed, 22 Feb 2023 16:31:55 +0300
From: Dan Carpenter <error27@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v1 09/10] staging: dsp: add support for Fortemedia FM34NE
 DSP
Message-ID: <Y/YZS95D4MMjI56a@kadam>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-10-clamor95@gmail.com>
 <Y/Ud1bn+LExxLb/Q@kadam>
 <CAPVz0n3T-SiTbDyQTTE4L==OGkpSQrfBAP5gRjEevt4ozZLB-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <CAPVz0n3T-SiTbDyQTTE4L==OGkpSQrfBAP5gRjEevt4ozZLB-g@mail.gmail.com>
Message-ID-Hash: KKTGVH3NGWRVXEC2M34AMAGFEVGP54CO
X-Message-ID-Hash: KKTGVH3NGWRVXEC2M34AMAGFEVGP54CO
X-MailFrom: error27@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Takashi Iwai <tiwai@suse.com>, Maxim Schwalm <maxim.schwalm@gmail.com>,
 Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KKTGVH3NGWRVXEC2M34AMAGFEVGP54CO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Feb 22, 2023 at 10:06:23AM +0200, Svyatoslav Ryhel wrote:
> > > +static int fm34ne_dsp_set_hw(struct fm34ne_dsp_data *fm34)
> > > +{
> > > +     struct device *dev = &fm34->client->dev;
> > > +     int ret;
> > > +
> > > +     ret = clk_prepare_enable(fm34->dap_mclk);
> > > +     if (ret) {
> > > +             dev_err(dev, "failed to enable the DSP MCLK: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     ret = regulator_enable(fm34->vdd_supply);
> > > +     if (ret < 0) {
> > > +             dev_err(dev, "failed to enable vdd power supply\n");
> >
> > clk_disable_unprepare(fm34->dap_mclk);
> 
> No, dap_mclk has to be on, else there will be no sound on the device.
> 

If regulator_enable(fm34->vdd_supply); fails then the probe() is going
to fail so the sound isn't going to work anyway.  (I have a static
checker warning for missing calls to clk_disable_unprepare(), so it's
important for me to find out if we are deliberately not cleaning up).

> > > +             return ret;
> > > +     }
> > > +
> > > +     return 0;
> > > +}

regards,
dan carpenter

