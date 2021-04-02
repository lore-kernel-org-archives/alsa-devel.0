Return-Path: <SRS0=kQrV=I7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BDDC433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Apr 2021 17:53:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549E161152
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Apr 2021 17:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549E161152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DA2E16C2;
	Fri,  2 Apr 2021 19:53:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DA2E16C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617386034;
	bh=gBYxzFXInPx2C9Y4wu+2XGaAE/dnqQu7NnSFvkK5qBQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RoXl19MUiBJQNjksHuxvcxJ6iJaEuXiwbILHGHFqLddZriyE2vbZ1a6/ViGOhShvy
	 En7UaTn99jeUs6IezvyUCpWNjBNX62G8FgricZl4hzMEJYAm0gmY31cMnUqbZRqA2G
	 l9PMeZ2IQcx3FGHW7IVPAfVWKw39/adLHgBGfDsY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22461F8016E;
	Fri,  2 Apr 2021 19:53:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C805F801DB; Fri,  2 Apr 2021 19:53:02 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 420AFF80166
 for <alsa-devel@alsa-project.org>; Fri,  2 Apr 2021 19:52:50 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 88DD9A003F;
 Fri,  2 Apr 2021 19:52:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 88DD9A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1617385969; bh=hmdcuQjKCB8a38gz7Nli+mM4SdKS5+dTRB3Z0DNd5Kw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Kp0rqUhBND6xL6fr6ykEzNIz8ZPSzKYyXWrJiN99xWmhHmW0ThYR0AxJxZZOb03FX
 LEA00oGHm0Ghtu5RYWolMAR5+BPnH1UZPBEZbKhiGkri14XKdEYeAB4UE9EmO+682t
 lojSpD3MzO7Q/ThDIwgZR1y3tDXCqsTGAA9NTkFg=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri,  2 Apr 2021 19:52:43 +0200 (CEST)
Subject: Re: [PATCH 2/2] ALSA: control - off by one in store_mode()
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <YGcDOtrimR46vr0k@mwanda>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <70b1e440-030c-9cbf-e193-79f2955a5331@perex.cz>
Date: Fri, 2 Apr 2021 19:52:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YGcDOtrimR46vr0k@mwanda>
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

Dne 02. 04. 21 v 13:42 Dan Carpenter napsal(a):
> If count is 16 then this will put the NUL terminator one element beyond
> the end of the array.
> 
> Fixes: cb17fe0045aa ("ALSA: control - add sysfs support to the LED trigger module")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

No idea why I added + 1... Thanks for your correction.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> ---
>  sound/core/control_led.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> index 202b475d0bf3..ab5a455723c8 100644
> --- a/sound/core/control_led.c
> +++ b/sound/core/control_led.c
> @@ -391,7 +391,7 @@ static ssize_t store_mode(struct device *dev, struct device_attribute *attr,
>  {
>  	struct snd_ctl_led *led = container_of(dev, struct snd_ctl_led, dev);
>  	char _buf[16];
> -	size_t l = min(count, sizeof(_buf) - 1) + 1;
> +	size_t l = min(count, sizeof(_buf) - 1);
>  	enum snd_ctl_led_mode mode;
>  
>  	memcpy(_buf, buf, l);
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
