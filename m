Return-Path: <SRS0=jDen=FJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD72FC4361A
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 08:07:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2587A22D0B
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 08:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2587A22D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9C3018C7;
	Sat,  5 Dec 2020 09:06:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9C3018C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607155651;
	bh=vWePC9qDv7C4anJifZjGHS0AugrgVsMBcQg3lrjW1Xo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hGLRVu38OkUe0p0bIpXcWsk4HR8zhgH41Gb7j8Hh5KMPG5ka8AnKqo6LvofhwJ+Gl
	 tv8SORUDzTVh66/8twXp+qDvkIMcbgbE1Viw/811FseknD5Ycw1nuhpAzh62LjMOR4
	 UD4mhmt+/uI+8/ZIWkxAhSTioEEAvQ6Gjio2A/lw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24ED7F804F2;
	Sat,  5 Dec 2020 09:03:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D582FF80254; Fri,  4 Dec 2020 03:43:52 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A19F5F80158
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2020 03:43:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A19F5F80158
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnH7b3FMKzkl4x;
 Fri,  4 Dec 2020 10:43:07 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 10:43:33 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
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
Subject: [PATCH 0/1] dt-bindings: eliminate yamllint warnings
Date: Fri, 4 Dec 2020 10:42:25 +0800
Message-ID: <20201204024226.1222-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sat, 05 Dec 2020 09:03:14 +0100
Cc: Zhen Lei <thunder.leizhen@huawei.com>
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

There're too many people, I just send to the maintainer, reviewer, supporter.

Eliminate below warnings:
./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml:32:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml:35:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml:21:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml:52:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
./Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml:42:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
./Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml:45:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
./Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml:25:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
./Documentation/devicetree/bindings/media/i2c/adv7604.yaml:24:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml:4:1: [error] missing document start "---" (document-start)
./Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml:29:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml:32:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/media/i2c/ovti,ov772x.yaml:79:17: [warning] wrong indentation: expected 14 but found 16 (indentation)
./Documentation/devicetree/bindings/media/i2c/ovti,ov772x.yaml:88:17: [warning] wrong indentation: expected 14 but found 16 (indentation)
./Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml:72:17: [warning] wrong indentation: expected 18 but found 16 (indentation)
./Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml:75:17: [warning] wrong indentation: expected 18 but found 16 (indentation)
./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mmc/mtk-sd.yaml:33:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)


Zhen Lei (1):
  dt-bindings: eliminate yamllint warnings

 .../devicetree/bindings/clock/imx8qxp-lpcg.yaml    | 20 ++++++++---------
 .../bindings/display/bridge/analogix,anx7625.yaml  |  4 ++--
 .../bindings/display/bridge/intel,keembay-dsi.yaml |  4 ++--
 .../bindings/display/intel,keembay-msscam.yaml     |  4 ++--
 .../bindings/display/panel/novatek,nt36672a.yaml   |  2 +-
 .../devicetree/bindings/media/i2c/adv7604.yaml     |  4 ++--
 .../devicetree/bindings/media/i2c/mipi-ccs.yaml    | 11 ++++-----
 .../devicetree/bindings/media/i2c/ovti,ov772x.yaml | 12 +++++-----
 .../devicetree/bindings/media/i2c/sony,imx214.yaml | 12 +++++-----
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  | 26 +++++++++++-----------
 .../sound/mt8192-mt6359-rt1015-rt5682.yaml         |  4 ++--
 11 files changed, 52 insertions(+), 51 deletions(-)

-- 
1.8.3


