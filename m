Return-Path: <SRS0=ED1W=OM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D072BC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Sep 2021 10:08:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3779B60F21
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Sep 2021 10:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3779B60F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51236827;
	Wed, 22 Sep 2021 12:07:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51236827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632305300;
	bh=k8TNVw1Z0Au0HtmPHWqLFtOFmWpeH4xBXlXhGEs8nk4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VXzQEc1ATot77bcGUhwDDtZ/SHNI/gbAg179eLZSdVS1NYUTgGNksxfVw/euDhh2d
	 YLd4mIm5FHEDvIS+e8thYdhjFK8uV3gAO05inefsaMaNsamQSiokFl6z3MPEF1qnhF
	 CYmSXMqiOem53656liV+GSMGA+fEQr07b44p27vA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1C87F8013F;
	Wed, 22 Sep 2021 12:07:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D0EFF8025D; Wed, 22 Sep 2021 12:07:26 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8FACF8013F
 for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2021 12:07:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8FACF8013F
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: eballetbo) with ESMTPSA id 8E5C91F437C3
Subject: Re: [PATCH] ASoC: cros_ec_codec: Use modern ASoC DAI format
 terminology
To: Mark Brown <broonie@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Benson Leung <bleung@chromium.org>
References: <20210920170414.17903-1-broonie@kernel.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <24f7ba24-3ff8-cdb1-0f69-ac601bb64540@collabora.com>
Date: Wed, 22 Sep 2021 12:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210920170414.17903-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

Hi Mark,

On 20/9/21 19:04, Mark Brown wrote:
> As part of moving to remove the old style defines for the bus clocks update
> the cros_ec_codec driver to use more modern terminology for clocking.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Looked at other patches that do the same thing and comparing with those, the
change looks good to me. Also, doesn't seem to affect the device that uses this
codec so.

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  sound/soc/codecs/cros_ec_codec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index a201d652aca2..9b92e1a0d1a3 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -283,8 +283,8 @@ static int i2s_rx_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  	struct ec_param_ec_codec_i2s_rx p;
>  	enum ec_codec_i2s_rx_daifmt daifmt;
>  
> -	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> -	case SND_SOC_DAIFMT_CBS_CFS:
> +	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
> +	case SND_SOC_DAIFMT_CBC_CFC:
>  		break;
>  	default:
>  		return -EINVAL;
> 
