Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859F1C43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:26:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E2D206D9
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t1iEtcvp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogOJELv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E2D206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 764A11680;
	Mon, 21 Sep 2020 10:25:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 764A11680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600676767;
	bh=zR4pC32CsRwkRMcQjTnnCp339wA8YZYmTzvhc8Ku3wQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1iEtcvpKE3lXozow82lHq28OAoWc+yH/p9RANqTe7nHmqVN3MiiHd9lmh7MQ0n0Z
	 eqmVb2bxMs7zBG9ZfgH17Bvw1tE6GYfNOCXNea7ypdsjt5tg8MV9RoXB78sYwHQMAJ
	 KjeATKIZ4nAd7XNRPVbkzgBfAsYHLbMAb1HKCFYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 881B3F80394;
	Mon, 21 Sep 2020 10:11:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EC16F8015A; Fri, 18 Sep 2020 09:53:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36CD4F8013A
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 09:53:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36CD4F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ogOJELv+"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A8F02344C
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 07:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600415593;
 bh=zR4pC32CsRwkRMcQjTnnCp339wA8YZYmTzvhc8Ku3wQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ogOJELv++NZ3u14/pa+l3wwPrz8NuWoS2ByyQtvJSTTJ4/79CKrX3BCWX39+uEuf4
 aMNJBNxW+LdF36MUOT3C5jt1NXvqCwwEMTRabZxMAi8SXvzvUCLO/2rpMOj77ycCL9
 kEXZCgXUfpnZYUqSNYRLVmQg8T4AqMVq4GP8Sx6U=
Received: by mail-ej1-f47.google.com with SMTP id j11so6906902ejk.0
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 00:53:13 -0700 (PDT)
X-Gm-Message-State: AOAM532QrjHKYiDlZU+JTIQvgkrbogpSKqNcP4o3s/f2UMMNHSXMNPXG
 nHbKIO1omjVQxI47lepp5/F4OS6OCWb5PMWpDCs=
X-Google-Smtp-Source: ABdhPJz4h58zSa29o5A1o7MhoFoews9vi+zWZmYhOt2gWbPt5yeBvYS4l1uut8tLvrHP24ftCZlb9SA8h3ZMk81xBpI=
X-Received: by 2002:a17:906:5008:: with SMTP id
 s8mr36525529ejj.408.1600415590292; 
 Fri, 18 Sep 2020 00:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200917165301.23100-1-krzk@kernel.org>
 <20200917165301.23100-2-krzk@kernel.org>
 <20200917200936.GF3969@pendragon.ideasonboard.com>
In-Reply-To: <20200917200936.GF3969@pendragon.ideasonboard.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 18 Sep 2020 09:52:57 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc=o0vtU0VKE5b5Ro3nF=ra-p7UnbFfjj_++onw8MeSKQ@mail.gmail.com>
Message-ID: <CAJKOXPc=o0vtU0VKE5b5Ro3nF=ra-p7UnbFfjj_++onw8MeSKQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] dt-bindings: gpio: add common schema for GPIO
 controllers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 21 Sep 2020 10:10:22 +0200
Cc: Amelie Delaunay <amelie.delaunay@st.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org,
 Stefan Agner <stefan@agner.ch>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Chris Brandt <chris.brandt@renesas.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-riscv@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-renesas-soc@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Anson Huang <Anson.Huang@nxp.com>, Lee Jones <lee.jones@linaro.org>,
 Takashi Iwai <tiwai@suse.com>, Magnus Damm <magnus.damm@gmail.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Andy Gross <agross@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 NXP Linux Team <linux-imx@nxp.com>, Andy Teng <andy.teng@mediatek.com>,
 Jacopo Mondi <jacopo+renesas@jmondi.org>, Sungbo Eo <mans0n@gorani.run>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Sean Wang <sean.wang@mediatek.com>,
 Maxime Ripard <mripard@kernel.org>, linux-gpio@vger.kernel.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Sricharan R <sricharan@codeaurora.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hoan Tran <hoan@os.amperecomputing.com>, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Scott Branden <sbranden@broadcom.com>, linux-unisoc@lists.infradead.org,
 - <patches@opensource.cirrus.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Liam Girdwood <lgirdwood@gmail.com>, Serge Semin <fancer.lancer@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Yash Shah <yash.shah@sifive.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Mark Brown <broonie@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-media@vger.kernel.org,
 Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
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

On Thu, 17 Sep 2020 at 22:10, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Krzysztof,
>
> Thank you for the patch.
>
> On Thu, Sep 17, 2020 at 06:52:49PM +0200, Krzysztof Kozlowski wrote:
> > Convert parts of gpio.txt bindings into common dtschema file for GPIO
> > controllers.
>
> How about deleting the part that has been converted from gpio.txt ?

I did not move everything from the gpio.txt and it is really nicely
explained there. I think to leave it as it works as a overview/guide
better than YAML.

>
> > The schema enforces proper naming of GPIO controller nodes and GPIO
> > hogs.
> >
> > The schema should be included by specific GPIO controllers bindings.
>
> Instead of including it manually, could we use a conditional select: to
> apply the schema automatically when a gpio-controller property is
> present ?

You mean the same way as generic schema for GPIO controllers work?
This could be done but the point is to enforce the GPIO controller
bindings in GPIO controllers, so also in cases when someone forgets to
add "gpio-controller" property. Although, if given GPIO controller
schema requires "gpio-controller" then indeed select would work...

Best regards,
Krzysztof
