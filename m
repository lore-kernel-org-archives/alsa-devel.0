Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52E6C433FE
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Oct 2022 19:45:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4FBC4963E;
	Sat, 22 Oct 2022 21:44:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4FBC4963E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666467948;
	bh=jxmsAfb05o/VcKF45qOHR8nta+ZRNYG7qEk0LR2T/bU=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MciXE2mg12GiarflvOu8U8uYdWBf3kFHU/wVJFqipQ5ss4H12q+WLhb4OshZ1WRKP
	 ecQaqfOsK4ij7XMAmnq9gxKt3uw+xsJXSRtaEZdY/19rGENqoLGH3xCGDqogvcvCye
	 nNR9LOlWzUzi0Nth7NXEj17h+iHBdtxhtfNrwCO4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02CF6F8012A;
	Sat, 22 Oct 2022 21:44:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C1A3F80246; Sat, 22 Oct 2022 21:44:56 +0200 (CEST)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01532F80134
 for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2022 21:44:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01532F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net
 header.b="3wTQBitG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
 s=mail; t=1666467891; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UKG8yyO0OUzw5i6dz7sE84w3Ric4+ES8JoUPSd0r/9E=;
 b=3wTQBitGlBfE0dZ6dg2p95KRlpS3hLVFIcvp3md/n8YQzBOUAMeyw8cI1VUJCpd0XnPIbg
 BDkyIAbiYwiIR1mdONGl+7F+S1jkGyQsmQCexhnFOC2PAFgjonBJc6rummtvXKDJ86aIK/
 4V1y/Ohb3LUHZcWj5BoRu8uXMyyYpMw=
Date: Sat, 22 Oct 2022 20:44:40 +0100
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 0/9] ASoC: cleanups and improvements for jz4740-i2s
To: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Message-Id: <GU66KR.0W1UC5ES8HSL1@crapouillou.net>
In-Reply-To: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
References: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org, zhouyu@wanyeetech.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, tiwai@suse.com,
 broonie@kernel.org
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

Hi Aidan,

Le sam. 22 oct. 2022 =E0 20:12:59 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> This series is a preparatory cleanup of the jz4740-i2s driver before
> adding support for a new SoC. The two improvements are lifting
> unnecessary restrictions on sample rates and formats -- the existing
> ones appear to be derived from the limitations of the JZ4740's=20
> internal
> codec and don't reflect the actual capabilities of the I2S controller.
>=20
> I'm unable to test the series on any JZ47xx SoCs, but I have tested
> on an X1000 (which is the SoC I'll be adding in a followup series).
>=20
> Changes in v5:
>=20
> * Drop 'mem' resource removal patch already upstream.
> * Update FIFO flush bits fix to address Paul's review comments.
> * Drop PLL clock name patch, that needs a different approach.
>=20
> Link for v4: URLHERE

Forgot something? ;)

-Paul

>=20
> Aidan MacDonald (9):
>   ASoC: jz4740-i2s: Handle independent FIFO flush bits
>   ASoC: jz4740-i2s: Convert to regmap API
>   ASoC: jz4740-i2s: Simplify using regmap fields
>   ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
>   ASoC: jz4740-i2s: Align macro values and sort includes
>   ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
>   ASoC: jz4740-i2s: Support continuous sample rate
>   ASoC: jz4740-i2s: Move component functions near the component driver
>   ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops
>=20
>  sound/soc/jz4740/Kconfig      |   1 +
>  sound/soc/jz4740/jz4740-i2s.c | 455=20
> ++++++++++++++++++----------------
>  2 files changed, 243 insertions(+), 213 deletions(-)
>=20
> --
> 2.38.1
>=20


