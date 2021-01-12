Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7796C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 16:35:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4205522EBE
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 16:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4205522EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE5DA16C2;
	Tue, 12 Jan 2021 17:34:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE5DA16C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610469337;
	bh=lY7eXBHI/nZXDdSslPMjuOBDnJz/woPABH878t6XiAI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e3DOlMx02kQHC8rgm8v4C/XN57ADsu/s4JiDJvkohysMEtJBWrf8XADv0wg7NbT/3
	 /RC4Q9NkFTmWFUoE1efQBtg5Oe86u6MNRIADyOeCdBBTMdd8YtDz6aU0VnFhdTQXWV
	 kKi8wFoplo7y/Kt/mtaB93//AG6XtTT0gVjEigy4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29EDBF80249;
	Tue, 12 Jan 2021 17:34:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59B69F8025E; Tue, 12 Jan 2021 17:34:45 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D221F80113
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 17:34:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D221F80113
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: eballetbo) with ESMTPSA id 916941F45495
Subject: Re: [PATCH 2/2] ASoC: cros_ec_codec: Reset I2S RX when probing
To: Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
References: <20210107085942.2891525-1-yuhsuan@chromium.org>
 <20210107085942.2891525-2-yuhsuan@chromium.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e6c33a5f-1765-7cb6-8479-ff049992f2b7@collabora.com>
Date: Tue, 12 Jan 2021 17:34:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107085942.2891525-2-yuhsuan@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Mark Brown <broonie@kernel.org>, Prashant Malani <pmalani@chromium.org>,
 Pi-Hsun Shih <pihsun@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Benson Leung <bleung@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

Hi Yu-Hsuan,

Thank you for the patch.

On 7/1/21 9:59, Yu-Hsuan Hsu wrote:
> It is not guaranteed that I2S RX is disabled when the kernel booting.
> For example, if the kernel crashes while it is enabled, it will keep
> enabled until the next time EC reboots. Reset I2S RX when probing to
> fix this issue.
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

If I am not mistaken this is the four version of this patchset (see [1]). Please
prefix your patches with the proper version and maintain a changelog for them,
otherwise makes difficult to follow all the discussions already done.

[1]
v1: https://lkml.org/lkml/2020/7/8/173
v2: https://mailman.alsa-project.org/pipermail/alsa-devel/2020-July/170933.html
v3:
https://patchwork.kernel.org/project/alsa-devel/patch/20210106050559.1459027-1-yuhsuan@chromium.org/
v4: https://patchwork.kernel.org/project/alsa-devel/list/?series=410441

> ---
>  sound/soc/codecs/cros_ec_codec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index f33a2a9654e7..28b3e2c48c86 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -1011,6 +1011,13 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
>  	}
>  	priv->ec_capabilities = r.capabilities;
>  
> +	/* Reset EC codec i2s rx. */
> +	p.cmd = EC_CODEC_I2S_RX_RESET;
> +	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
> +				   (uint8_t *)&p, sizeof(p), NULL, 0);
> +	if (ret)
> +		dev_warn(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
> +

My comment in the first version is still valid, I guess. This command was
introduced later and with an old firmware I suspect this message will appear on
every boot, right? So, to solve the issue and get rid of this warn you're forced
to upgrade the firmware. Would make sense to handle returned error value to warn
when the firmware needs to be updated and error and break when is really an error?

We have mapped ec error codes to linux error codes. So, it should be possible now.

Thanks,
 Enric

>  	platform_set_drvdata(pdev, priv);
>  
>  	ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
> 
