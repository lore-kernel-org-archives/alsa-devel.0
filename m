Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A558C433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:48:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087162080C
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bx2UiJFq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX8gP0EP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087162080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 829761691;
	Thu,  3 Sep 2020 06:47:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 829761691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599108526;
	bh=sgpr2jECLka0Lxt4kFjTIGwqVp2ceTlDsSvGmXtkYcU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bx2UiJFqoyoBYvbyDBtgjoQHbniANcP4KtDogfi3DMP9ee2MdwZc0xTmXytnvPtQo
	 tE9C9i/F+F4ZZ5loJlEejiiLxVfhtFkgbTKMLjFdUZrLfS9mTAvepnyHM0Dv/GINa8
	 oXOxaCBmHkQbohB5lLWIV36hca3V7EAyNWhutAZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21FE4F8020D;
	Thu,  3 Sep 2020 06:47:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DE4DF80217; Thu,  3 Sep 2020 06:47:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56BF5F800BA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 06:47:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56BF5F800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AX8gP0EP"
Received: from localhost (unknown [122.171.179.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 47FB5207EA;
 Thu,  3 Sep 2020 04:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599108460;
 bh=sgpr2jECLka0Lxt4kFjTIGwqVp2ceTlDsSvGmXtkYcU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AX8gP0EPN+cNuohfC7yIwldF2cSl0aW7MF2gq54Sv074u4DZ0YTZPsxVTsClkJTyB
 7VJlEzKiXdKantxDXsA/a1Vc+yPqDIw6LtHqUK/84H/Qnho1BHb6AfvD2qjO5sDI7/
 mnAstTIzalgPUDIIH19eWgL7Ug+IBl5+Vp2NLn60=
Date: Thu, 3 Sep 2020 10:17:35 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 07/18] ALSA: compress_offload: remove redundant
 initialization
Message-ID: <20200903044735.GC2639@vkoul-mobl>
References: <20200902212133.30964-1-pierre-louis.bossart@linux.intel.com>
 <20200902212133.30964-8-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902212133.30964-8-pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
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

On 02-09-20, 16:21, Pierre-Louis Bossart wrote:
> Fix cppcheck warning:
> 
> sound/core/compress_offload.c:1044:6: style: Redundant initialization
> for 'ret'. The initialized value is overwritten before it is
> read. [redundantInitialization]
> 
>  ret = snd_register_device(SNDRV_DEVICE_TYPE_COMPRESS,
>      ^
> sound/core/compress_offload.c:1034:10: note: ret is initialized
>  int ret = -EINVAL;
>          ^
> sound/core/compress_offload.c:1044:6: note: ret is overwritten
>  ret = snd_register_device(SNDRV_DEVICE_TYPE_COMPRESS,
>      ^
> 

Acked-By: Vinod Koul <vkoul@kernel.org>

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/core/compress_offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index e3eb314acb10..c1fec932c49d 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -1032,7 +1032,7 @@ static const struct file_operations snd_compr_file_ops = {
>  
>  static int snd_compress_dev_register(struct snd_device *device)
>  {
> -	int ret = -EINVAL;
> +	int ret;
>  	struct snd_compr *compr;
>  
>  	if (snd_BUG_ON(!device || !device->device_data))
> -- 
> 2.25.1

-- 
~Vinod
