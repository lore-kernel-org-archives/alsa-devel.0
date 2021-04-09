Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F5C433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 13:13:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D16861003
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 13:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D16861003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B12A1616;
	Fri,  9 Apr 2021 15:12:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B12A1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617974010;
	bh=v5MvtAaFrwm+iOHHXbGIjFaQm3LfmRDuN2FJ6NGt1mA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fqBbQC3VsrGEAbMbCZ5jpCLbt9xHEmW8oXtntFU1LFKh+x7eKmq+fQZMySHfP1PJM
	 q8ryPpCLUVKI/lAuSi+X0If7yG5I/yUXXGEeJxpgL0AxF2eElfati4r9maqulH35Lj
	 LHBPFM/rfPNDISK4bURfFMayI6lrnrvGw0AaSI4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3F98F80168;
	Fri,  9 Apr 2021 15:12:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DEC14F8016A; Fri,  9 Apr 2021 15:12:38 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53754F800EE
 for <alsa-devel@alsa-project.org>; Fri,  9 Apr 2021 15:12:29 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4E4DDA003F;
 Fri,  9 Apr 2021 15:12:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 4E4DDA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1617973949; bh=1oY7CphpfuhLCfc/L/XAyPe1KLJMszk6TMbYLW7dFhQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=VMLOxPivM5kyATp++ATCGz8nScrb9VErLdnBaBEanBbiwxQXnFjyhMClCK/RWwMKE
 hOqvf6UW+Cy4yCjt8RGic/vBM1hZytCnBq0BYZIkTD+V3a2+sxeAjx0OX222JrFIh0
 d0KK6zPxmUlu+GJ8iIhgnKT9lmVEnxiUFMW85q04=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri,  9 Apr 2021 15:12:25 +0200 (CEST)
Subject: Re: [PATCH 1/2 v2] ALSA: control - double free in snd_ctl_led_init()
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <YHBJ4frGxErWB182@mwanda>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <001a23ae-12de-5d7a-1095-4ab908841cd0@perex.cz>
Date: Fri, 9 Apr 2021 15:12:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHBJ4frGxErWB182@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>
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

Dne 09. 04. 21 v 14:34 Dan Carpenter napsal(a):
> "group - 1" was intended here instead of "group".  The current error
> handling will double free the first item in the array and leak the last
> item.
> 
> Fixes: cb17fe0045aa ("ALSA: control - add sysfs support to the LED trigger module")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> ---
> v2: The first patch wasn't right.  It fixed the leak but left the double
> free.
> 
>  sound/core/control_led.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> index d756a52e58db..93b201063c7d 100644
> --- a/sound/core/control_led.c
> +++ b/sound/core/control_led.c
> @@ -734,7 +734,7 @@ static int __init snd_ctl_led_init(void)
>  		if (device_add(&led->dev)) {
>  			put_device(&led->dev);
>  			for (; group > 0; group--) {
> -				led = &snd_ctl_leds[group];
> +				led = &snd_ctl_leds[group - 1];
>  				device_del(&led->dev);
>  			}
>  			device_del(&snd_ctl_led_dev);
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
