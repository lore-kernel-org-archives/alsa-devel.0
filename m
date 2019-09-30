Return-Path: <SRS0=ugne=XZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BABC32792
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:59:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C0C215EA
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BzLsb1Xa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="W5XI/oK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C0C215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92056829;
	Mon, 30 Sep 2019 17:58:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92056829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569859159;
	bh=c09Tj2e1eyUItEHX/HhnmDE2iYC0+hoZXNW7S6WvaKU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BzLsb1Xa5xbaa406A8+z8T6eokBUlDOx7ZrT3gsaEh4GBKT14gWkrT0mKka6qDq1N
	 SUl6BNMnmHa6MQArpTPkLXr2KcaNGDYJoQvO7e7QXYfIwfKRHXzKI3IvEi3/CLruHu
	 8h4kt2YIsKTGJwCoiS7QwPhCZYZ7IjJ3+knG6NV8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A48CF8036E;
	Mon, 30 Sep 2019 17:58:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A51BF80391; Mon, 30 Sep 2019 17:58:27 +0200 (CEST)
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 897BAF800D0
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2019 17:58:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 897BAF800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl
 header.b="W5XI/oK4"
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 46hn7s5yWPz2J;
 Mon, 30 Sep 2019 17:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1569858988; bh=SM910taOzVBeIz8sDiWoqtsSpZFNnnEfHCLXVlJL+OE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W5XI/oK4TO+8usSOpDLLwIUD8EOfNsMD0XE8ds9ESj4IQs+D9zTxF9VT7DVuPZHVl
 9/AEZ4r7OVtdbseLYth+b7RMiIuY4oF0124m2klhObq/VnGS+5a7s4aYffBd2yL0Vb
 kdRZbmtDylWd8qGQpAsWP3LHRweacre6kmH+RX5Pt6+N3noLu+Vxv5Ti+Z0vPoKllq
 SB3g/Dlvj0Hm1X5luO32G8DQcoAGN+pkecnMYSBCY/vEpq+Z/YL7COPcPcBE5+nLW0
 z5Ljz3xu91ZoG3GdWQHa1K5LIdHE9xNwaqmAImLvdCdKAu08yv516uMZdQJxmh2vzb
 sBzrIyWPZ1LmA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date: Mon, 30 Sep 2019 17:58:19 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: YueHaibing <yuehaibing@huawei.com>
Message-ID: <20190930155818.GA32237@qmqm.qmqm.pl>
References: <20190928081641.44232-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190928081641.44232-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
 tiwai@suse.com, broonie@kernel.org, codrin.ciubotariu@microchip.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH -next] ASoC: atmel: Fix build error
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

On Sat, Sep 28, 2019 at 04:16:41PM +0800, YueHaibing wrote:
> when do randbuilding, I got this error:
> 
> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
> (.text+0x12f6): undefined reference to `atmel_pcm_pdc_platform_register'
> 
> This is because SND_ATMEL_SOC_SSC_DMA=y, SND_ATMEL_SOC_SSC=y,
> but SND_ATMEL_SOC_SSC_PDC=m. Fix it bt reintroducing the default Kconfig.

Defaults won't forbid the invalid configuration. Can you try following:

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index f118c229ed82..461f023c5635 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -12,10 +12,12 @@ if SND_ATMEL_SOC
 config SND_ATMEL_SOC_PDC
 	tristate
 	depends on HAS_DMA
+	select SND_ATMEL_SOC_SSC
 
 config SND_ATMEL_SOC_DMA
 	tristate
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select SND_ATMEL_SOC_SSC
 
 config SND_ATMEL_SOC_SSC
 	tristate
@@ -24,7 +26,6 @@ config SND_ATMEL_SOC_SSC_PDC
 	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
 	depends on ATMEL_SSC
 	select SND_ATMEL_SOC_PDC
-	select SND_ATMEL_SOC_SSC
 	help
 	  Say Y or M if you want to add support for Atmel SSC interface
 	  in PDC mode configured using audio-graph-card in device-tree.
@@ -33,7 +34,6 @@ config SND_ATMEL_SOC_SSC_DMA
 	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
 	depends on ATMEL_SSC
 	select SND_ATMEL_SOC_DMA
-	select SND_ATMEL_SOC_SSC
 	help
 	  Say Y or M if you want to add support for Atmel SSC interface
 	  in DMA mode configured using audio-graph-card in device-tree.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
