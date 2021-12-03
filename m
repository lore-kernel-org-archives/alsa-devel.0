Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA8BC4332F
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Dec 2021 14:46:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AC4222D5;
	Fri,  3 Dec 2021 15:46:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AC4222D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638542816;
	bh=7ydraca8lYoFiXgumJE6RxyE/SYwl8HxwGn32l/jJdI=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WD+UEmd/wLWSj5vuFW9ArSwtVXWchWMDRi9i7wWyTGtSz0peWxGHaYJiOQc2cgSR/
	 jFBb3LTTdn4LVji65k5/Vu2an99JTQoBf61hOFTSgoiRG4PVjC5+4t/sqGhZplbQ7k
	 214STx+y3W5wnUsL8e9QewGOK/vEc0oNTx5mZeTs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A29EF800D3;
	Fri,  3 Dec 2021 15:46:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2473F8028D; Fri,  3 Dec 2021 15:46:03 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB846F80249
 for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2021 15:45:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB846F80249
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Pl4pmwVC"
Received: by mail-lj1-x233.google.com with SMTP id k23so6669655lje.1
 for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2021 06:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=isVI3i0OnnF9HKk7LL+6nbdR6JnxGxIvGGvKoeFOlMs=;
 b=Pl4pmwVCPUPIF2AYBaEOUFoTbHtAE2VsxM7VpuSv/RBCkSZGX34k/NBdso9Tv0jLLp
 KEfLlxmt8wVHVSFloSOH3k4EUquj0I8STkq0WMMwVzKsMeju+DMyC5TA7JQnRrdqSl2N
 9mW9VNLaXAvL/hM/n7WVI5UdfY0ud0ZMFDeiKFuEgJDC3kiKR88r6DwHc0dB+rj+cLeo
 JQLU8JWgkQt7zRrFf8RKkLnTtanGE4fnIBJVJMKz4L42PwfhxNWGItUFBwNus9X0aw7s
 a5CjbPL1yMkybeauqRsYBInMN8tharIrL9coPnjWKcjZe6uRg86edJannynkQwJ8a1+/
 +fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=isVI3i0OnnF9HKk7LL+6nbdR6JnxGxIvGGvKoeFOlMs=;
 b=Fo6k+KpXESbWhzus/1zEu2n02ESZxfXPxVcs+k49PBjo+eGejzxpY6DN0Qkfea+6Cs
 mYhhERLFZ7NwHy9+9w9cmglDsUTFvAcOEJSidN1MpLXRN9+vhjWqYBoFsFazHmZNbcmu
 RyEkrdar1SC7db0v4pDcFFtIhpxK4D0JW1c+BdgH1hzGm+ECPg5nRs/+uMis5d4D6KJh
 FIlaU4mVTn+THwNUvpUggECbyq54yUT4H/Z7it3zl42DRuHlNyadvnEqG6sgIlAqOTZU
 YKZYZLcIrqIStYUOS1J9NwnC2ovdqT8zo1v9XO0ncorxclw28Tb3sh3vJAJbkqvtDcT4
 6yTw==
X-Gm-Message-State: AOAM531TWWiI7sHEIoQdVWVfJUmE9C65dgbvYbg1DXBVnAgLzH7+5TWW
 VKZNFHD49TyZp/IKfc9XW60=
X-Google-Smtp-Source: ABdhPJx3zBP2dIEW33Re8Np8HCSdfQ1NKxZT30mOLTPKIvqlbRVrKtuhDhGOeEjnvH9cBWodlZRg0w==
X-Received: by 2002:a2e:a7c8:: with SMTP id x8mr18583832ljp.524.1638542753575; 
 Fri, 03 Dec 2021 06:45:53 -0800 (PST)
Received: from [10.0.0.115] (91-153-170-164.elisa-laajakaista.fi.
 [91.153.170.164])
 by smtp.gmail.com with ESMTPSA id t69sm434642lff.110.2021.12.03.06.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 06:45:53 -0800 (PST)
Message-ID: <7dbddf9f-f8fc-f223-7f94-1e1f6382bc7e@gmail.com>
Date: Fri, 3 Dec 2021 16:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 2/2] ASoC: ti: davinci-mcasp: Remove unnecessary
 conditional
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
 <20211202205612.76216-2-andriy.shevchenko@linux.intel.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20211202205612.76216-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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



On 02/12/2021 22:56, Andy Shevchenko wrote:
> Instead of double validating of_node, return value of
> the boolean property directly.

Nice cleanup, thanks,
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> We can't remove ifdeffery, because in OF_GPIO=n cases
> it might bring unwanted surprises.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index 81c1ccec5904..3e105caac95e 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -1870,12 +1870,10 @@ static int mcasp_reparent_fck(struct platform_device *pdev)
>  static bool davinci_mcasp_have_gpiochip(struct davinci_mcasp *mcasp)
>  {
>  #ifdef CONFIG_OF_GPIO
> -	if (mcasp->dev->of_node &&
> -	    of_property_read_bool(mcasp->dev->of_node, "gpio-controller"))
> -		return true;
> -#endif
> -
> +	return of_property_read_bool(mcasp->dev->of_node, "gpio-controller");
> +#else
>  	return false;
> +#endif
>  }
>  
>  static int davinci_mcasp_get_config(struct davinci_mcasp *mcasp,
> 

-- 
Péter
