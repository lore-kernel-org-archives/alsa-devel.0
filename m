Return-Path: <SRS0=kQrV=I7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C864FC433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Apr 2021 17:58:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEA860240
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Apr 2021 17:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEA860240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 173B616C3;
	Fri,  2 Apr 2021 19:57:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 173B616C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617386307;
	bh=bgWvyp4NWCfYXfG0Hm8o+YMqPvpl1dahhItIpS576HQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X1q10PtYaiUay7u9njjPy73T16glIiokDwSPBEpPfYdw0BHn4QSMg2uib5kzn1egJ
	 1ISZFt/LaqGWDTlUG8+7nYr86efbdQIjpCRuhzutJig9Ayv9QAShiK4oD4j0BAlNbf
	 6TFjv2dzBV1T1J1d5wfBvpN9k0nLKElC5dpKhaV4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E43AF8016E;
	Fri,  2 Apr 2021 19:57:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C785F8016E; Fri,  2 Apr 2021 19:57:35 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F30F2F800F5
 for <alsa-devel@alsa-project.org>; Fri,  2 Apr 2021 19:57:26 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A592BA0046;
 Fri,  2 Apr 2021 19:57:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A592BA0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1617386245; bh=RVleIpY/mLf83IbsmzQeD3t+vKouLd0KP0S9kGC+PyI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ZO3ELAp+9aTtTlksGGNOMC/vhBK/6WQIH3zM4exTvo7pDYqIUbjsSpO4VrY32CnCv
 R3o2OI9le8BGs/DOeWGDSakT0tphzDuP+/CrVk2tNmvNhUq7zlLFTe2YVbrzHCfb5l
 c0sKHQT/ybGAeSH6V0QCFNzRtFAuIDduZNdL5auQ=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri,  2 Apr 2021 19:57:21 +0200 (CEST)
Subject: Re: [PATCH 1/2] ALSA: control - fix a leak in snd_ctl_led_init()
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <YGcDETcdqVUIl1+y@mwanda>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <ec7285f6-a257-d7a4-5cae-b36c95ef9efd@perex.cz>
Date: Fri, 2 Apr 2021 19:57:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YGcDETcdqVUIl1+y@mwanda>
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
> This unwind loop needs to free snd_ctl_leds[0] as well.
> 
> Fixes: cb17fe0045aa ("ALSA: control - add sysfs support to the LED trigger module")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  sound/core/control_led.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> index d4fb8b873f34..202b475d0bf3 100644
> --- a/sound/core/control_led.c
> +++ b/sound/core/control_led.c
> @@ -712,7 +712,7 @@ static struct snd_ctl_layer_ops snd_ctl_led_lops = {
>  static int __init snd_ctl_led_init(void)
>  {
>  	struct snd_ctl_led *led;
> -	unsigned int group;
> +	int group;
>  
>  	device_initialize(&snd_ctl_led_dev);
>  	snd_ctl_led_dev.class = sound_class;
> @@ -730,7 +730,7 @@ static int __init snd_ctl_led_init(void)
>  		dev_set_name(&led->dev, led->name);
>  		if (device_add(&led->dev)) {
>  			put_device(&led->dev);
> -			for (; group > 0; group--) {
> +			for (; group >= 0; group--) {
>  				led = &snd_ctl_leds[group];

It's not correct. This assignent should be 'led = &snd_ctl_leds[group - 1];'
without other changes, because the put_device() is enough when device_add() fails.

Could you resend the correction?

					Jaroslav

>  				device_del(&led->dev);
>  			}
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
