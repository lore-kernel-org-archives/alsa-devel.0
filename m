Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88847CA9EC2
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:20:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12475218BA
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K3gi4z67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12475218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 912AC20F2;
	Mon, 28 Oct 2019 22:08:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 912AC20F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572296967;
	bh=ZsgxN6f3Ze3kVTrXHahq0MV1IgFjqTF6LZxzsJwDfiM=;
	h=From:To:References:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K3gi4z673rijmblntbiQWBTDZMbhHIgmFwlEg9ankFbaIubhLnd6DhZtX4UHuCPyv
	 k57wa9yBswjo7CqN29hDoplzW9HcMaJLp9TmxsCm9QN4rxarY3zefTHhASE3Jovi/+
	 MXI+Qh33qAbWLZ0rfkseZ0ZAw3fM5PuxXafdS0c0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3506F802BD;
	Mon, 28 Oct 2019 22:08:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CFDBF80361; Mon, 28 Oct 2019 22:08:35 +0100 (CET)
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr
 [80.12.242.131])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7D23F800E7
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 22:08:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7D23F800E7
Received: from belgarion ([90.55.204.252]) by mwinf5d17 with ME
 id K98W2100G5TFNlm0398XDJ; Mon, 28 Oct 2019 22:08:31 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 28 Oct 2019 22:08:31 +0100
X-ME-IP: 90.55.204.252
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Arnd Bergmann <arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-21-arnd@arndb.de>
X-URL: http://belgarath.falguerolles.org/
Date: Mon, 28 Oct 2019 22:08:30 +0100
In-Reply-To: <20191018154201.1276638-21-arnd@arndb.de> (Arnd Bergmann's
 message of "Fri, 18 Oct 2019 17:41:36 +0200")
Message-ID: <87o8y0lgs1.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH 21/46] ARM: pxa: spitz: use gpio
	descriptors for audio
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

Arnd Bergmann <arnd@arndb.de> writes:

> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-pxa/spitz.c                    | 33 ++++++++++-
>  arch/arm/mach-pxa/{include/mach => }/spitz.h |  2 +-
>  arch/arm/mach-pxa/spitz_pm.c                 |  2 +-
>  sound/soc/pxa/spitz.c                        | 58 ++++++++------------
>  4 files changed, 57 insertions(+), 38 deletions(-)
>  rename arch/arm/mach-pxa/{include/mach => }/spitz.h (99%)
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index a4fdc399d152..6028fd83c44d 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -44,7 +44,7 @@
>  #include <linux/platform_data/mmc-pxamci.h>
>  #include <linux/platform_data/usb-ohci-pxa27x.h>
>  #include <linux/platform_data/video-pxafb.h>
> -#include <mach/spitz.h>
> +#include "spitz.h"
>  #include "sharpsl_pm.h"
>  #include <mach/smemc.h>
>  
> @@ -948,11 +948,42 @@ static void __init spitz_i2c_init(void)
>  static inline void spitz_i2c_init(void) {}
>  #endif
>  
> +static struct gpiod_lookup_table spitz_audio_gpio_table = {
> +	.dev_id = "spitz-audio",
> +	.table = {
> +		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_L - SPITZ_SCP_GPIO_BASE,
> +			    "mute-l", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_R - SPITZ_SCP_GPIO_BASE,
> +			    "mute-r", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("sharp-scoop.1", SPITZ_GPIO_MIC_BIAS - SPITZ_SCP2_GPIO_BASE,
> +			    "mic", GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +
> +static struct gpiod_lookup_table akita_audio_gpio_table = {
> +	.dev_id = "spitz-audio",
> +	.table = {
> +		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_L - SPITZ_SCP_GPIO_BASE,
> +			    "mute-l", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_R - SPITZ_SCP_GPIO_BASE,
> +			    "mute-r", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("gpio-pxa", AKITA_GPIO_MIC_BIAS - AKITA_IOEXP_GPIO_BASE,
> +			    "mic", GPIO_ACTIVE_HIGH),
This last one looks a bit dubious, as it looks like a gpio on a gpio expander,
could you cross-check that "gpio-pxa" shouldn't be an I2C expander gpio please ?

Cheers.

--
Robert
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
