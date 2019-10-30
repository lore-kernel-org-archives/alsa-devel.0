Return-Path: <SRS0=P70v=YX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295ECCA9EAE
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 00:19:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28ABE2086A
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 00:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lJqcpVZm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6VYehVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ABE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE6922259;
	Wed, 30 Oct 2019 01:18:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE6922259
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572394753;
	bh=YBTFhxyCVoGeSIrVCSMXdjW0YoWIDbqKeAKdIpEjx60=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lJqcpVZm32FOyQVwBsVLAa7YtFnyjPn12LIXZHuZjZUlhNEAngqILGis9Sn4QvE2q
	 RcsQ5C0sExqQhbFuYpfyAmrsD2vDdZD4maokmJ9VPkVAdiEPaagKwGnFx+s/vZY8qC
	 RfNb7hQwOxYtcWMJs48i/dk2bOhidV3f7enPa8hI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65E83F8036C;
	Wed, 30 Oct 2019 01:18:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A8CBF80392; Wed, 30 Oct 2019 01:18:20 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B423F800E7
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 01:18:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B423F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="d6VYehVq"
Received: by mail-pg1-x544.google.com with SMTP id r1so204336pgj.12
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 17:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eL9nLhkFV+3fjZqHJucvMS1Z4avpEDieJP4rKaoqZys=;
 b=d6VYehVqNaBLztOnm+3wC0Y2Cp3OWS7oUyfmQU3cWBQlsNiwJyE0ktWOkED3EIadm3
 uheShic0KwVuxyjDgjUuT2kQhhyF5HVGhPA/jqlAJfycoSdfQ8kFbVKWhSCjJSsJoph2
 K4chyo/pgU81+3tgfMlrYy7ZvrwpHGoVJ+Ms8PNRRql6AYczh86QzTYwS4VhzG6IiZKe
 kxjc5ME/pSjJD3+PxHtJk5S/chLaPUZV1MFHhiSTheuPHK+cV/JDhaG4BNUrzgPEqv+o
 VlglM3QqZPomBtVA2mhSoUEdiECMpGQ3hrVRfB7Dk1IWHkZ9xfEnCIr7/jGWAxjXN90p
 GFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eL9nLhkFV+3fjZqHJucvMS1Z4avpEDieJP4rKaoqZys=;
 b=c6z3HVrlI++QrUm6hlzAoQYEpPicZ6i+9Q2O8x3U77g3lTe4i7lg3fXy0ZNnO8q2G8
 BSo43x3EgX6gYTnPGktzv0W5gB3ZZtN6oPQLRdZnF6atUzRfPQ2NYJXG8zspppEnnxH8
 E3i00D6vCOSh88f9XOvj1DqpffSt1ffxZWBnOMgEpBQ5lYN58VYwrJ/sRiztKFRgEL/F
 GZnVnQlRfJCoPZN9zk46RUJBHIkeXOIADsITSfYQg79RhQcmFqwWlwtXaoTr+oWKzNQr
 7befRgM1BDTMoGHXOKF4C0GzxvYBQLdC+OUoQfS+DIqtny3U+yJkOBlfslYP5K0yVz09
 uEZg==
X-Gm-Message-State: APjAAAW8ci1CAUizuGfsWvBQxMb/37K/P4tXdvBveWfFtO0pB2nBjdPg
 uQRYHKtY1I1wRqotfJTDwic=
X-Google-Smtp-Source: APXvYqw0eHqTFbOpxspUUagZHSV8qs2zbtP3YZq4SWaoOEZYjhzimcKl2o0Wtc6rf4wFJf7fMv8AMQ==
X-Received: by 2002:a63:b144:: with SMTP id g4mr12268618pgp.87.1572394694419; 
 Tue, 29 Oct 2019 17:18:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id g17sm334431pgn.37.2019.10.29.17.18.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Oct 2019 17:18:14 -0700 (PDT)
Date: Tue, 29 Oct 2019 17:17:56 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Message-ID: <20191030001756.GA19352@Asurada-Nvidia.nvidia.com>
References: <1572340629-20702-1-git-send-email-shengjiu.wang@nxp.com>
 <1572340629-20702-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572340629-20702-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: fsl_asrc: Add support for imx8qm
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

On Tue, Oct 29, 2019 at 05:17:09PM +0800, Shengjiu Wang wrote:
> There are two asrc module in imx8qm, each module has different
> clock configuration, and the DMA type is EDMA.
> 
> So in this patch, we define the new clocks, refine the clock map,
> and include struct fsl_asrc_soc_data for different soc usage.
> 
> The EDMA channel is fixed with each dma request, one dma request
> corresponding to one dma channel. So we need to request dma
> channel with dma request of asrc module.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c     | 91 +++++++++++++++++++++++++++++-------
>  sound/soc/fsl/fsl_asrc.h     | 65 +++++++++++++++++++++++++-
>  sound/soc/fsl/fsl_asrc_dma.c | 39 ++++++++++++----
>  3 files changed, 167 insertions(+), 28 deletions(-)

> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index d6146de9acd2..dbb07a486504 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -199,19 +199,40 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
>  
>  	/* Get DMA request of Back-End */
>  	tmp_chan = dma_request_slave_channel(dev_be, tx ? "tx" : "rx");
> -	tmp_data = tmp_chan->private;
> -	pair->dma_data.dma_request = tmp_data->dma_request;
> -	dma_release_channel(tmp_chan);
> +	/* tmp_chan may be NULL for it is already allocated by Back-End */
> +	if (tmp_chan) {
> +		tmp_data = tmp_chan->private;
> +		if (tmp_data)
> +			pair->dma_data.dma_request = tmp_data->dma_request;

If this patch is supposed to add a !tmp_chan case for EDMA, we
probably shouldn't mute the !tmp_data case because dma_request
will be NULL, although the code previously didn't have a check
either. I mean we might need to error-out for !tmp_chan. Or...
is this intentional?

> +		dma_release_channel(tmp_chan);
> +	}
>  
>  	/* Get DMA request of Front-End */
>  	tmp_chan = fsl_asrc_get_dma_channel(pair, dir);
> -	tmp_data = tmp_chan->private;
> -	pair->dma_data.dma_request2 = tmp_data->dma_request;
> -	pair->dma_data.peripheral_type = tmp_data->peripheral_type;
> -	pair->dma_data.priority = tmp_data->priority;
> -	dma_release_channel(tmp_chan);
> +	if (tmp_chan) {
> +		tmp_data = tmp_chan->private;
> +		if (tmp_data) {

Same question here.

> +			pair->dma_data.dma_request2 = tmp_data->dma_request;
> +			pair->dma_data.peripheral_type =
> +				 tmp_data->peripheral_type;
> +			pair->dma_data.priority = tmp_data->priority;
> +		}
> +		dma_release_channel(tmp_chan);
> +	}
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
