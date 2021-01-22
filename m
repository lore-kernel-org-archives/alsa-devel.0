Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDC9C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 08:00:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A528230FC
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 08:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A528230FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blennerhassett.gen.nz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 129EC86E;
	Fri, 22 Jan 2021 08:59:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 129EC86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611302420;
	bh=ExYVlCYym9VdtK2jMGUb2Bu/BuAHwU+1trdkeV1mNMQ=;
	h=To:References:From:Subject:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mE8KnE5UeXeTR8K9Dkshw6Q/BJeBN35fEKJYIES0rHtu48vU0Vt0VSLpFiYUJDRgI
	 D420Iay7Vv4Xe0a8uU46BKIx9VTD+bicF6ZpnYDMIpFQ7ILnrLGEqpqMbf3h99nISV
	 KQEZy6UV/C22ipvq+vG756CbnPnRyjMBulfBAno8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2379F80164;
	Fri, 22 Jan 2021 08:58:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97CE3F8015B; Fri, 22 Jan 2021 08:58:06 +0100 (CET)
Received: from omr.mail.isx.net.nz (omr.mail.isx.net.nz [111.65.230.130])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCDFBF8015B
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 08:58:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCDFBF8015B
Received: from [10.36.0.146] (unknown [203.173.181.15])
 (Authenticated sender: eliot@blennerhassett.gen.nz)
 by omr.mail.isx.net.nz (Postfix) with ESMTPA id 94484AE6A79;
 Fri, 22 Jan 2021 20:57:53 +1300 (NZDT)
To: Mark Brown <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <935820c1-0c96-6c85-26e7-ce0b741737dc@blennerhassett.gen.nz>
 <20210120190759.GH6794@sirena.org.uk>
From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: ASoC: ak4458 reset polarity
Message-ID: <84e36db4-b78d-de1b-3575-62b19035ea43@blennerhassett.gen.nz>
Date: Fri, 22 Jan 2021 20:57:53 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120190759.GH6794@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Cc: kuninori.morimoto.gx@renesas.com, Xiubo Li <Xiubo.Lee@gmail.com>,
 daniel.baluta@nxp.com, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Delio Brignoli <dbrignoli@audioscience.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>
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

On 21/01/21 8:07 am, Mark Brown wrote:
> On Wed, Jan 20, 2021 at 12:41:18PM +1300, Eliot Blennerhassett wrote:
> 
> It would be a bit easier to have one discussion per mail 

taking up the topic of ak4458 reset polarity alone

ak4458.txt documents:

Optional properties:
- reset-gpios: A GPIO specifier for the power down & reset pin
Example
	reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>

Existing code in ak4458.c:
static void ak4458_power_off(struct ak4458_priv *ak4458)
 {
 	if (ak4458->reset_gpiod) {
		gpiod_set_value_cansleep(ak4458->reset_gpiod, 0);
		usleep_range(1000, 2000);
	}
}

I suspect the value 0 represents the raw value for an active-low gpio,
but this is wrong when used with gpiod_set_value_cansleep() function
whose doc says "Set the logical value of the GPIO, i.e. taking its
ACTIVE_LOW status into account"

Setting the value to 0 makes the GPIO *inactive* i.e. high if it is
specified in the DT as ACTIVE_LOW.  This is the wrong way round for the
power_off/on functions.

Because the DT property is optional, perhaps nobody has tried to use it
until now?

Patch to follow

--
Eliot

