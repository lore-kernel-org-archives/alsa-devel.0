Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A92C00A89
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:32:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1BE20731
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MVEX0Myk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kqpV+cPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1BE20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76DA51612;
	Fri, 30 Oct 2020 19:31:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76DA51612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604082761;
	bh=COI5Ul+PT7Qgz8Lf/+yTXSKzHuxodIw5pw1TXclJLrQ=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MVEX0MykXyDlQ+xq/FlwIQYEQ2PBhoSHPCBxnrugK/IemgtCBwF0u+LkJIM4lmyc3
	 myQMAeChpIaBQ/ekowR7jpbJUnWcKg9kDHB4LHXrya+iPz1cJYitDkcoH8iBwH2G2J
	 EUvkZykdOZCSddPZ7WTJ/zJS/BgwHP8WIn7dFato=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98BFBF801D5;
	Fri, 30 Oct 2020 19:31:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02AFCF80212; Fri, 30 Oct 2020 19:31:49 +0100 (CET)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E166F80107
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 19:31:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E166F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="kqpV+cPy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=dBlEcZCPebNOu+qYw1oX1dmdts8xl8lJcDaqBxGZQLY=; b=kqpV+cPyaXd732RDp/GIxdl8Dv
 EyKSbTPSbAfIjpzoTFIhXjKXp45okxkVbjpXAzZ3ecVuOYXtq7j2vFZZ0vw51q7QgUe7+AIxFc9tV
 M5lQS1bNL7gUy46fPcWUPbZwLLQ7GDMyRnY2LSLmOnnMbKhZ/EN+LPJuR7PeuwCPaC5DuQ37emPIY
 JEIL2Oirpr0r93uFGkj7mEQxq2i/0NCZC/j2isyZr7XcDdP5kgpbj+k7rE+2C+VDgFtnmhsCfoD0e
 7txaGX6NlvZnRlO1oaS+gl2r1GTqaFCXmiKx07GKVTMoXjiYGLQvYm/hAgSSQS1avP5ScZbxruRor
 rCc7uTGA==;
Received: from [2601:1c0:6280:3f0::371c]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYZBR-00065V-GM; Fri, 30 Oct 2020 18:31:29 +0000
Subject: Re: [PATCH] ASoC: qcom: MSM8996 depends on COMMON_CLK
From: Randy Dunlap <rdunlap@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>,
 moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>
References: <548bb7f8-672d-3d95-0d78-cef1c9837a42@infradead.org>
Message-ID: <a55d71fd-d5b1-26f9-c3f0-7f2ff91bef07@infradead.org>
Date: Fri, 30 Oct 2020 11:31:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <548bb7f8-672d-3d95-0d78-cef1c9837a42@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

On 10/16/20 10:39 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix a kconfig warning in sound/soc/qcom:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_QDSP6
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y] && COMMON_CLK [=n]
>   Selected by [y]:
>   - SND_SOC_MSM8996 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y]
> 
> This is needed because 'select' does not follow dependency chains.
> 
> Fixes: a6f933f63f2f ("ASoC: qcom: apq8096: Add db820c machine driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> ---
> Found in linux-next but applies to mainline.
> 
>  sound/soc/qcom/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20201016.orig/sound/soc/qcom/Kconfig
> +++ linux-next-20201016/sound/soc/qcom/Kconfig
> @@ -106,6 +106,7 @@ config SND_SOC_QDSP6
>  config SND_SOC_MSM8996
>  	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
>  	depends on QCOM_APR
> +	depends on COMMON_CLK
>  	select SND_SOC_QDSP6
>  	select SND_SOC_QCOM_COMMON
>  	help
> 

Ping. I am still seeing this kconfig warning in linux-next 20201030.

-- 
~Randy

