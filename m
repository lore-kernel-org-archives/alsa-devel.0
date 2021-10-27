Return-Path: <SRS0=jYMw=PQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E90C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 07:26:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A29260F39
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 07:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A29260F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F21816A5;
	Thu, 28 Oct 2021 09:25:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F21816A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635406006;
	bh=MzcBsR/GxQuykWhFa19qsNlaeYURmTU5wtakQc8uxt4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=izcFhyFeZAlUuaXI0ZGZ/tuOXXGMW252INAhifegcN7aIQdqqhNsveUO6VgrDZ8f6
	 XbsTDGcpWxypiAI7zVEp+WKFRxRXz/o2QW8/ydQQwzG2imjXt7PZFaUrYNLcuq3jR2
	 b/93Qwps0FdRw3a0gpUDBwMmq1iGWX58FQY+his8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97C21F804AE;
	Thu, 28 Oct 2021 09:25:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93FFBF8025A; Wed, 27 Oct 2021 08:11:09 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A7C1F800D1
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 08:11:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A7C1F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com
 header.b="pLut+GxR"
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QIJftj012181; 
 Wed, 27 Oct 2021 08:10:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=q0IzamWoBnMLIIIWgH1c6YZ0YARVpDAlAywCoCd8O6A=;
 b=pLut+GxRqLoEwutxmEsKmT0U9f6n8Czu59GaLbziADOMwtznLgQUZ54Gw0mFG30LzTFI
 mAf8pn9K9k2l9XDGD8kyB8y+cnm5BmAO3YB00+gyy/yFMSCCO5HF8/PQ6lATeCubYrNt
 DdiIwe9I6oNJ1LpNKfJ0tNMiodtkGtIRzCLDVOx9JfwIBUGTkeKgOf8Hru+PdxHSGGIB
 WmjLMAKdFPGg4+kJmvUsa+tgl9tTdDraTeFW116MnoqgEuCPXI2gblkV13eeEpJbnLHW
 9gSaSeXE68XwgQBNQi7Ez8d68t00m5nmdGyM96U93gZ2aaDRvaLknKJ4aiI1DjaFKmGE dQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 3bxputjet7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Oct 2021 08:10:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6E078100044;
 Wed, 27 Oct 2021 08:10:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A09DC21810A;
 Wed, 27 Oct 2021 08:10:46 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 27 Oct
 2021 08:10:43 +0200
Subject: Re: dt-bindings: treewide: Update @st.com email address to
 @foss.st.com
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, maxime coquelin <mcoquelin.stm32@gmail.com>,
 "alexandre torgue" <alexandre.torgue@foss.st.com>, michael turquette
 <mturquette@baylibre.com>, stephen boyd <sboyd@kernel.org>, herbert xu
 <herbert@gondor.apana.org.au>, "david s . miller" <davem@davemloft.net>,
 david airlie <airlied@linux.ie>, daniel vetter <daniel@ffwll.ch>, "thierry
 reding" <thierry.reding@gmail.com>, sam ravnborg <sam@ravnborg.org>,
 "yannick fertre" <yannick.fertre@foss.st.com>, philippe cornu
 <philippe.cornu@foss.st.com>, benjamin gaignard
 <benjamin.gaignard@linaro.org>,
 vinod koul <vkoul@kernel.org>, ohad ben-cohen <ohad@wizery.com>,
 bjorn andersson <bjorn.andersson@linaro.org>, baolin wang
 <baolin.wang7@gmail.com>, jonathan cameron <jic23@kernel.org>, "lars-peter
 clausen" <lars@metafoo.de>, olivier moysan <olivier.moysan@foss.st.com>,
 arnaud pouliquen <arnaud.pouliquen@foss.st.com>, Thomas Gleixner
 <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hugues Fruchet <hugues.fruchet@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lee Jones <lee.jones@linaro.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Jakub Kicinski <kuba@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>, Matt Mackall <mpm@selenic.com>, "Alessandro
 Zummo" <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Viresh Kumar <viresh.kumar@linaro.org>, "Ahmad
 Fatoum" <a.fatoum@pengutronix.de>, Jagan Teki <jagan@amarulasolutions.com>,
 dillon min <dillon.minfei@gmail.com>, Marek Vasut <marex@denx.de>, "Laurent
 Pinchart" <laurent.pinchart@ideasonboard.com>, Sebastian Reichel
 <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Paul Cercueil <paul@crapouillou.net>,
 Fabien Dessenne <fabien.dessenne@foss.st.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Amelie Delaunay <amelie.delaunay@foss.st.com>, Pierre-Yves MORDRET
 <pierre-yves.mordret@foss.st.com>,
 Ludovic Barre <ludovic.barre@foss.st.com>,
 Christophe Kerello <christophe.kerello@foss.st.com>, pascal Paillet
 <p.paillet@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, "Jose
 Abreu" <joabreu@synopsys.com>, Le Ray <erwan.leray@foss.st.com>
References: <20211020065000.21312-1-patrice.chotard@foss.st.com>
 <22fb6f19-21eb-dcb5-fa31-bb243d4a7eaf@canonical.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <e8ddc63b-a0b5-79ae-6aff-19810cf74920@foss.st.com>
Date: Wed, 27 Oct 2021 08:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <22fb6f19-21eb-dcb5-fa31-bb243d4a7eaf@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_01,2021-10-26_01,2020-04-07_01
X-Mailman-Approved-At: Thu, 28 Oct 2021 09:25:10 +0200
Cc: alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org
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

Hi Krzysztof

On 10/20/21 9:45 AM, Krzysztof Kozlowski wrote:
> On 20/10/2021 08:50, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Not all @st.com email address are concerned, only people who have
>> a specific @foss.st.com email will see their entry updated.
>> For some people, who left the company, remove their email.
>>
> 
> Please split simple address change from maintainer updates (removal,
> addition).

ok

> 
> Also would be nice to see here explained *why* are you doing this.

Our @foss.st.com address are dedicated for upstream activities, 
i will add a comment about this.

Thanks
Patrice

> 
> Best regards,
> Krzysztof
> 
