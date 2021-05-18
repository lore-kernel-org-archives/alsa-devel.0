Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B54C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 18:01:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C04611B0
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 18:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C04611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1EE7176B;
	Tue, 18 May 2021 20:00:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1EE7176B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621360909;
	bh=yDSRtmmg/LleY/Sq9ohvuojvY0MT1/Bga+uC5PA3XYM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hcxgfbxOZj5Otna953g7gi2Jh+5pkBLtOsL8t+2/3d6ZEgoRK0e5F2MQBIO8obG/R
	 S4J/Mwv3QrwXYprn26COb11tVq5zDNeFfopI4Q2vhv9KQn/nmgGrFxX0/jR0qdRgd5
	 UZ4U+3nyzrHc4y0MJEZy0TEBVW10EUmm3IQsl16U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34E93F801DB;
	Tue, 18 May 2021 20:00:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA630F80217; Tue, 18 May 2021 20:00:56 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1890DF80139
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 20:00:50 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id CE932A003F;
 Tue, 18 May 2021 20:00:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz CE932A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1621360849; bh=zZ9DyssB1yau3QpCY8XmWm8WwFs6+y9kB7NXmdVw3Ac=;
 h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
 b=ybaE0Io3Wv+0lLstk3LNdxcxNAkUynHUl8/OZyh1qZW2d2D+GAxaACijjEBkLEBYw
 l7T31sDXJQUNkPso5nOe1nUDqLAHXTxUv5128HeImfeY+xzypPAfDDW0biIfRPi68H
 jLdd+DOUeZUmauMuQjJJIiWY2PgOHdU4EFV+Vdnc=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 18 May 2021 20:00:46 +0200 (CEST)
Subject: Re: [PATCH 2/7] ALSA: control: Add power state check commonly for
 ioctl handlers
To: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20210518165201.24376-1-tiwai@suse.de>
 <20210518165201.24376-3-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <b9dcb895-09a2-b9b7-b509-9d6bb0bb8542@perex.cz>
Date: Tue, 18 May 2021 20:00:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518165201.24376-3-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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

Dne 18. 05. 21 v 18:51 Takashi Iwai napsal(a):
> The card power state check can be better put in the common ioctl
> handler, as basically we want to prevent ioctls during the power off
> state.  Although this situation won't happen normally any longer (*),
> it'll be helpful for catching this for the future implementation like
> the faked suspend that is needed for PCI rescan.
> 
> (*) Long long time ago, before the proper PM framework was introduced,
> it was still possible to reach SNDRV_CTL_IOCTL_POWER ioctl during the
> power off state.  This ioctl existed as a main control for the suspend
> resume state in the past, but the feature was already dropped along
> with the standard PM framework.

It seems like a function dup for the 5th patch which tracks in flight the
power state. I think that we should drop this (and reshuffle patches) or
remove this in or after the 5th patch.

					Jaroslav

> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/control.c        | 3 +++
>  sound/core/control_compat.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/sound/core/control.c b/sound/core/control.c
> index 498e3701514a..c22c3fad0c64 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -1772,6 +1772,9 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
>  	card = ctl->card;
>  	if (snd_BUG_ON(!card))
>  		return -ENXIO;
> +	err = snd_power_wait(card, SNDRV_CTL_POWER_D0);
> +	if (err < 0)
> +		return err;
>  	switch (cmd) {
>  	case SNDRV_CTL_IOCTL_PVERSION:
>  		return put_user(SNDRV_CTL_VERSION, ip) ? -EFAULT : 0;
> diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
> index 1d708aab9c98..d5b562ff237b 100644
> --- a/sound/core/control_compat.c
> +++ b/sound/core/control_compat.c
> @@ -438,6 +438,9 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
>  	if (snd_BUG_ON(!ctl || !ctl->card))
>  		return -ENXIO;
>  
> +	err = snd_power_wait(ctl->card, SNDRV_CTL_POWER_D0);
> +	if (err < 0)
> +		return err;
>  	switch (cmd) {
>  	case SNDRV_CTL_IOCTL_PVERSION:
>  	case SNDRV_CTL_IOCTL_CARD_INFO:
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
