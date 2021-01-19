Return-Path: <SRS0=kxA9=GW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E6AC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 11:37:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7082D20867
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 11:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7082D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D94D41893;
	Tue, 19 Jan 2021 12:36:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D94D41893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611056243;
	bh=4O2dR+VqhTM5uwSsNV4W6rOhFtOiThG/ubTH0fa6yC4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fFFlZ3OMZ3zVx7paelxPrwaI+tPQb5GPoFTiVbLx+Xuts1+T05EU77C0Dv+nvquKd
	 NWuXZoQgirAk/THCs1sjOYO+RaS0GkaXbuumwOUqGTpVqTC/wsv+mMBdpoaRNURPkO
	 hFEGnyWSaaDVUxSe1EMIjnurXD+eSMhwN5HhL/38=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5548F80272;
	Tue, 19 Jan 2021 12:36:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0DF85F80273; Tue, 19 Jan 2021 12:36:20 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF95CF80117
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2021 12:36:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF95CF80117
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: eballetbo) with ESMTPSA id 078FC1F44E05
Subject: Re: [PATCH v7 2/2] ASoC: cros_ec_codec: Reset I2S RX when probing
To: Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
References: <20210115075301.47995-1-yuhsuan@chromium.org>
 <20210115075301.47995-2-yuhsuan@chromium.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <faa8e91f-441d-2a43-c7db-5d6d27686c15@collabora.com>
Date: Tue, 19 Jan 2021 12:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115075301.47995-2-yuhsuan@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Prashant Malani <pmalani@chromium.org>, Pi-Hsun Shih <pihsun@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

Thanks to apply the nit, but you can maintain the reviewed tag.

On 15/1/21 8:53, Yu-Hsuan Hsu wrote:
> It is not guaranteed that I2S RX is disabled when the kernel booting.
> For example, if the kernel crashes while it is enabled, it will keep
> enabled until the next time EC reboots. Reset I2S RX when probing to
> fix this issue.
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> ---
> Updated the info message.
> 
>  sound/soc/codecs/cros_ec_codec.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index f33a2a9654e7..c4772f82485a 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -1011,6 +1011,18 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
>  	}
>  	priv->ec_capabilities = r.capabilities;
>  
> +	/* Reset EC codec i2s rx. */
> +	p.cmd = EC_CODEC_I2S_RX_RESET;
> +	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
> +				   (uint8_t *)&p, sizeof(p), NULL, 0);
> +	if (ret == -ENOPROTOOPT) {
> +		dev_info(dev,
> +			 "Missing reset command. Please update EC firmware.\n");
> +	} else if (ret) {
> +		dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
> +		return ret;
> +	}
> +
>  	platform_set_drvdata(pdev, priv);
>  
>  	ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
> 
