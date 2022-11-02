Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D661BC4332F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Nov 2022 11:54:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B43F1632;
	Wed,  2 Nov 2022 12:54:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B43F1632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667390090;
	bh=iteCe8k0ZywoWHNHBSGmdbDzeNT0DW7P9ZgHpVZ3vac=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bfsH3zVOj2Lh8mrXDdS0EOa2+EgOmDo9A4lbqkw9LQF89WkPRvy+w8GoPZjC8mx1s
	 f/Kz/Y1ALIuj0TwdPImLOPeS6oGGqjWJpn8hTGqi0LHGmVju3YEv9LsnelFtYyllTS
	 /YYqtkuu+HXkA4nL/S8hQ22vK15Ykw9nhmPnIenc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB86BF80254;
	Wed,  2 Nov 2022 12:53:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5027BF80155; Wed,  2 Nov 2022 12:53:58 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B52EF80155
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2022 12:53:51 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5F3F7A003F;
 Wed,  2 Nov 2022 12:53:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5F3F7A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1667390031; bh=wwHH6HzdS6vKb+7Wuf3bIp76k+1gEA+1PUmHzLYsO9I=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=N9a/DTxXcrkt7J+opUs64qMHQ9/DCEDHhLEmQhMa5Eiaz5vKTG3uP9TQo3Ldsf3VJ
 cvAMHxHTQrTezpHZRjeiT/Iv12Kc8aWXdJlXdWEaUaDliRnMcGeQQSirNL2hyzYa+i
 d2DHn9L6iOV8rDtGptbepRd8XQQtjaiGOPTd9+m0=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  2 Nov 2022 12:53:49 +0100 (CET)
Message-ID: <9b0c4f2d-1856-a80d-ad9d-9b34436fdc1c@perex.cz>
Date: Wed, 2 Nov 2022 12:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: usb-audio: Fix regression with Dell Dock jack
 detection
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20221102113404.11291-1-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221102113404.11291-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 02. 11. 22 12:34, Takashi Iwai wrote:
> The recent commit added Jack controls to Dell Dock, but it added with
> iface = SNDRV_CTL_ELEM_IFACE_CARD.  Unfortunately this doesn't match
> with the changes in user-space UCM profile, which expects iface =
> SNDRV_CTL_ELEM_IFACE_MIXER as default.  This mismatch resulted in the
> non-working profile, and the Dell Dock is gone on pipewire /
> PulseAudio after the kernel update.
> 
> Fix the regression by adjusting the iface of the new ctl elements to
> *_MIXER.

Hi Takashi,

UCM expects SNDRV_CTL_ELEM_IFACE_CARD for jacks by default. Which change do 
you refer? I would drop this patch.

					Thanks,
						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
