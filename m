Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBB1C77B60
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Apr 2023 07:59:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 104D5104F;
	Wed, 26 Apr 2023 09:58:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 104D5104F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682495941;
	bh=Us147tyN1iniph9oo7W/WP0pHUHdexIGmUvvYEj4faw=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vncrlUVsaVRBKypzXcRsSA9lwABYbVnvu0MR2LJLGOhhKDofieBSRAlpSqOq+VDqk
	 0pvDkGXQP9ZptV3lsK4qH+kGMlp8PDOUQzSFLGOjj1IYhHr4v0aPS7URAHebDo1sqh
	 tOGBvF+mminpII0mU8SuWk8V52z4azklJTKxtpsA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6394F80236;
	Wed, 26 Apr 2023 09:57:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A823F80236; Wed, 26 Apr 2023 09:57:43 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4ABB9F80104
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2023 09:57:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4ABB9F80104
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <pza@pengutronix.de>)
	id 1pra1x-0003Vi-G5; Wed, 26 Apr 2023 09:57:37 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <pza@pengutronix.de>)
	id 1pra1v-0002QB-7Y; Wed, 26 Apr 2023 09:57:35 +0200
Date: Wed, 26 Apr 2023 09:57:35 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Maxim Kochetkov <fido_max@inbox.ru>
Subject: Re: [PATCH] ASoC: dwc: add reset support
Message-ID: <20230426075735.GE4724@pengutronix.de>
References: <20230421193319.14066-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421193319.14066-1-fido_max@inbox.ru>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: LZF6TC6456BH67SYKTSKHLPPZNMM2TLT
X-Message-ID-Hash: LZF6TC6456BH67SYKTSKHLPPZNMM2TLT
X-MailFrom: pza@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org,
 tiwai@suse.com, ckeepax@opensource.cirrus.com,
 u.kleine-koenig@pengutronix.de, nicolas.ferre@microchip.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LZF6TC6456BH67SYKTSKHLPPZNMM2TLT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Maxim,

On Fri, Apr 21, 2023 at 10:33:19PM +0300, Maxim Kochetkov wrote:
> Some SoC may have resets for I2S subsystem. So add optional reset
> deassert at startup.
> 
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
>  sound/soc/dwc/dwc-i2s.c | 9 +++++++++
>  sound/soc/dwc/local.h   | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
> index acdf98b2ee9c..8c8bc7116f86 100644
> --- a/sound/soc/dwc/dwc-i2s.c
> +++ b/sound/soc/dwc/dwc-i2s.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
>  #include <sound/designware_i2s.h>
> @@ -648,6 +649,14 @@ static int dw_i2s_probe(struct platform_device *pdev)
>  	if (IS_ERR(dev->i2s_base))
>  		return PTR_ERR(dev->i2s_base);
>  
> +	dev->reset = devm_reset_control_array_get_optional_shared(&pdev->dev);
> +	if (IS_ERR(dev->reset))
> +		return PTR_ERR(dev->reset);
> +
> +	ret = reset_control_deassert(dev->reset);

Since this is a shared reset control, matching reset_control_assert()
calls are required in the subsequent error paths and in dw_i2s_remove().

regards
Philipp
