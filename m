Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B74C433E5
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:58:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89570207BB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jxMQ/T68";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mL54vk1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89570207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10759839;
	Wed, 22 Jul 2020 16:57:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10759839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595429897;
	bh=Mpnb2N4+HV6m+Dhnk4tyypBJHBlOxDYNOk8OBQt9L5s=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jxMQ/T6811voBZAerk0qGJLBOENEX9lkpIvdL9F1GvarJmESx4A58rAEczt61ZBxg
	 QKpphlNIIE3GC2K1r8BHNCFaxUCaDwVpUL4VR35XmhHwZAU58yP9jp0j09GQ/3knSo
	 +zUDn5dMlHBYfMVv0+BBS0u+64IByeF7EQ8S1ogY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D593F80141;
	Wed, 22 Jul 2020 16:57:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2309CF8014C; Wed, 22 Jul 2020 16:57:25 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DE6DF800CE
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 16:57:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DE6DF800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mL54vk1c"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06MEvBpk004910;
 Wed, 22 Jul 2020 09:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1595429831;
 bh=4Uf4TRn5vUb8L0d8FDIOQK0Qy4pBZfSImAAgzuqEAOI=;
 h=Subject:To:References:From:Date:In-Reply-To;
 b=mL54vk1csAw2axZ2LgbskInwLF51fwF3sqNSAbtJmQPnQ+NO8K+aigcaM2ZgLIiWd
 jyRAPQKq+uyfL2ZoIGSZMXzlI7a8uCGPISwHFS4WI45IZLPPYrYlnqHlr4dUlB640r
 w2gFe2LMSAvbbRB84nDLNHy7f70k5ZbcXbpBEWrU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06MEv67o090277
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Jul 2020 09:57:11 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 09:57:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 09:57:06 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MEv4fq071548;
 Wed, 22 Jul 2020 09:57:05 -0500
Subject: Re: [PATCH -next] ASoC: ti: fix SND_SOC_J721E_EVM warnings & errors
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
 moderated for non-subscribers <alsa-devel@alsa-project.org>, Mark Brown
 <broonie@kernel.org>
References: <e74c690c-c7f8-fd42-e461-4f33571df4ef@infradead.org>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <8a5baa38-e5a9-ab82-d186-9939733e4d7e@ti.com>
Date: Wed, 22 Jul 2020 17:58:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e74c690c-c7f8-fd42-e461-4f33571df4ef@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Randy,

On 20/07/2020 21.32, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> SND_SOC_J721E_EVM should not select SND_SOC_PCM3168A_I2C when I2C
> is not enabled. That causes build errors, so make this driver's
> symbol depend on I2C.

Thank you for the fix!

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> WARNING: unmet direct dependencies detected for SND_SOC_PCM3168A_I2C
>   Depends on [n]: SOUND [=3Dm] && !UML && SND [=3Dm] && SND_SOC [=3Dm] =
&& I2C [=3Dn]
>   Selected by [m]:
>   - SND_SOC_J721E_EVM [=3Dm] && SOUND [=3Dm] && !UML && SND [=3Dm] && S=
ND_SOC [=3Dm] && (DMA_OMAP [=3Dy] || TI_EDMA [=3Dm] || TI_K3_UDMA [=3Dn] =
|| COMPILE_TEST [=3Dy]) && (ARCH_K3_J721E_SOC [=3Dn] || COMPILE_TEST [=3D=
y])
>=20
> ../sound/soc/codecs/pcm3168a-i2c.c:59:1: warning: data definition has n=
o type or storage class
>  module_i2c_driver(pcm3168a_i2c_driver);
>  ^~~~~~~~~~~~~~~~~
> ../sound/soc/codecs/pcm3168a-i2c.c:59:1: error: type defaults to =E2=80=
=98int=E2=80=99 in declaration of =E2=80=98module_i2c_driver=E2=80=99 [-W=
error=3Dimplicit-int]
> ../sound/soc/codecs/pcm3168a-i2c.c:59:1: warning: parameter names (with=
out types) in function declaration
> ../sound/soc/codecs/pcm3168a-i2c.c:49:26: warning: =E2=80=98pcm3168a_i2=
c_driver=E2=80=99 defined but not used [-Wunused-variable]
>  static struct i2c_driver pcm3168a_i2c_driver =3D {
>                           ^~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
>=20
>=20
> Fixes: 6748d0559059 ("ASoC: ti: Add custom machine driver for j721e EVM=
 (CPB and IVI)")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/ti/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>=20
> --- linux-next-20200720.orig/sound/soc/ti/Kconfig
> +++ linux-next-20200720/sound/soc/ti/Kconfig
> @@ -222,6 +222,7 @@ config SND_SOC_DM365_VOICE_CODEC_MODULE
>  config SND_SOC_J721E_EVM
>  	tristate "SoC Audio support for j721e EVM"
>  	depends on ARCH_K3_J721E_SOC || COMPILE_TEST
> +	depends on I2C
>  	select SND_SOC_PCM3168A_I2C
>  	select SND_SOC_DAVINCI_MCASP
>  	help
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

