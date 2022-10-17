Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BCCC4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Oct 2022 10:37:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 947FBA499;
	Thu, 20 Oct 2022 12:36:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 947FBA499
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666262255;
	bh=+DzhSmH1cBeruDtFaVKaVattsEwc8q4hTsou+lcv6jY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pgIFL6QhuZUg4owNNhhUdgqBJ6OabpOj+yTYBi+K+RWBbQDlFLthtQVi4BfQHjsxX
	 JTqR90J9MW46s9rBGpYtvCSjDtHlhZp6E3g1nC3j5XERKI8OfVmeg+D2hB1UcFRIYR
	 K/aSzbwGGLq2J/+PNbuKDsOHkFIzWN/GeY11yB5s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3CE5F805A1;
	Thu, 20 Oct 2022 12:33:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C3A2F80496; Mon, 17 Oct 2022 11:02:31 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1B37F800E5
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2022 11:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1B37F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Q+/ZCk5u"
Received: by mail-ej1-x62a.google.com with SMTP id bj12so23277526ejb.13
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2022 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+DzhSmH1cBeruDtFaVKaVattsEwc8q4hTsou+lcv6jY=;
 b=Q+/ZCk5uKgheops7slfnvs8xurY8FEURvOhzY1eTrLbemXNWuo99WUD81VK+SpWCxY
 kzFTgIjquxop1/2G9aP+Jc1kCFR8S4kpwj8bfbUkfgvulb3p97gFWTEKh91wZsvKLTym
 IGt1H+AuIDwRoqtXQsNeJNwHocUiIbe3K3kYShul2xo1CQl7PNr7jxP/Mgn3ZFbkZlVO
 J/03NK6UfMQfdp40SIbVe6sr9G0pZuHS/nb7XvkWBeDwVFOg7SA3FW+4r+22nfUcKvmM
 0KiMdRaZT5lr/vOJbfahx9OfxFGmc5oyK0hcI+W0d917YHmMVMRNLZ2UqBGud/XBVBC3
 GKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+DzhSmH1cBeruDtFaVKaVattsEwc8q4hTsou+lcv6jY=;
 b=nNiIIlXRSGQg1iwRjIFA4j3jqUXjT3MBP7gbTEXUDDZg4vw3eXokA7mWQXpgI/Afsa
 KJKFjcqKC9ZxszHCXN5tOQZ+/8mfE4h+Ai0HHDkIwAO3H11LV78uWmAw2VymRg2fa9Ni
 qO10Edf0WCXsXw2WdX5Wnvlc44f9oQYjxQkBmKpqhl8fFWJGpYOZa1UACrBURWcxq7IC
 CNFN75+Wz4M0J3plHaknUYydHu3KcHxCy7lLljrGFSSG/jofYciP8lGhWMIiewSFe7Pq
 Kf7dh0zVr23fbW1VK5Pd26ibwuD1ngtbVsMrWSouAJZt7z5mf+US8XZjoL1ewb0V02IP
 cB4w==
X-Gm-Message-State: ACrzQf3Dt/HfE/3sCsJyEdrUMzOJ9P7LXoijUT93myw2gCYQH2nIs4eO
 H0xZKcLNc2Mk7VW2rLUxIQQ0SwhPCk6Eh7bZQvlPpQ==
X-Google-Smtp-Source: AMsMyM4UDyy4gIfLqRCo+xVdWhgvw2QqSAfU62C/zZi9P70aMTTtCFnk0FMes6AqIcJjw6kKWDVGE0urcJP2xkclA/A=
X-Received: by 2002:a17:906:8a48:b0:78d:acdc:b7d9 with SMTP id
 gx8-20020a1709068a4800b0078dacdcb7d9mr7921544ejc.500.1665997341068; Mon, 17
 Oct 2022 02:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Oct 2022 11:02:09 +0200
Message-ID: <CACRpkdZ1M3ckw+jFgvMqG4jvR-t_44GPoZ6ZDXszwZCJr-cDpg@mail.gmail.com>
Subject: Re: [rft, PATCH v2 00/36] pinctrl: Clean up and add missed headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 20 Oct 2022 12:33:17 +0200
Cc: Andrew Lunn <andrew@lunn.ch>, Kent Gibson <warthog618@gmail.com>,
 Tomer Maimon <tmaimon77@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Phil Edworthy <phil.edworthy@renesas.com>, linux-samsung-soc@vger.kernel.org,
 Samuel Holland <samuel@sholland.org>, Michal Simek <michal.simek@xilinx.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 NXP Linux Team <linux-imx@nxp.com>, Tali Perry <tali.perry1@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-omap@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 Scott Branden <sbranden@broadcom.com>, Andrew Jeffery <andrew@aj.id.au>,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-aspeed@lists.ozlabs.org,
 Thierry Reding <thierry.reding@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Fabien Dessenne <fabien.dessenne@foss.st.com>, linux-media@vger.kernel.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, linux-arm-msm@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>, linux-actions@lists.infradead.org,
 linux-gpio@vger.kernel.org, soc@kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Dong Aisheng <aisheng.dong@nxp.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, linux-renesas-soc@vger.kernel.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, alsa-devel@alsa-project.org,
 Fabio Estevam <festevam@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Benjamin Fair <benjaminfair@google.com>, Nancy Yuen <yuenn@google.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Joel Stanley <joel@jms.id.au>, Chen-Yu Tsai <wenst@chromium.org>,
 Orson Zhai <orsonzhai@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Ray Jui <rjui@broadcom.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Avi Fishman <avifishman70@gmail.com>, Patrick Venture <venture@google.com>,
 Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Tony Lindgren <tony@atomide.com>, Konrad Dybcio <konrad.dybcio@somainline.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Haojian Zhuang <haojian.zhuang@linaro.org>, linux-riscv@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, openbmc@lists.ozlabs.org,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Prathamesh Shete <pshete@nvidia.com>, Andy Gross <agross@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 patches@opensource.cirrus.com, Sean Wang <sean.wang@kernel.org>,
 linux-mips@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
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

On Mon, Oct 10, 2022 at 10:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Currently the header inclusion inside the pinctrl headers seems more arbitrary
> than logical. This series is basically out of two parts:
> - add missed headers to the pin control drivers / users
> - clean up the headers of pin control subsystem
>
> The idea is to have this series to be pulled after -rc1 by the GPIO and
> pin control subsystems, so all new drivers will utilize cleaned up headers
> of the pin control.

Aha I see you want to send a pull request so I backed out the applied patches
from the series for now.

Yours,
Linus Walleij
