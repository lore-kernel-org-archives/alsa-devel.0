Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF6BC2B9F7
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 00:08:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE4B60FE6
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 00:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE4B60FE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41E2C1675;
	Tue, 25 May 2021 02:07:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41E2C1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621901300;
	bh=iR+AsKcpPhVydgab8OmjxIvIL50F9s+R6ZHj+zASB00=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N2Fh6ogfqbMvbLUTjRJkyrV4alDpYxuHyN48Y6x9OuoPOuGq14RcAFvV28nAQY4RE
	 Tn/LtMunZWNQAo7ajv8lhiQGoCJq9FmUnnKJfc9PBW6PDHz2a0NgdyEAjJsd9U2Nmc
	 UF2i4mQT3o4wn5l1FgbxgNrn1fkghcxqWfNnVBpw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9FDFF8021D;
	Tue, 25 May 2021 02:07:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CBF9F8022D; Tue, 25 May 2021 02:07:28 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0054.hostedemail.com
 [216.40.44.54])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AFC6F800B8
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 02:07:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AFC6F800B8
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5A1E9100E7B44;
 Tue, 25 May 2021 00:07:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf04.hostedemail.com (Postfix) with ESMTPA id 62630D1514; 
 Tue, 25 May 2021 00:07:18 +0000 (UTC)
Message-ID: <9f21272719a3983bda647147e8460615159875b1.camel@perches.com>
Subject: Re: [PATCH] ASoC: meson: use dev_err_probe
From: Joe Perches <joe@perches.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Mark Brown <broonie@kernel.org>
Date: Mon, 24 May 2021 17:07:17 -0700
In-Reply-To: <20210524165136.400702-1-jbrunet@baylibre.com>
References: <20210524165136.400702-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: k7h5guxk81qrouyfdntbrc3x63gk54mj
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 62630D1514
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19pOUzXC5Hogvmi/j0xkmzd9aHSBMxFLPU=
X-HE-Tag: 1621901238-781495
Cc: linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Mon, 2021-05-24 at 18:51 +0200, Jerome Brunet wrote:
> Use dev_err_probe() helper function to handle probe deferral.
> It removes the open coded test for -EPROBE_DEFER but more importantly, it
> sets the deferral reason in debugfs which is great for debugging.

trivia:

It seems that the use of %ld, PTR_ERR(<foo>) isn't particularly
useful now as dev_err_probe already uses %pe to emit descriptive
error messages.


> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
[]
> @@ -352,17 +352,16 @@ int axg_fifo_probe(struct platform_device *pdev)
>  
> 
>  	fifo->pclk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(fifo->pclk)) {
> -		if (PTR_ERR(fifo->pclk) != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get pclk: %ld\n",
> -				PTR_ERR(fifo->pclk));
> +		dev_err_probe(dev, PTR_ERR(fifo->pclk),
> +			      "failed to get pclk: %ld\n", PTR_ERR(fifo->pclk));

here.

>  		return PTR_ERR(fifo->pclk);
>  	}
>  
> 
>  	fifo->arb = devm_reset_control_get_exclusive(dev, NULL);
>  	if (IS_ERR(fifo->arb)) {
> -		if (PTR_ERR(fifo->arb) != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get arb reset: %ld\n",
> -				PTR_ERR(fifo->arb));
> +		dev_err_probe(dev, PTR_ERR(fifo->arb),
> +			      "failed to get arb reset: %ld\n",
> +			      PTR_ERR(fifo->arb));

etc...


