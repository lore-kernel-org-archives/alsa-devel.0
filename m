Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC32C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:31:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E51921A49
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z/YUK9SY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E51921A49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83D42846;
	Tue, 12 Nov 2019 20:30:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83D42846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573587061;
	bh=wgi6tNi3BJlC4kA+YDhGAJ/2ZOdcnliuq6dvD87H/S4=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z/YUK9SYL0fvDgx318VUpkfJ/IINlPhI7qjtoNoZJDl0cORf0TQCbhMcr8SJWmNqP
	 FqO97+R8gpOKnoF7EfN7sK2iVP+pL2MstDSnKjxcRpXzMo4o9rxI3tkJPHv82Ap1ja
	 djg8Mxa0Faxrejyk6zL+LEwsR0apFCfdVknZuR14=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F31D6F80483;
	Tue, 12 Nov 2019 20:30:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B38AF8048F; Tue, 12 Nov 2019 20:30:07 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0229.hostedemail.com
 [216.40.44.229])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C495EF8044C
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 20:30:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C495EF8044C
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9E42318030167;
 Tue, 12 Nov 2019 19:29:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: women58_9143341421351
X-Filterd-Recvd-Size: 2254
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf18.hostedemail.com (Postfix) with ESMTPA;
 Tue, 12 Nov 2019 19:29:58 +0000 (UTC)
Message-ID: <dfb2c158308e0e9cb790ad3c17eb2563ac192f2b.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Colin King <colin.king@canonical.com>, Liam Girdwood
 <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 alsa-devel@alsa-project.org
Date: Tue, 12 Nov 2019 11:29:41 -0800
In-Reply-To: <20191112190218.282337-1-colin.king@canonical.com>
References: <20191112190218.282337-1-colin.king@canonical.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH][next] ASoC: tas2770: clean up an
	indentation issue
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, 2019-11-12 at 19:02 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a block that is indented too deeply, remove
> the extraneous tabs.
[]
> diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
[]
> @@ -761,12 +761,12 @@ static int tas2770_i2c_probe(struct i2c_client *client,
>  	tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
>  							  "reset-gpio",
>  						      GPIOD_OUT_HIGH);
> -		if (IS_ERR(tas2770->reset_gpio)) {
> -			if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
> -				tas2770->reset_gpio = NULL;
> -				return -EPROBE_DEFER;
> -			}
> +	if (IS_ERR(tas2770->reset_gpio)) {
> +		if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
> +			tas2770->reset_gpio = NULL;
> +			return -EPROBE_DEFER;
>  		}
> +	}

This could remove the IS_ERR and and also remove another indentation level

	if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
		tas2770->reset_gpio = NULL;
		return -EPROBE_DEFER;
	}

or if _really_ desired, (but it seems not really necessary)
but this form is used in a few other sound drivers:

	if (IS_ERR(tas2770->reset_gpio) &&
	    PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
		tas2770->reset_gpio = NULL;
		return -EPROBE_DEFER;
	}

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
