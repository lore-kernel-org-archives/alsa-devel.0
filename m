Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8B6C4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:08:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447252072D
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LCnfCM+c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eowGIFSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447252072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0BE717CB;
	Fri, 20 Mar 2020 15:07:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0BE717CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584713327;
	bh=j/n7pjP93b6DmV3JuAK413wi3AHJqJWappdxRiWCZpM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LCnfCM+coxaOaF/bw6CrhFae4XsouoicBjFhlayBBA/K9NE2m8dek15SBYZojES2p
	 mhel0Y6p4qDaHfEwk7EwkileTQENQA9gJjGYMpdp7duaZw6GyVlGe5JysQRaVkYJnQ
	 gBmMtOeFzmMEDVgsE010viy8Df2yJeET7ua/Qy94=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 248F3F800DD;
	Fri, 20 Mar 2020 15:07:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74902F8015B; Fri, 20 Mar 2020 15:07:55 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5735F800DD
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 15:07:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5735F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eowGIFSM"
Received: from localhost (unknown [122.167.82.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E381E2072D;
 Fri, 20 Mar 2020 14:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584713270;
 bh=j/n7pjP93b6DmV3JuAK413wi3AHJqJWappdxRiWCZpM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eowGIFSMJQ73Sa6WG5cyPuEN2lUFgV31Cemctg8SJXWXdIm9oMTklrHSRVa8yHkQq
 gxGFh6ioBkOEkeUHgB1cvwXGUnEjLWoisUytTPwR2e77U1DmwfYWdsdBncC5l4WzpE
 uPyogyP6OfJGR+1naHvwdGiyljVEdIQe+ndqNOh8=
Date: Fri, 20 Mar 2020 19:37:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: qcom: add support for get_sdw_stream()
Message-ID: <20200320140746.GH4885@vkoul-mobl>
References: <20200317092645.5705-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317092645.5705-1-srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
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

On 17-03-20, 09:26, Srinivas Kandagatla wrote:
> Adding support to new get_sdw_stream() that can help machine
> driver to deal with soundwire stream.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 440effed6df6..ba810fbfa3c7 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -588,6 +588,13 @@ static int qcom_swrm_set_sdw_stream(struct snd_soc_dai *dai,
>  	return 0;
>  }
>  
> +static void * qcom_swrm_get_sdw_stream(struct snd_soc_dai *dai, int direction)

This should be void *qcom_swrm_get_sdw_stream. Please run checkpatch
before sending patches.

I have fixed it up while applying

-- 
~Vinod
