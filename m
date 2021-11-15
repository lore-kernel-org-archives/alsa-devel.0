Return-Path: <SRS0=e+ka=QF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B69FC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 16:39:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D25D61A6C
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 16:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D25D61A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 826B817F5;
	Thu, 18 Nov 2021 17:38:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 826B817F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637253588;
	bh=caNhQR6MItqyqj8aVGADFWmRHHEWyDNeG1UmwE7ptic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RTYnmE7dAkeLfXOb2ezJJObzfCpmgKukLDEw70rzZiIjFGhVTKt4Szo4QzIWsBk8h
	 /UzH6RgEzJSo9ZWo8gM2h/+3/oNaUFEsr8Arab8I2kzgsPGzD6+IYAH1BNNoRW9bgB
	 5Bhur3CISwrFR6oC/yjsG688niHLR/6n0p0ppS2k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CC33F8054A;
	Thu, 18 Nov 2021 17:33:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F392DF8027D; Mon, 15 Nov 2021 16:15:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FA7EF80163
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 16:15:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FA7EF80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Dr80sE3a"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5F5663222
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636989317;
 bh=caNhQR6MItqyqj8aVGADFWmRHHEWyDNeG1UmwE7ptic=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Dr80sE3aw+SJUtKRA8bYPi28rK3JmreYcEl7h8agB+wJiaLEDAvVbRPvWEeL8APNa
 RY0QuVKIPlt/TDI9mCAVapj4PC3N6zojsQO9Jk5Xq7/WB42HlA+6bLBGulMWWYWIzC
 nfiEVn1oCHhuEaGpo7fB4SpuDXTqWEgNm38Czh97cWr55BmoFJtemhO8EjP+zLl9wD
 lf7Kgcy9fGAQu5ifnLgquyEJjMa4wmfV5f1ETuHrh9lSk80d0CZKYl1k5xBB1h60+F
 HcHx4lDoMCAaNVq1R+OnUQ5PgeGVPc2XhM6R1A9aToMBsx/9uV/KcgTXZBBtcJTbUR
 VW+s6K6bFg9zA==
Received: by mail-wm1-f42.google.com with SMTP id
 r9-20020a7bc089000000b00332f4abf43fso72819wmh.0
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 07:15:17 -0800 (PST)
X-Gm-Message-State: AOAM531ay1csufyiSwMdCr1YKtgSlCcW5tZFj8j0LDmlQYtt/Nt2Ojxw
 K21QS4W39R/KkzOZb3bhDGV3hq8G/C5FXe5yCtQ=
X-Google-Smtp-Source: ABdhPJy8n2MSwzh6suyWZ9JESZ+B+WCCwhvtwsBUIZeDj84QhV0+ZckRDxWsOxlhdmOo7jylNl8QiKm3gBRShRPmqHI=
X-Received: by 2002:a1c:2382:: with SMTP id j124mr42651026wmj.35.1636989316377; 
 Mon, 15 Nov 2021 07:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20211115085403.360194-1-arnd@kernel.org>
 <20211115085403.360194-2-arnd@kernel.org>
 <647b842d-76a1-7a96-3ea7-8a37b62bc18e@metafoo.de>
 <CAK8P3a2EVseM4t=e982fFhzBGSZxZ2_V-FHwr-fQPd-bkAKaJg@mail.gmail.com>
 <d2dd42fc-e58a-0c06-7f7e-a6a2161c368d@metafoo.de>
 <5737810c-420a-2f8d-99bf-24a2558d5855@gmail.com>
In-Reply-To: <5737810c-420a-2f8d-99bf-24a2558d5855@gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 15 Nov 2021 16:15:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1dGSF-S4msKKWvPYORwYCFvtkNSJwkhtxvETgiQjC7_Q@mail.gmail.com>
Message-ID: <CAK8P3a1dGSF-S4msKKWvPYORwYCFvtkNSJwkhtxvETgiQjC7_Q@mail.gmail.com>
Subject: Re: [PATCH 01/11] ASoC: dai_dma: remove slave_id field
To: Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 18 Nov 2021 17:33:02 +0100
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-spi <linux-spi@vger.kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Lars-Peter Clausen <lars@metafoo.de>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-staging@lists.linux.dev, Michal Simek <michal.simek@xilinx.com>,
 Jon Hunter <jonathanh@nvidia.com>, Andy Gross <agross@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Manivannan Sadhasivam <mani@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Scott Branden <sbranden@broadcom.com>, Hyun Kwon <hyun.kwon@xilinx.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Baolin Wang <baolin.wang7@gmail.com>
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

On Mon, Nov 15, 2021 at 3:46 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> 15.11.2021 14:53, Lars-Peter Clausen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> That Tegra SPDIF driver was never used. Still there is a growing
> interest nowadays in making it alive by implementing HDMI audio support
> for Tegra20 SoC. It was on my todo list for a long time, I'll try to
> prioritize that work 5.17, it shouldn't take much effort.
>
> The slave_id should be removed anyways, it won't be needed.

Ok, thanks for the background, I'll mention that in the changelog text then=
.

     Arnd
