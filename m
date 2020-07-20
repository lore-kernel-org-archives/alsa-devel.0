Return-Path: <SRS0=gPEE=A7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A4AC433F2
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:33:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4FE208E4
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="brOioLIv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sdanfMuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4FE208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F966825;
	Mon, 20 Jul 2020 20:32:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F966825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595270010;
	bh=t4+05mibEZ+aDp0FtlRv6Y3GC0ImLq2uAQxAErCD2ds=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=brOioLIv6TD/ft4lROLyLXX+toDVrkEItwrDmHMU4QIzW/2xFBLwcVJcyHoqAYZAL
	 ORUYxz8v2YEIOFfW+gWlNcniEZuuatvhi8Y8DvnSxguS8+15QtiB2KLoubsTDygAIA
	 n+E/SgMtxJEDan/zceryCONc68FRlWu5Oa4WjKTE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0E47F800E0;
	Mon, 20 Jul 2020 20:32:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3A91F800F5; Mon, 20 Jul 2020 20:32:37 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB65FF800C1
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 20:32:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB65FF800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="sdanfMuc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=HoGrcROsDuFcW0fQ11PlXtvMHOgYzwDunvP1JOcV8PQ=; b=sdanfMuc5tnQdlqxthXRAubDTz
 CT3zBJb9O2ncHQkJuZ7vxecYPcwykfj/WhR4xv8t/KROkeBlW50LHYPJyNAmhMwkNeJsuxeaZ0Hsk
 Pbw7SFGXwEhVevtHGto8/x8sGc1kM2Fs59Bw31MAI9sBaP17Ge+Gc1dzOdsPefsLTtIpJt1VBYQC5
 i8JC7vclNSpf0Dld0TjlY9fYC31qRDUks2NvHE3FJYfP5bZAMowYqgOtJMl5TKUeFhcaNwGfQ6ooi
 jKRKII8xPxzCM7MM6q8h0UnSzCf7F/Ud5sGje9am7CLQEIC9PX4YRNwskGEcw04gKbb86bKhw3DgR
 OiW/Q/Fw==;
Received: from [2601:1c0:6280:3f0::19c2]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxaaO-0001Ij-8i; Mon, 20 Jul 2020 18:32:24 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] ASoC: ti: fix SND_SOC_J721E_EVM warnings & errors
Message-ID: <e74c690c-c7f8-fd42-e461-4f33571df4ef@infradead.org>
Date: Mon, 20 Jul 2020 11:32:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

From: Randy Dunlap <rdunlap@infradead.org>

SND_SOC_J721E_EVM should not select SND_SOC_PCM3168A_I2C when I2C
is not enabled. That causes build errors, so make this driver's
symbol depend on I2C.

WARNING: unmet direct dependencies detected for SND_SOC_PCM3168A_I2C
  Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && I2C [=n]
  Selected by [m]:
  - SND_SOC_J721E_EVM [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && (DMA_OMAP [=y] || TI_EDMA [=m] || TI_K3_UDMA [=n] || COMPILE_TEST [=y]) && (ARCH_K3_J721E_SOC [=n] || COMPILE_TEST [=y])

../sound/soc/codecs/pcm3168a-i2c.c:59:1: warning: data definition has no type or storage class
 module_i2c_driver(pcm3168a_i2c_driver);
 ^~~~~~~~~~~~~~~~~
../sound/soc/codecs/pcm3168a-i2c.c:59:1: error: type defaults to ‘int’ in declaration of ‘module_i2c_driver’ [-Werror=implicit-int]
../sound/soc/codecs/pcm3168a-i2c.c:59:1: warning: parameter names (without types) in function declaration
../sound/soc/codecs/pcm3168a-i2c.c:49:26: warning: ‘pcm3168a_i2c_driver’ defined but not used [-Wunused-variable]
 static struct i2c_driver pcm3168a_i2c_driver = {
                          ^~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors


Fixes: 6748d0559059 ("ASoC: ti: Add custom machine driver for j721e EVM (CPB and IVI)")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200720.orig/sound/soc/ti/Kconfig
+++ linux-next-20200720/sound/soc/ti/Kconfig
@@ -222,6 +222,7 @@ config SND_SOC_DM365_VOICE_CODEC_MODULE
 config SND_SOC_J721E_EVM
 	tristate "SoC Audio support for j721e EVM"
 	depends on ARCH_K3_J721E_SOC || COMPILE_TEST
+	depends on I2C
 	select SND_SOC_PCM3168A_I2C
 	select SND_SOC_DAVINCI_MCASP
 	help

