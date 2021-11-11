Return-Path: <SRS0=P3rz=P6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F83C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Nov 2021 09:36:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AACC610FC
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Nov 2021 09:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AACC610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50364950;
	Thu, 11 Nov 2021 10:35:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50364950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636623373;
	bh=f2WOsCCwl2Iy9ZeYqtjVqOZtMUAW+lPW9K/1lcAuXxI=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CfqLfJk6fhrVrpPRkj5pSo32tLFAVmS5a3LTFoDufAZ+qPZP+eFd4qWwPoqDU7cga
	 xMOdysX4WKIGdhaBID9lJVS+AeMxC8vEwnX4A6yWrvzpQhQ2elxkVWhnLqlbCH/40T
	 8US0hcoy1N5maJNzau8nioJu0MsV8bFjIiLlvPAg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2A2CF80224;
	Thu, 11 Nov 2021 10:35:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E134F802D2; Thu, 11 Nov 2021 10:35:21 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 211E7F800C1
 for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2021 10:35:09 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5047FA003F;
 Thu, 11 Nov 2021 10:35:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5047FA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1636623304; bh=X0r/OhcG/hGqEmmh+OUvPlUatgx1dk3DLzd7nHjA304=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ms7ZGLxlOM7/EC1boOUZunhq8sHWSPDWwVLynB3X1Nv3Lj7WMpvK+QuQHlfdojn7j
 Yd0O8LqeENpwsf1A3me3jnTiBboUr1Fc7Pa6XhTJS3xkGUyAviwlU2DRXI7hsstlyP
 9xCALEagExKUk+1KOv7fZ5Eig2G8xUfQpWkclpg8=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 11 Nov 2021 10:34:53 +0100 (CET)
Message-ID: <7e82a4cd-ed51-e853-7338-eb570c88cb68@perex.cz>
Date: Thu, 11 Nov 2021 10:34:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] ALSA: usb-audio: add the profile name of Dell desktop
Content-Language: en-US
To: shumingf@realtek.com, broonie@kernel.org, tiwai@suse.de,
 lgirdwood@gmail.com
References: <20211111091914.20917-1-shumingf@realtek.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20211111091914.20917-1-shumingf@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, Yijun.Shen@dell.com,
 flove@realtek.com
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

On 11. 11. 21 10:19, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> Add the profile name to let userspace pick correct UCM profile

It's no longer necessary to force the card names in the drivers. UCM can match 
the USB vendor / device IDs from the 'components' string, too.

I think that we should abandon this way of the UCM configuration selection for 
new devices with device IDs. The kernel already exports necessary information 
to select the right UCM configuration in the user space.

					Jaroslav

> 
> Signed-off-by: Shuming Fan <shumingf@realtek.com>
> ---
>   sound/usb/card.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 1764b9302d46..9c67ecbe710e 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -398,6 +398,10 @@ static const struct usb_audio_device_name usb_audio_names[] = {
>   	PROFILE_NAME(0x0bda, 0x4014, "Dell", "WD15 Dock", "Dell-WD15-Dock"),
>   	/* Dell WD19 Dock */
>   	PROFILE_NAME(0x0bda, 0x402e, "Dell", "WD19 Dock", "Dell-WD15-Dock"),
> +	/* Dell Desktop - Front */
> +	PROFILE_NAME(0x0bda, 0x4c54, "Dell", "Desktop", "Dell-Desktop-Front"),
> +	/* Dell Desktop - Rear */
> +	PROFILE_NAME(0x0bda, 0x4c55, "Dell", "Desktop", "Dell-Desktop-Rear"),
>   
>   	DEVICE_NAME(0x0ccd, 0x0028, "TerraTec", "Aureon5.1MkII"),

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
