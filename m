Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E9C4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:18:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2415610C9
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2415610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD1E216CE;
	Tue,  1 Jun 2021 19:17:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD1E216CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622567895;
	bh=8+TLc1y+IxHHiJDW3JEG+UvymzW+2AYjCfoceMGLcWM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LRHgJ+nYXt5t0ia6hqaYw190EVXvBbMgxmljhi2YP6gMk29ZNyYUtMZW8QY/p8i0t
	 grjBTM4IuHDtgAlnz+mOb+bg6OC3IxwP1unrVI5qYI4VSBMIrhqvpuj9xCMjrT1Q1x
	 I2kD3+kRxQ1n5Hs4bqcrZ2CJCPzDJmCe2QgqJfog=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5167BF80253;
	Tue,  1 Jun 2021 19:17:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE9BAF80254; Tue,  1 Jun 2021 19:17:23 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DEAC1F801DB
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 19:17:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEAC1F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="PpAvrlDO"
Received: by mail-ot1-x32d.google.com with SMTP id
 i12-20020a05683033ecb02903346fa0f74dso14797676otu.10
 for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2021 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=6SAc4++qABizp6ptj0SCF0e03ok47gKm5Ef5EiX32Oo=;
 b=PpAvrlDOxyYXDMLesS+IfXJmAmPMagvcqcnIjsYohPPHPUmG6Ll2FyUgt0xxXzkSp9
 8PhSdcovoP/NXrjrKmWjH9vdBJ0msXTmhfaV7AZ4CE5cb3Ul+u1q9z2IJEHHUufeimYS
 Y5YV7LTnRra7xuJC1vUYNBZQ6L0EZH/P5kIUhEFuM20ihi8vp70CPlkUyF0CjflvrETO
 quVaRPtPXL2lRJujNHAXiR8whHTvuU5smKdoJqv0QwD559Oz05yX61f1H5qD77DzjAnR
 LpSJS9ShwlYFNvE1XmDo3Vxv9t2t2GGnRPYZ6kH9x4184vijuCAcjTLOzqGh1OLxXu8P
 H27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6SAc4++qABizp6ptj0SCF0e03ok47gKm5Ef5EiX32Oo=;
 b=aa5qcXPXz1zVMmihIl0IviT9p8ssl4fcq5WP6ue01egBksYntyoI/MmGUrDOGjwi95
 DjNMk9onQBcf9l31WBIARQqmXf+TQXCPBTthWSI4p81yefPR5gNV4J2as5dwkc7n2vHo
 rahPsIYmcgd+R+4/T8WN6I/wLjo5I9k2bfnABCfiTs4Bh7/SS5oHHNuHLRvtGMUdmjFY
 mkpqId6mZngvLZanOiXTjkh1YVpPhN1+AW+ch6TCJCE2rrI37cz/rIzIrvT8TjSRdeob
 uXq+ba9fHwuUUNh2tC25n3qdEYXqV2nR7d/qTOYzRl26nqWbuOQsbramaqH1juvXt+jx
 0tCQ==
X-Gm-Message-State: AOAM531dgeyU7sQ4fXrlMjZXqylU5F3pgRLXZ7rCBt4PrYiqnAGWqCiK
 Wrv/2Dlu3HIfY763jrXFL/c=
X-Google-Smtp-Source: ABdhPJxtizSIYWeWnAtw7Z79wz0XdWb3imQFmVDNpImDOF0JRE38WXiBeG/YJoJmhwbhLy8u8P6KQQ==
X-Received: by 2002:a9d:7610:: with SMTP id k16mr22770791otl.32.1622567832894; 
 Tue, 01 Jun 2021 10:17:12 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com.
 [76.183.134.35])
 by smtp.gmail.com with ESMTPSA id s26sm1314325otd.61.2021.06.01.10.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jun 2021 10:17:12 -0700 (PDT)
Date: Tue, 1 Jun 2021 12:17:08 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between MFD and ASoC due for the
 v5.14 merge window
Message-ID: <20210601171708.GA3529@wintermute.localdomain>
References: <20210519203754.27184-1-macroalpha82@gmail.com>
 <20210601140145.GH543307@dell> <20210601155832.GC2165650@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601155832.GC2165650@dell>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 heiko@sntech.de, devicetree@vger.kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org,
 broonie@kernel.org, Chris Morgan <macromorgan@hotmail.com>, jbx6244@gmail.com,
 maccraft123mc@gmail.com
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

On Tue, Jun 01, 2021 at 04:58:32PM +0100, Lee Jones wrote:
> On Tue, 01 Jun 2021, Lee Jones wrote:
> 
> > I've applied the non-Arm patches.
> > 
> > The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> > 
> >   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tb-mfd-asoc-v5.14
> > 
> > for you to fetch changes up to 437faaa6cebadf8ff4c2c28d7cb26ed4e34aeb14:
> > 
> >   dt-bindings: Add Rockchip rk817 audio CODEC support (2021-06-01 13:40:41 +0100)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between MFD and ASoC due for the v5.14 merge window
> > 
> > ----------------------------------------------------------------
> > Chris Morgan (3):
> >       mfd: Add Rockchip rk817 audio CODEC support
> >       ASoC: Add Rockchip rk817 audio CODEC support
> >       dt-bindings: Add Rockchip rk817 audio CODEC support
> > 
> >  Documentation/devicetree/bindings/mfd/rk808.txt | 188 +++++++++
> >  drivers/mfd/rk808.c                             |  81 ++++
> >  include/linux/mfd/rk808.h                       |  81 ++++
> >  sound/soc/codecs/Kconfig                        |   6 +
> >  sound/soc/codecs/Makefile                       |   2 +
> >  sound/soc/codecs/rk817_codec.c                  | 539 ++++++++++++++++++++++++
> >  6 files changed, 897 insertions(+)
> >  create mode 100644 sound/soc/codecs/rk817_codec.c
> 
> Looks like the builders reported a W=1 warning introduced by the set.
> 
> Would you like me to fix it and submit a patch?

I can't seem to reproduce the warning, are there more details as to
what is causing it?

Thank you.

> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
