Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F55C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 17:16:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4126198E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 17:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4126198E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC26415F2;
	Mon, 22 Mar 2021 18:15:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC26415F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616433393;
	bh=4TUozX7ccRD2q3eR3NSkCJY5bSVqlkQmi9y8g5UNflE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qAV71LXz/xr7mw36X27kqY/nR+/Kk54iwZLg3TNz6GJeiPK89pQxl/SIGgMFGqvrh
	 sqx/UWifdrEV0ZS/LSrXxyWgDP8RYvG+s/YMmLiYE0VjMbemoytGQZdqlayYR4Ldy9
	 yYLLrDoOzal7cScJ0n+dKYa8igfW90Pt862sgsxQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3678AF80155;
	Mon, 22 Mar 2021 18:15:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F464F80155; Mon, 22 Mar 2021 18:15:42 +0100 (CET)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FCFFF80155
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 18:15:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FCFFF80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="lEd7EDNd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=ALxpnIbdgwKGvYkCqePRJ4vCsE0PnfX/ZLHTWQ+BL/s=; b=lEd7EDNdly8b1md0i3XZkQA1SI
 W5o0Sj2W7RS3edUrPdN9tVQzgarXA9xHkWUsolYlh5DkBff4py6222RkWQRhz4EHKhGCDM4Q5+pAI
 CQeLedNNQI/zTGEKNYXtFDHrrC0rXgSYmfnty0HCDQDh4nzWPj/Gg+1xUlky/nUdw4F6hCjlmmCPN
 GC2fcs4Sst6o1r6vB63gnWcMFjKeOYosWF9y5PzGrCNAhAUKH6aYduS9RJO9GbZf50VtD210Czewf
 t/jtILBYdQt2a8haNPMMpDmNSBtA23FRHA0nPE4k4c0K/oFwjSbU6NIZY62cqPi6nXQ0zbhxXEoUz
 V3hq/k6A==;
Received: from [2601:1c0:6280:3f0::3ba4]
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lOO91-008pWu-Cr; Mon, 22 Mar 2021 17:15:15 +0000
Subject: Re: [PATCH v5 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To: Perry Yuan <Perry.Yuan@dell.com>, pobrn@protonmail.com,
 pierre-louis.bossart@linux.intel.com, oder_chiou@realtek.com,
 perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com, mgross@linux.intel.com,
 Mario.Limonciello@dell.com
References: <20210322093841.11840-1-Perry_Yuan@Dell.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a1bdec21-efd9-ebf5-1b45-c0a364e0914c@infradead.org>
Date: Mon, 22 Mar 2021 10:15:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322093841.11840-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: platform-driver-x86@vger.kernel.org, alsa-devel@alsa-project.org,
 broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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

On 3/22/21 2:38 AM, Perry Yuan wrote:
> From: Perry Yuan <perry_yuan@dell.com>
> 

> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index e0a55337f51a..0e0f1eb35bd6 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -204,4 +204,20 @@ config DELL_WMI_SYSMAN
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called dell-wmi-sysman.
>  
> +config DELL_PRIVACY
> +	tristate "Dell Hardware Privacy Support"
> +	depends on ACPI
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	depends on DELL_LAPTOP
> +	depends on LEDS_TRIGGER_AUDIO
> +	select DELL_WMI
> +	help
> +	  This driver provides support for the "Dell Hardware Privacy" feature
> +	  of Dell laptops.
> +	  Support for a micmute and camera mute privacy will be provided as

better:
	                                                are provided as

> +	  hardware button Ctrl+F4 and Ctrl+F9 hotkey.

Does that say that Ctrl+F4 is a hardware button
and that Ctrl+F9 is a hotkey?
If so, what's the difference? and why?  Are they different
hardware implementations?  Does the user care?

> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called dell_privacy.
>  endif # X86_PLATFORM_DRIVERS_DELL
thanks.
-- 
~Randy

