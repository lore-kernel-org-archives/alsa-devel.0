Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816D8C433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 08:38:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078B2206A4
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 08:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eeeO9BRn";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="bOL0rUpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078B2206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 905EB15E4;
	Mon,  8 Jun 2020 10:37:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 905EB15E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591605497;
	bh=YEVauygNN1HzApe1PfLzTfbRpb1psFJUqsG/0LV/Qbs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eeeO9BRnXI3HBNAbINThrpx8NPVl/lblYX3x1nck84CUhWhtJ7dFThB3Op96bNfJt
	 4z0fj2ywC+D89usM1kBmoZ2I1U/ptoShpamq+CewyzF35rov1r6WxVgderbC0TV3lW
	 HPQcRyiKW1SVg1pA35b9C/QUcKSXGPY+UQh/c1Fs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BCB9F801F7;
	Mon,  8 Jun 2020 10:37:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A96A8F8021C; Mon,  8 Jun 2020 10:37:25 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6215F80125
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 10:37:19 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A6E0BA003F;
 Mon,  8 Jun 2020 10:37:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A6E0BA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1591605436; bh=5YONdSBayq1L3qF6Gs4KnJaPFRC26InoNqL0U1y6Me8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=bOL0rUpTIqXMLYi9PeDLL7Esp0WMGkJf0eQZeqLlfnY1sNj35Hl91iboX0a6+5/XS
 H8HPrVTSE3X/CLbKwCW3x3+gWWb9xNxay4t7PKhm2XY0E7lMZgKsS08YEfNHGi8DCC
 FnTQR7rhL9l5pLo0VcF/TVi0o6PlmXUmNls1sqm4=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  8 Jun 2020 10:37:13 +0200 (CEST)
Subject: Re: [PATCH] ALSA: usb-audio: Use the new macro for HP Dock rename
 quirks
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20200608071513.570-1-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <3d4e9e2f-eec9-8018-7964-c09ab81c1240@perex.cz>
Date: Mon, 8 Jun 2020 10:37:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200608071513.570-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
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

Dne 08. 06. 20 v 9:15 Takashi Iwai napsal(a):
> Replace the open-code with the new QUIRK_DEVICE_PROFILE() macro for
> simplicity.
> 
> Fixes: 0c5086f56999 ("ALSA: usb-audio: Add vendor, product and profile name for HP Thunderbolt Dock")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---

Takashi, could we export the profile (hint) for new USB cards via the 
components string - snd_component_add()? The long name seems not appropriate 
for this. It's a GUI string (which is mangled now).

					Jaroslav

>   sound/usb/quirks-table.h | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index 90d65bfa733d..4ec491011b19 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -43,22 +43,14 @@
>   /* HP Thunderbolt Dock Audio Headset */
>   {
>   	USB_DEVICE(0x03f0, 0x0269),
> -	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
> -		.vendor_name = "HP",
> -		.product_name = "Thunderbolt Dock Audio Headset",
> -		.profile_name = "HP-Thunderbolt-Dock-Audio-Headset",
> -		.ifnum = QUIRK_NO_INTERFACE
> -	}
> +	QUIRK_DEVICE_PROFILE("HP", "Thunderbolt Dock Audio Headset",
> +			     "HP-Thunderbolt-Dock-Audio-Headset"),
>   },
>   /* HP Thunderbolt Dock Audio Module */
>   {
>   	USB_DEVICE(0x03f0, 0x0567),
> -	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
> -		.vendor_name = "HP",
> -		.product_name = "Thunderbolt Dock Audio Module",
> -		.profile_name = "HP-Thunderbolt-Dock-Audio-Module",
> -		.ifnum = QUIRK_NO_INTERFACE
> -	}
> +	QUIRK_DEVICE_PROFILE("HP", "Thunderbolt Dock Audio Module",
> +			     "HP-Thunderbolt-Dock-Audio-Module"),
>   },
>   /* FTDI devices */
>   {
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
