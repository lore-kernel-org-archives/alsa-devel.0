Return-Path: <SRS0=GNy4=BY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959A5C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:45:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CACF20791
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VxiC7lw1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="OUIP20W0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CACF20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93C2B84D;
	Fri, 14 Aug 2020 19:44:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93C2B84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597427115;
	bh=o/6z4MGdYi6zoU5b+gNtGDhmBNZpyT2dhtyiP2mz80A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VxiC7lw1zP0YPahcdSbWIwkSbQ4H8QTDa0uVASzpown4DARvm58XKqfigAl5Ri8st
	 z6+sUAb7OdYCMtjOcJM5ZTtthONXd5r9puoOd2SGvJx6X2IlOTVic1BY8/9Qc1BOdn
	 IXpW3t/ddjij3/yNmg9WD7vF0XKCwuNXZ2CBkCLk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EEA5F801DB;
	Fri, 14 Aug 2020 19:44:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35DA5F8022B; Fri, 14 Aug 2020 19:44:23 +0200 (CEST)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE64CF800F4
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2020 19:44:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE64CF800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="OUIP20W0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597427054;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=2Z0U+mcYwggZx3AXbVi+Ktpmy8/fEbXz6BZpJ2spCyk=;
 b=OUIP20W0AuSKw1stcu+cZMVS62+bn1wcRL6KDMTIY4iZdFN/WdQ5/iidPJ19AmYcyt
 PFMnSmmS4SJm+rsIDhHulAJdsPpJZQ3cneLlY+yQmW7SfJZUNP7GbWoTW50ZT6HDYMbL
 GIuWoMNUuwtbi7a7AIThpe3gdllWNKYyp7KzYaYtb1i43lqbyjPDIRaJ/3jBBj6XU6XL
 TuBVIWWFtsdb6ZQMZakj3gXEDGoGykwK8G31xoHa/02FJlP+nIK4giB7w34DeLrSDnNH
 zSmChickkTaLloBoYEcmGrQ3SGCpo1OvoFjA7lfb1irXTJ1X2vN0xuv+pRCT68rS3B4Y
 83zQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6Ic/MbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
 with ESMTPSA id Y0939ew7EHi94lK
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 14 Aug 2020 19:44:09 +0200 (CEST)
Date: Fri, 14 Aug 2020 19:43:32 +0200
From: Stephan Gerhold <stephan@gerhold.net>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: msm8916-wcd-analog: fix register Interrupt offset
Message-ID: <20200814174332.GA314820@gerhold.net>
References: <20200811103452.20448-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811103452.20448-1-srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 linux-kernel@vger.kernel.org, broonie@kernel.org, john.stultz@linaro.org
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

On Tue, Aug 11, 2020 at 11:34:52AM +0100, Srinivas Kandagatla wrote:
> For some reason interrupt set and clear register offsets are
> not set correctly.
> This patch corrects them!
> 
> Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/msm8916-wcd-analog.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> index 4428c62e25cf..3ddd822240e3 100644
> --- a/sound/soc/codecs/msm8916-wcd-analog.c
> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -19,8 +19,8 @@
>  
>  #define CDC_D_REVISION1			(0xf000)
>  #define CDC_D_PERPH_SUBTYPE		(0xf005)
> -#define CDC_D_INT_EN_SET		(0x015)
> -#define CDC_D_INT_EN_CLR		(0x016)
> +#define CDC_D_INT_EN_SET		(0xf015)
> +#define CDC_D_INT_EN_CLR		(0xf016)
>  #define MBHC_SWITCH_INT			BIT(7)
>  #define MBHC_MIC_ELECTRICAL_INS_REM_DET	BIT(6)
>  #define MBHC_BUTTON_PRESS_DET		BIT(5)
> -- 
> 2.21.0
> 

It's surprising that we didn't notice this before. Seems like the HW
has exactly the IRQs we want enabled by default. Everything seems to be
still working fine after this patch, so FWIW:

Tested-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks!
Stephan
