Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAFEC43331
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 04:40:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C59B2075C
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 04:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LScE/DwU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vwwGBNqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C59B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50CCE74C;
	Fri,  6 Sep 2019 06:39:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50CCE74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567744816;
	bh=XjnC43zLnvxNRMs1qj2eHZBhtUWMoEDt1w+PYkBEQvs=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LScE/DwUz048Ud6UXPYt9/hB0sN0bFNIVZ2Ae1kIW8ysY1qX8CV6sMGjJaqvki1vC
	 c1FJ/Guo3XqpM++XVE4X73Dnm1QPiSP3HJaccP9qfYkugb1GWsYvLTMEOYp/FXEXIX
	 3WwEXEbdhGqYy6uTQImoD3u6OHAWQao4LsM33DeY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E5ABF80390;
	Fri,  6 Sep 2019 06:39:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 126CAF80394; Fri,  6 Sep 2019 06:39:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FE27F80214
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 06:39:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FE27F80214
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vwwGBNqT"
Received: from localhost (unknown [223.226.32.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A683C2075C;
 Fri,  6 Sep 2019 04:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567744753;
 bh=WnaNo7a02OqVu6NIqH9DB42Dvl60OZUq73g617FYboQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vwwGBNqTbLExFqJXqUY/XKpIX5FhpFyRq+X2og3jTsO61MUZJOaD0bAZbwYTR5l6t
 iXs41ACqEsQwB93ZGOfw3ZKL7rB+PkTHQMqF6Quwl6W72bhW9UWyyd6xBK014m4EUA
 3UNbC5rdlwVt1DxzyqbrAQxkgyDL43bANP9MzdnY=
Date: Fri, 6 Sep 2019 10:08:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190906043805.GE2672@vkoul-mobl>
References: <20190905203527.1478314-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190905203527.1478314-1-arnd@arndb.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Cc: Takashi Iwai <tiwai@suse.de>, Sanyog Kale <sanyog.r.kale@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] soundwire: add back ACPI dependency
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

On 05-09-19, 22:35, Arnd Bergmann wrote:
> Soundwire gained a warning for randconfig builds without
> CONFIG_ACPI during the linux-5.3-rc cycle:
> 
> drivers/soundwire/slave.c:16:12: error: unused function 'sdw_slave_add' [-Werror,-Wunused-function]
> 
> Add the CONFIG_ACPI dependency at the top level now.

Did you run this yesterday or today. I have applied Srini's patches to
add DT support for Soundwire couple of days back so we should not see
this warning anymore

> Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soundwire/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index f518273cfbe3..c73bfbaa2659 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -5,6 +5,7 @@
>  
>  menuconfig SOUNDWIRE
>  	tristate "SoundWire support"
> +	depends on ACPI
>  	help
>  	  SoundWire is a 2-Pin interface with data and clock line ratified
>  	  by the MIPI Alliance. SoundWire is used for transporting data
> -- 
> 2.20.0

-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
