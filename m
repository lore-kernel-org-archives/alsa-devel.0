Return-Path: <SRS0=jDen=FJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57BFC4361A
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 08:09:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3671A22DBF
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 08:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3671A22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA13D191C;
	Sat,  5 Dec 2020 09:09:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA13D191C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607155790;
	bh=x+xqb7hfl276yhO2Ps7ujTU1b2CUv2DA5LRXB7neOMk=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DFoJON5wUx5HakMWmYf6e/x/7hxjMd0AkvPkTi5gdztYsMWTKXrU380GkfxzlyCo5
	 o3BLtyw/ZbM24DDaevQa2/hkWa+5OudB2KFhZv73toomdnXa+FXQVZolrmgiu/o9LQ
	 eGi3LlePc8WzzNWOF1uBt/5xz7G4guHE9DDRyius=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06AFEF80520;
	Sat,  5 Dec 2020 09:03:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2C71F80278; Fri,  4 Dec 2020 04:20:06 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAB68F800E2
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2020 04:20:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAB68F800E2
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnHxZ59R5z15XCk;
 Fri,  4 Dec 2020 11:19:30 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Dec 2020
 11:19:54 +0800
Subject: Re: [PATCH 0/1] dt-bindings: eliminate yamllint warnings
To: Rob Herring <robh+dt@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP Linux Team" <linux-imx@nxp.com>, David Airlie <airlied@linux.ie>,
 "Daniel Vetter" <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 "Thierry Reding" <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 "Hans Verkuil" <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, "Ricardo
 Ribalda" <ribalda@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, linux-clk
 <linux-clk@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 linux-media <linux-media@vger.kernel.org>, linux-mmc
 <linux-mmc@vger.kernel.org>, linux-mediatek
 <linux-mediatek@lists.infradead.org>, alsa-devel
 <alsa-devel@alsa-project.org>
References: <20201204024226.1222-1-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5dba4db6-dc66-44a8-ac4c-c5fe288c3430@huawei.com>
Date: Fri, 4 Dec 2020 11:19:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201204024226.1222-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sat, 05 Dec 2020 09:03:14 +0100
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

Sorry, Forgot to say: This patch is based on the latest linux-next code.


On 2020/12/4 10:42, Zhen Lei wrote:
> There're too many people, I just send to the maintainer, reviewer, supporter.
> 
> Eliminate below warnings:
> ./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml:32:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
> ./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml:35:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml:21:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
> ./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml:52:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
> ./Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml:42:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
> ./Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml:45:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
> ./Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml:25:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
> ./Documentation/devicetree/bindings/media/i2c/adv7604.yaml:24:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml:4:1: [error] missing document start "---" (document-start)
> ./Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml:29:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml:32:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/media/i2c/ovti,ov772x.yaml:79:17: [warning] wrong indentation: expected 14 but found 16 (indentation)
> ./Documentation/devicetree/bindings/media/i2c/ovti,ov772x.yaml:88:17: [warning] wrong indentation: expected 14 but found 16 (indentation)
> ./Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml:72:17: [warning] wrong indentation: expected 18 but found 16 (indentation)
> ./Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml:75:17: [warning] wrong indentation: expected 18 but found 16 (indentation)
> ./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:33:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
> 
> 
> Zhen Lei (1):
>   dt-bindings: eliminate yamllint warnings
> 
>  .../devicetree/bindings/clock/imx8qxp-lpcg.yaml    | 20 ++++++++---------
>  .../bindings/display/bridge/analogix,anx7625.yaml  |  4 ++--
>  .../bindings/display/bridge/intel,keembay-dsi.yaml |  4 ++--
>  .../bindings/display/intel,keembay-msscam.yaml     |  4 ++--
>  .../bindings/display/panel/novatek,nt36672a.yaml   |  2 +-
>  .../devicetree/bindings/media/i2c/adv7604.yaml     |  4 ++--
>  .../devicetree/bindings/media/i2c/mipi-ccs.yaml    | 11 ++++-----
>  .../devicetree/bindings/media/i2c/ovti,ov772x.yaml | 12 +++++-----
>  .../devicetree/bindings/media/i2c/sony,imx214.yaml | 12 +++++-----
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml  | 26 +++++++++++-----------
>  .../sound/mt8192-mt6359-rt1015-rt5682.yaml         |  4 ++--
>  11 files changed, 52 insertions(+), 51 deletions(-)
> 

