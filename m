Return-Path: <SRS0=2VZE=MQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD86C4338F
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Jul 2021 08:55:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F17C60E91
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Jul 2021 08:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F17C60E91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A357A1773;
	Sat, 24 Jul 2021 10:54:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A357A1773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627116905;
	bh=rr5DyOF74U0H7iKb0m9zjXCsuqsP8q1pI+d5NX2axk8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iqF4vYuK0bARMJvhT31TiGEbrngT/JcG/bUVGB8jtu+/riA2TAQgg2eEeA3YxAkqP
	 cvZf1rmh4NebPaGVyMOmzDKoHUpHlpplrX7sWrkrTyV/ItZ0nkCJA0OnOnjBTy4ux9
	 0RoYIuN1JAL/o5U+rHHyDqiIoxGxmlOE+XSaFKK8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AADCF80256;
	Sat, 24 Jul 2021 10:53:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 344B4F80169; Tue, 20 Jul 2021 19:49:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94A03F80169
 for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2021 19:49:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94A03F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VEsgFDZv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6C8361004;
 Tue, 20 Jul 2021 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626803367;
 bh=rr5DyOF74U0H7iKb0m9zjXCsuqsP8q1pI+d5NX2axk8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VEsgFDZvIXjcoaGpPEoA0Lu9YRxM0Dj90aWqsnbErQ2UUMNfFjiL3KKy2ihSuQKA8
 DpJfkpmYcVJtchYg4JZ0xVl4g2Mg2o7fCdXq98nn/PAwMTFoWJ250/salXXOhJJg55
 abW/iC3f5GUZpAEMSlUl/XMmPNxf0dbMFp9c17FIFUFh6aPXTQv17aO0FFf2m4m8ho
 FzpeQH9QYcsgshAwYqEOKnzQKiefkbesH4vObWgtP6wKthPFfdBb/jqahxbI+okmue
 fOLCT92FxMSaj5N+ZOIj1PAxbFu2Oagsxe6Rc6uhcjBjL97r/vUbkyUju8PW712k3f
 K0QVogmSx6JEw==
Date: Tue, 20 Jul 2021 19:49:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Remove "status" from schema examples
Message-ID: <20210720194917.576b7d70@coco.lan>
In-Reply-To: <20210720172025.363238-1-robh@kernel.org>
References: <20210720172025.363238-1-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 24 Jul 2021 10:53:21 +0200
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Olivier Moysan <olivier.moysan@st.com>,
 Mateusz Holenko <mholenko@antmicro.com>,
 Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 ChiYuan Huang <cy_huang@richtek.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, Karol Gugala <kgugala@antmicro.com>,
 linux-rtc@vger.kernel.org, Dilip Kota <eswara.kota@linux.intel.com>,
 Wei Xu <xuwei5@hisilicon.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Chen-Yu Tsai <wens@csie.org>, Jakub Kicinski <kuba@kernel.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 Ramesh Shanmugasundaram <rashanmu@gmail.com>,
 Rui Miguel Silva <rmfrfs@gmail.com>, Mark Brown <broonie@kernel.org>,
 "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Alessandro Zummo <a.zummo@towertech.it>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>
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

Em Tue, 20 Jul 2021 11:20:25 -0600
Rob Herring <robh@kernel.org> escreveu:

> There's no reason to have "status" properties in examples. "okay" is the
> default, and "disabled" turns off some schema checks ('required'
> specifically).
> 
> Enabling qca,ar71xx causes a warning, so let's fix the node names:
> 
> Documentation/devicetree/bindings/net/qca,ar71xx.example.dt.yaml: phy@3: '#phy-cells' is a required property
>         From schema: schemas/phy/phy-provider.yaml
> 
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Rui Miguel Silva <rmfrfs@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Robert Marko <robert.marko@sartura.hr>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ramesh Shanmugasundaram <rashanmu@gmail.com>
> Cc: "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: ChiYuan Huang <cy_huang@richtek.com>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Dilip Kota <eswara.kota@linux.intel.com>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Olivier Moysan <olivier.moysan@st.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-media@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-rtc@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/allwinner,sun8i-a83t-dw-hdmi.yaml |  2 --
>  .../display/panel/boe,tv101wum-nl6.yaml       |  1 -

>  .../bindings/media/nxp,imx7-mipi-csi2.yaml    |  2 --
>  .../bindings/media/renesas,drif.yaml          |  1 -

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> # For media


Thanks,
Mauro
