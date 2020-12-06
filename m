Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB0C433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 07:39:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A45206B6
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 07:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A45206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 049D91745;
	Mon,  7 Dec 2020 08:38:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 049D91745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607326771;
	bh=8hTiVz5Adnb/w4c8Unui1keaAhIJgwWXhv4CHr31zfA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YTjeNVb2RptN2clRvzHOAD5Yqr7HaAlMlkxau6zEElR1JxHf2VH8BLtZ49xEkTdrZ
	 QiIeBftWySAskCBnfgJcM9haifFr6RHeeBL/7kh5H4HpZPoQU3OdCcwoM4awa+279n
	 LJsX/jHGJJ8i7tCJlmG4iMBlDTltvqCKQnXvGhFs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39639F8027C;
	Mon,  7 Dec 2020 08:37:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DDECF8019D; Sun,  6 Dec 2020 06:18:51 +0100 (CET)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AD44F8010A
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2020 06:18:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AD44F8010A
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CpZTZ5M3qz78Jf;
 Sun,  6 Dec 2020 13:18:10 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sun, 6 Dec 2020
 13:18:34 +0800
Subject: Re: [PATCH 1/1] dt-bindings: eliminate yamllint warnings
To: Mark Brown <broonie@kernel.org>
References: <20201204024226.1222-1-thunder.leizhen@huawei.com>
 <20201204024226.1222-2-thunder.leizhen@huawei.com>
 <20201204174135.GC4558@sirena.org.uk>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <323edb53-71a7-ba81-17b9-704ae3e7a7a1@huawei.com>
Date: Sun, 6 Dec 2020 13:18:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201204174135.GC4558@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 07 Dec 2020 08:37:43 +0100
Cc: Ricardo
 Ribalda <ribalda@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-clk <linux-clk@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, NXP Linux Team <linux-imx@nxp.com>,
 linux-media <linux-media@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, alsa-devel <alsa-devel@alsa-project.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Shawn Guo <shawnguo@kernel.org>
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



On 2020/12/5 1:41, Mark Brown wrote:
> On Fri, Dec 04, 2020 at 10:42:26AM +0800, Zhen Lei wrote:
>> All warnings are related only to "wrong indentation", except one:
>> Documentation/devicetree/bindings/media/i2c/mipi-ccs.yaml:4:1: \
>> [error] missing document start "---" (document-start)
> 
> It would make life easier (and be more normal practice) to split this up
> by driver/subsystem and send a bunch of separate patches to the relevant
> maintainers, this makes it much easier to review and handle things.

Okay, I'll split this patch and send them separately. I'm not going to mark
the new patches as v2 to save trouble.

> 

