Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98224C54E94
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Jan 2023 10:00:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE17CE7B;
	Thu, 26 Jan 2023 10:59:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE17CE7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674727211;
	bh=7thbQl0ZTTrxjF0FVWIp8TMzQKlW6g1JE7yOyOV3ccY=;
	h=From:To:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kOjx2iQtDBrWRCi3IKOUao4c7wnaiC9dhTnmkEDwV5XM2R/amuGfpsy2UOac0Y9yH
	 4sdp/7iZmpA6IzeOd2nvM3fWKLKhTpXKnyeLhca9eQYrwN0IEPMuWry/QVvJMOz5iH
	 s4zD1N/CP12aYmco2nPI71Mzlc5MLntyz7X49Phc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4433CF8025D;
	Thu, 26 Jan 2023 10:59:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF8D4F8027D; Thu, 26 Jan 2023 10:59:17 +0100 (CET)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C13EDF8016E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2023 10:59:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C13EDF8016E
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ckTJ2dwo
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2blG3YNkz4xyF;
 Thu, 26 Jan 2023 20:59:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1674727148;
 bh=5hmT+pUqAPEqD7swMk5Fu2h+tSg6SpqGmlcnSglNmzo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ckTJ2dwo54F+GOKoH7L3XD0wHuMyujSAvyTfKxflfZ0bBfLN9sES4voDIIWq2i7D+
 ZZTQAj4IsSE7l21Iyr8XlAgPPDdZMuZ/W/T1hrjGR+s8PxsfkJvoIDwatFnpTWxOTl
 1MMDjLOGYwHxjc7SSiFbdVUlLIM6TfTcX9uoyLfsPlHD4zoHoICpmoQkotvADZWRvO
 mv+36cit9j285RNnxVXQQZMWThAJJgtFoXLOYaZEBKFCEQW7Nuj2XVmj+ol3uHxfK8
 L3nTin5TCiArcnMAtBG9ylOCP4TjzJe0iggJIpTlKIP/8PafajDAtPiP+NQsYmHfGg
 dKtHzPoOWFWzQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herve Codina <herve.codina@bootlin.com>, Herve Codina
 <herve.codina@bootlin.com>, Li Yang <leoyang.li@nxp.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Qiang
 Zhao <qiang.zhao@nxp.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Nicolin Chen
 <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 04/10] powerpc/8xx: Use a larger CPM1 command check mask
In-Reply-To: <20230126083222.374243-5-herve.codina@bootlin.com>
References: <20230126083222.374243-1-herve.codina@bootlin.com>
 <20230126083222.374243-5-herve.codina@bootlin.com>
Date: Thu, 26 Jan 2023 20:59:03 +1100
Message-ID: <87mt65pqfs.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Herve Codina <herve.codina@bootlin.com> writes:
> The CPM1 command mask is defined for use with the standard
> CPM1 command register as described in the user's manual:
>   0  |1        3|4    7|8   11|12      14| 15|
>   RST|    -     |OPCODE|CH_NUM|     -    |FLG|
>
> In the QMC extension the CPM1 command register is redefined
> (QMC supplement user's manuel) with the following mapping:
>   0  |1        3|4    7|8           13|14| 15|
>   RST|QMC OPCODE|  1110|CHANNEL_NUMBER| -|FLG|
>
> Extend the check command mask in order to support both the
> standard CH_NUM field and the QMC extension CHANNEL_NUMBER
> field.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/platforms/8xx/cpm1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
> index 8ef1f4392086..6b828b9f90d9 100644
> --- a/arch/powerpc/platforms/8xx/cpm1.c
> +++ b/arch/powerpc/platforms/8xx/cpm1.c
> @@ -100,7 +100,7 @@ int cpm_command(u32 command, u8 opcode)
>  	int i, ret;
>  	unsigned long flags;
>  
> -	if (command & 0xffffff0f)
> +	if (command & 0xffffff03)
>  		return -EINVAL;
>  
>  	spin_lock_irqsave(&cmd_lock, flags);
> -- 
> 2.39.0
